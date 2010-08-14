From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/16] Prettify the option setting loop in dracut.
Date: Sat, 14 Aug 2010 14:23:26 -0500 (CDT)
Message-ID: <7fb2a9ae46c3f5c5ffaae00f5089dbb6cfa0756c.1281812506.git.victor.lowther@gmail.com>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:subject:to:x-mailer:date;
        bh=ltjlC8Nuj92VIOBXUnZvrasJw14Sfqeg6sZ/74zDXaM=;
        b=wKnup7dacmhq+MO9BNP/mgPpH+Zj5rY1/GP3rBGoM5lfvCqKQQxx2fd4juckAdN9cC
         TAcbedgqGGc2QxJ0Igu7tazx79eR70U92Qm2KTBWwiNf2ED/DfTMzGdypDgLi3Kqe1SP
         tnuPZLXKNOwfrljXYoCAFz5eWOwIEmyeoIeXg=
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

THis just makes the args line up all nice and pretty.

---
 dracut |   60 ++++++++++++++++++++++++++++++------------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/dracut b/dracut
index 1a30cc7..fcd32c1 100755
--- a/dracut
+++ b/dracut
@@ -109,41 +109,41 @@ read_arg() {
 
 while (($# > 0)); do
     case ${1%%=*} in
-	-f|--force) force=yes;;
-	-m|--modules) read_arg dracutmodules_l "$@" ||shift;;
-	-o|--omit) read_arg omit_dracutmodules_l "$@" || shift;;
-	-a|--add) read_arg add_dracutmodules_l "$@" || shift;;
-	-d|--drivers) read_arg drivers_l "$@" || shift;;
-	--add-drivers) read_arg add_drivers_l "$@" || shift;;
-	--filesystems) read_arg filesystems_l "$@" || shift;;
-	-k|--kmoddir) read_arg drivers_dir_l "$@" || shift;;
-	--fwdir) read_arg fw_dir_l "$@" || shift;;
+	-m|--modules)  read_arg dracutmodules_l      "$@" || shift;;
+	-o|--omit)     read_arg omit_dracutmodules_l "$@" || shift;;
+	-a|--add)      read_arg add_dracutmodules_l  "$@" || shift;;
+	-d|--drivers)  read_arg drivers_l            "$@" || shift;;
+	--add-drivers) read_arg add_drivers_l        "$@" || shift;;
+	--filesystems) read_arg filesystems_l        "$@" || shift;;
+	-k|--kmoddir)  read_arg drivers_dir_l        "$@" || shift;;
+	-c|--conf)     read_arg conffile             "$@" || shift;;
+	--confdir)     read_arg confdir              "$@" || shift;;
+	-I|--install)  read_arg install_items        "$@" || shift;;
+	--fwdir)       read_arg fw_dir_l             "$@" || shift;;
+	-f|--force)    force=yes;;
 	--kernel-only) kernel_only="yes"; no_kernel="no";;
-	--no-kernel) kernel_only="no"; no_kernel="yes";;
+	--no-kernel)   kernel_only="no"; no_kernel="yes";;
+	--strip)       do_strip_l="yes";;
+	--nostrip)     do_strip_l="no";;
+        --mdadmconf)   mdadmconf_l="yes";;
+        --nomdadmconf) mdadmconf_l="no";;
+        --lvmconf)     lvmconf_l="yes";;
+        --nolvmconf)   lvmconf_l="no";;
+	--debug)       debug="yes";;
+	-v|--verbose)  beverbose="yes";;
+	-l|--local)    allowlocal="yes" ;;
+	-H|--hostonly) hostonly_l="yes" ;;
+	--fstab)       use_fstab_l="yes" ;;
+	-h|--help)     usage; exit 1 ;;
+	-i|--include)  include_src="$2"; include_target="$3"; shift 2;;
+        --gzip)        [[ $compress != cat ]] && compress="gzip -9";;
+        --bzip2)       [[ $compress != cat ]] && compress="bzip2 -9";;
+        --xz)          [[ $compress != cat ]] && compress="xz -9";;
+        --no-compress) compress="cat";;
         --ignore-kernel-modules) kernel_only="no"; no_kernel="yes"
             ignore_kmodules="yes"
             omit_dracutmodules_l+=\ kernel-modules
             ;;
-	--strip) do_strip_l="yes";;
-	--nostrip) do_strip_l="no";;
-        --mdadmconf) mdadmconf_l="yes";;
-        --nomdadmconf) mdadmconf_l="no";;
-        --lvmconf) lvmconf_l="yes";;
-        --nolvmconf) lvmconf_l="no";;
-	-h|--help) usage; exit 1 ;;
-	--debug) debug="yes";;
-	-v|--verbose) beverbose="yes";;
-	-c|--conf) read_arg conffile "$@" || shift;;
-	--confdir) read_arg confdir "$@" || shift;;
-	-l|--local) allowlocal="yes" ;;
-	-H|--hostonly) hostonly_l="yes" ;;
-	--fstab) use_fstab_l="yes" ;;
-	-i|--include) include_src="$2"; include_target="$3"; shift 2;;
-	-I|--install) read_arg install_items "$@" || shift;;
-        --gzip) [[ $compress != cat ]] && compress="gzip -9";;
-        --bzip2) [[$compress != cat ]] && compress="bzip2 -9";;
-        --xz) [[ $compress != cat ]] && compress="xz -9";;
-        --no-compress) compress="cat";;
 	-*) printf "\nUnknown option: %s\n\n" "$1" >&2; usage; exit 1;;
 	*) break ;;
     esac
-- 
1.7.2.1
