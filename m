From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] add --tmpdir option to cmd line args and tmpdir to config file
Date: Mon, 26 Mar 2012 14:28:35 +0200
Message-ID: <1332764916-22282-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Default temporary directory used by Dracut is /var/tmp, but users might
want to change it to /tmp.
---
 dracut.conf |    2 ++
 dracut.sh   |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dracut.conf b/dracut.conf
index a502066..1ee563e 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -38,3 +38,5 @@ lvmconf="yes"
 
 # inhibit installation of any fsck tools
 #nofscks="yes"
+
+tmpdir=/tmp
diff --git a/dracut.sh b/dracut.sh
index 1bf8ad9..5887131 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -80,6 +80,8 @@ Creates initial ramdisk images for preloading modules
                          Default: /etc/dracut.conf
   --confdir [DIR]       Specify configuration directory to use *.conf files
                          from. Default: /etc/dracut.conf.d
+  --tmpdir [DIR]        Temporary directory to be used instead of default
+                         /var/tmp.
   -l, --local           Local mode. Use modules from the current working
                          directory instead of the system-wide installed in
                          /usr/lib/dracut/modules.d.
@@ -225,6 +227,7 @@ while (($# > 0)); do
         -k|--kmoddir)  read_arg drivers_dir_l        "$@" || shift;;
         -c|--conf)     read_arg conffile             "$@" || shift;;
         --confdir)     read_arg confdir              "$@" || shift;;
+        --tmpdir)      read_arg tmpdir_l             "$@" || shift;;
         -L|--stdlog)   read_arg stdloglvl_l          "$@" || shift;;
         --compress)    read_arg compress_l           "$@" || shift;;
         --prefix)      read_arg prefix_l             "$@" || shift;;
@@ -411,6 +414,8 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 [[ $lvmconf_l ]] && lvmconf=$lvmconf_l
 [[ $dracutbasedir ]] || dracutbasedir=/usr/lib/dracut
 [[ $fw_dir ]] || fw_dir="/lib/firmware/updates /lib/firmware"
+[[ $tmpdir_l ]] && tmpdir="$tmpdir_l"
+[[ $tmpdir ]] || tmpdir=/var/tmp
 [[ $do_strip ]] || do_strip=no
 [[ $compress_l ]] && compress=$compress_l
 [[ $show_modules_l ]] && show_modules=$show_modules_l
@@ -544,8 +549,8 @@ elif [[ -f "$outfile" && ! -w "$outfile" ]]; then
     exit 1
 fi
 
-readonly TMPDIR=/var/tmp
-readonly initdir=$(mktemp --tmpdir=/var/tmp/ -d -t initramfs.XXXXXX)
+readonly TMPDIR="$tmpdir"
+readonly initdir=$(mktemp --tmpdir="$TMPDIR/" -d -t initramfs.XXXXXX)
 [ -d "$initdir" ] || {
     dfatal "mktemp failed."
     exit 1
-- 
1.7.8.5
