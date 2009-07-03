From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC ONLY 2/5] netroot: remove unhelpful argument checks
Date: Fri,  3 Jul 2009 17:40:02 -0400
Message-ID: <0535c73bd25fdcaa9bf4de0bc4b041b74d11e547.1246656269.git.dave@thedillows.org>
References: <cover.1246656269.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
In-Reply-To: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
References: <cover.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>

The argument checks for the network root handlers are not very useful, as
there is no error message; things just fail to work. Since this should only
ever be a problem when developing dracut, it is not too unfriendly to expect
developers to add rdnetdebug to the command line when working on this area.

Remove them for now, as the arguments will be going through some flux and
we can add them back later with more helpful messages if it is desired.
---
 modules.d/95iscsi/iscsiroot |   10 ----------
 modules.d/95nbd/nbdroot     |    9 ---------
 modules.d/95nfs/nfsroot     |    9 ---------
 3 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index c66f9d2..2b041cc 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -16,16 +16,6 @@ if getarg rdnetdebug; then
     set -x
 fi
 
-# Huh? Empty $1?
-[ -z "$1" ] && exit 1
-
-# Huh? Empty $2?
-[ -z "$2" ] && exit 1
-
-# Huh? Empty $3? This isn't really necessary, since NEWROOT isn't 
-# used here. But let's be consistent
-[ -z "$3" ] && exit 1
-
 # root is in the form root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
 netif="$1"
 root="$2"
diff --git a/modules.d/95nbd/nbdroot b/modules.d/95nbd/nbdroot
index 90f6ef8..c7f24e8 100755
--- a/modules.d/95nbd/nbdroot
+++ b/modules.d/95nbd/nbdroot
@@ -10,15 +10,6 @@ if getarg rdnetdebug; then
     set -x
 fi
 
-# Huh? Empty $1?
-[ -z "$1" ] && exit 1
-
-# Huh? Empty $2?
-[ -z "$2" ] && exit 1
-
-# Huh? Empty $3?
-[ -z "$3" ] && exit 1
-
 # root is in the form root=nbd:srv:port[:fstype[:rootflags[:nbdopts]]]
 netif="$1"
 root="$2"
diff --git a/modules.d/95nfs/nfsroot b/modules.d/95nfs/nfsroot
index 0da8ee3..f005378 100755
--- a/modules.d/95nfs/nfsroot
+++ b/modules.d/95nfs/nfsroot
@@ -48,15 +48,6 @@ if getarg rdnetdebug ; then
     set -x
 fi
 
-# Huh? Empty $1?
-[ -z "$1" ] && exit 1
-
-# Huh? Empty $2?
-[ -z "$2" ] && exit 1
-
-# Huh? Empty $3?
-[ -z "$3" ] && exit 1
-
 # root is in the form root=nfs[4]:[server:]path[:options], either from
 # cmdline or dhcp root-path
 netif="$1"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
