From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] iscsiadm, iscsid: newroot command to survive switch_root
Date: Mon, 10 Dec 2012 14:08:34 -0800
Message-ID: <1355177316-25803-3-git-send-email-cleech@redhat.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355177316-25803-1-git-send-email-cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

When started from initramfs, iscsid needs to be able to chroot itself
to the runtime filesystem before the switch_root occurs.  In the
initramfs "iscsiadm --newroot {root fs mount before switch}" should be
called before the switch_root.
---
 usr/iscsiadm.c | 30 +++++++++++++++++++++++++++++-
 usr/mgmt_ipc.c | 11 +++++++++++
 usr/mgmt_ipc.h |  6 +++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/usr/iscsiadm.c b/usr/iscsiadm.c
index 8f9de05..7b601b3 100644
--- a/usr/iscsiadm.c
+++ b/usr/iscsiadm.c
@@ -111,9 +111,10 @@ static struct option const long_options[] =
 	{"packetsize", required_argument, NULL, 'b'},
 	{"count", required_argument, NULL, 'c'},
 	{"interval", required_argument, NULL, 'i'},
+	{"newroot", required_argument, NULL, 'N'},
 	{NULL, 0, NULL, 0},
 };
-static char *short_options = "RlDVhm:a:b:c:C:p:P:T:H:i:I:U:k:L:d:r:n:v:o:sSt:u";
+static char *short_options = "RlDVhm:a:b:c:C:p:P:T:H:i:I:U:k:L:d:r:n:v:o:sSt:uN:";
 
 static void usage(int status)
 {
@@ -251,6 +252,22 @@ static void kill_iscsid(int priority)
 	}
 }
 
+static void do_newroot(char *newroot)
+{
+	iscsiadm_req_t req;
+	iscsiadm_rsp_t rsp;
+	int rc;
+
+	memset(&req, 0, sizeof(req));
+	req.command = MGMT_IPC_NEWROOT;
+	strncpy(req.u.newroot.path, newroot, PATH_MAX);
+	rc = iscsid_exec_req(&req, &rsp, 0);
+	if (rc) {
+		iscsi_err_print_msg(rc);
+		log_error("Could not send NEWROOT command");
+	}
+}
+
 /*
  * TODO: we can display how the ifaces are related to node records.
  * And we can add a scsi_host mode which would display how
@@ -2411,6 +2428,7 @@ main(int argc, char **argv)
 	uint32_t host_no = -1;
 	struct user_param *param;
 	struct list_head params;
+	char *newroot = NULL;
 
 	INIT_LIST_HEAD(&params);
 	INIT_LIST_HEAD(&ifaces);
@@ -2433,6 +2451,9 @@ main(int argc, char **argv)
 	while ((ch = getopt_long(argc, argv, short_options,
 				 long_options, &longindex)) >= 0) {
 		switch (ch) {
+		case 'N':
+			newroot = strndup(optarg, PATH_MAX);
+			break;
 		case 'k':
 			killiscsid = atoi(optarg);
 			if (killiscsid < 0) {
@@ -2579,6 +2600,13 @@ main(int argc, char **argv)
 		goto free_ifaces;
 	}
 
+	if (newroot) {
+		do_newroot(newroot);
+		free(newroot);
+		newroot = NULL;
+		goto free_ifaces;
+	}
+
 	if (mode < 0)
 		usage(ISCSI_ERR_INVAL);
 
diff --git a/usr/mgmt_ipc.c b/usr/mgmt_ipc.c
index f34f688..b4170ce 100644
--- a/usr/mgmt_ipc.c
+++ b/usr/mgmt_ipc.c
@@ -226,6 +226,16 @@ mgmt_ipc_immediate_stop(queue_task_t *qtask)
 }
 
 static int
+mgmt_ipc_newroot(queue_task_t *qtask)
+{
+	char *newroot = qtask->req.u.newroot.path;
+	if (chdir(newroot) || chroot(".") || chdir("/"))
+		return ISCSI_ERR;
+	mgmt_ipc_write_rsp(qtask, ISCSI_SUCCESS);
+	return ISCSI_SUCCESS;
+}
+
+static int
 mgmt_ipc_conn_remove(queue_task_t *qtask)
 {
 	return ISCSI_ERR;
@@ -534,6 +544,7 @@ static mgmt_ipc_fn_t *	mgmt_ipc_functions[__MGMT_IPC_MAX_COMMAND] = {
 [MGMT_IPC_NOTIFY_DEL_NODE]	= mgmt_ipc_notify_del_node,
 [MGMT_IPC_NOTIFY_ADD_PORTAL]	= mgmt_ipc_notify_add_portal,
 [MGMT_IPC_NOTIFY_DEL_PORTAL]	= mgmt_ipc_notify_del_portal,
+[MGMT_IPC_NEWROOT]		= mgmt_ipc_newroot,
 };
 
 void mgmt_ipc_handle(int accept_fd)
diff --git a/usr/mgmt_ipc.h b/usr/mgmt_ipc.h
index 55972ed..102ffff 100644
--- a/usr/mgmt_ipc.h
+++ b/usr/mgmt_ipc.h
@@ -22,6 +22,7 @@
 #include "types.h"
 #include "iscsi_if.h"
 #include "config.h"
+#include "limits.h"
 
 #define ISCSIADM_NAMESPACE	"ISCSIADM_ABSTRACT_NAMESPACE"
 #define PEERUSER_MAX		64
@@ -46,6 +47,7 @@ typedef enum iscsiadm_cmd {
 	MGMT_IPC_NOTIFY_DEL_NODE	= 17,
 	MGMT_IPC_NOTIFY_ADD_PORTAL	= 18,
 	MGMT_IPC_NOTIFY_DEL_PORTAL	= 19,
+	MGMT_IPC_NEWROOT		= 20,
 
 	__MGMT_IPC_MAX_COMMAND
 } iscsiadm_cmd_e;
@@ -75,8 +77,10 @@ typedef struct iscsiadm_req {
 			int param;
 			/* TODO: make this variable len to support */
 			char value[IFNAMSIZ + 1];
-
 		} set_host_param;
+		struct ipc_msg_newroot {
+			char path[PATH_MAX + 1];
+		} newroot;
 	} u;
 } iscsiadm_req_t;
 
-- 
1.7.11.7
