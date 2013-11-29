From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 08/13] Make logfile configurable
Date: Fri, 29 Nov 2013 13:13:49 +0100
Message-ID: <1385727234-5001-9-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Add '--logfile' option to make the log file configurable during
runtime.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 dracut.8.asc | 6 ++++++
 dracut.sh    | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/dracut.8.asc b/dracut.8.asc
index 2ea6744..d381dcf 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -275,6 +275,12 @@ Default:
=20
 **--sshkey**=C2=A0_<sshkey file>_:: ssh key file used with ssh-client =
module.
=20
+**--logfile**=C2=A0_<logfile>_:: logfile to use; overrides any setting=
 from
+    the configuration files.
++
+Default:
+    _/var/log/dracut.log_
+
 **-l, --local**::
     activates the local mode. dracut will use modules from the current=
 working
     directory instead of the system-wide installed modules in
diff --git a/dracut.sh b/dracut.sh
index bce2662..5f63d94 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -183,6 +183,7 @@ Creates initial ramdisk images for preloading modul=
es
   --keep                Keep the temporary initramfs for debugging pur=
poses
   --printsize           Print out the module install size
   --sshkey [SSHKEY]     Add ssh key to initramfs (use with ssh-client =
module)
+  --logfile [FILE]      Logfile to use (overrides configuration settin=
g)
=20
 If [LIST] has multiple arguments, then you have to put these in quotes=
=2E
=20
@@ -335,6 +336,7 @@ TEMP=3D$(unset POSIXLY_CORRECT; getopt \
     --long debug \
     --long profile \
     --long sshkey: \
+    --long logfile: \
     --long verbose \
     --long quiet \
     --long local \
@@ -418,6 +420,7 @@ while :; do
         --debug)       debug=3D"yes";;
         --profile)     profile=3D"yes";;
         --sshkey)      sshkey=3D"$2"; shift;;
+        --logfile)     logfile_l=3D"$2"; shift;;
         -v|--verbose)  ((verbosity_mod_l++));;
         -q|--quiet)    ((verbosity_mod_l--));;
         -l|--local)
@@ -690,6 +693,7 @@ stdloglvl=3D$((stdloglvl + verbosity_mod_l))
 [[ $ro_mnt_l ]] && ro_mnt=3D"yes"
 [[ $early_microcode_l ]] && early_microcode=3D$early_microcode_l
 [[ $early_microcode ]] || early_microcode=3Dno
+[[ $logfile_l ]] && logfile=3D"$logfile_l"
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=3D${fw_dir//:/ }
=20
--=20
1.8.1.4
