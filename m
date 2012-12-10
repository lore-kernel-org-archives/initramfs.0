From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC] iscsid: add --initrd option to set run from initrd hint for systemd
Date: Mon, 10 Dec 2012 14:08:33 -0800
Message-ID: <1355177316-25803-2-git-send-email-cleech@redhat.com>
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

See http://www.freedesktop.org/wiki/Software/systemd/RootStorageDaemons
---
 usr/iscsid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/usr/iscsid.c b/usr/iscsid.c
index b4bb65b..7d71085 100644
--- a/usr/iscsid.c
+++ b/usr/iscsid.c
@@ -61,6 +61,7 @@ static pid_t log_pid;
 static gid_t gid;
 static int daemonize = 1;
 static int mgmt_ipc_fd;
+static int initrd = 0;
 
 static struct option const long_options[] = {
 	{"config", required_argument, NULL, 'c'},
@@ -73,6 +74,7 @@ static struct option const long_options[] = {
 	{"pid", required_argument, NULL, 'p'},
 	{"help", no_argument, NULL, 'h'},
 	{"version", no_argument, NULL, 'v'},
+	{"initrd", no_argument, &initrd, 1},
 	{NULL, 0, NULL, 0},
 };
 
@@ -95,6 +97,7 @@ Open-iSCSI initiator daemon.\n\
   -p, --pid=pidfile       use pid file (default " PID_FILE ").\n\
   -h, --help              display this help and exit\n\
   -v, --version           display version and exit\n\
+  --initrd                run from initrd\n\
 ");
 	}
 	exit(status);
@@ -383,12 +386,17 @@ int main(int argc, char *argv[])
 		case 'h':
 			usage(0);
 			break;
+		case 0:
+			break;
 		default:
 			usage(1);
 			break;
 		}
 	}
 
+	if (initrd)
+		argv[0][0] = '@';
+
 	/* initialize logger */
 	log_pid = log_init(program_name, DEFAULT_AREA_SIZE,
 		      daemonize ? log_do_log_daemon : log_do_log_std, NULL);
-- 
1.7.11.7
