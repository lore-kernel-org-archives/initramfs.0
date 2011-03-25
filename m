From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 2/9] dracut: when stdloglvl not set defaulted to 0 - should be 4
Date: Fri, 25 Mar 2011 15:56:45 +0100
Message-ID: <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Removed unnecessary stdloglvl default in dracut.conf.
---
 dracut      |    1 +
 dracut.conf |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 9ef6d61..192c5b5 100755
--- a/dracut
+++ b/dracut
@@ -332,6 +332,7 @@ if (( ${#fw_dir_l[@]} )); then
 fi
 
 [[ $stdloglvl_l ]] && stdloglvl=$stdloglvl_l
+[[ ! $stdloglvl ]] && stdloglvl=4
 stdloglvl=$((stdloglvl + verbosity_mod_l))
 ((stdloglvl > 6)) && stdloglvl=6
 ((stdloglvl < 0)) && stdloglvl=0
diff --git a/dracut.conf b/dracut.conf
index cca7359..89ceaab 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -2,7 +2,6 @@
 
 logfile=/var/log/dracut.log
 fileloglvl=6
-stdloglvl=3
 
 # Specific list of dracut modules to use
 #dracutmodules+=""
-- 
1.7.4.1
