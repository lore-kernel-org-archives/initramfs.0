From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [PATCH] dracut-gencmdline: fix regex quoting in findstoragedriver()
Date: Thu, 29 Oct 2009 11:25:53 +0000
Message-ID: <4AE97BC1.6010205@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=HKSou6p4kHuda8Fo0v3rDGrfGsOgvsWTsQyHBe/fVmY=;
        b=mAj5EJilc0bXYwKYSW/JkmJmZnK+B5XIZb7D5HzxY+PLzTQLBSS0D+Fxfgk/as8021
         mBTn/iwfL6zQ7BSGs7omlqkZVEg8Ns/xfc1ZDfzrO697NrPsXQmXWMHETnQw5wvNeUHg
         z4BeL2asWUB2Hcc/s5h/UF3UzvYm4RHTZmVCM=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On my LVM system this changes the relevant output from "rd_NO_LVM" to
"rd_LVM_VG=alan-desktop.Linux"

Note that on my newer system, it now reaches moduledep() and complains.
I don't know enough awk to tell whose fault it is :). 

    awk: line 2: function gensub never defined
    awk: line 2: function gensub never defined
    rd_NO_MD rd_NO_LVM rd_NO_LUKS LANG=en_GB.UTF-8 root=/dev/sda2

Both my systems (old ubuntu and debian unstable) agree that bash
regexes should not be quoted:

    $ [[ 'a' =~ a ]] && echo match
    match
    $ [[ 'a' =~ ^a$ ]] && echo match
    match
    $ [[ 'a' =~ '^a$' ]] && echo match
    $

(and yes, it is safe against globbing)

    $ touch 9
    $ echo [0-9]
    9
    $ [[ 1 =~ [0-9] ]] && echo match
    match

diff --git a/dracut-gencmdline b/dracut-gencmdline
index 978f5a2..02509dd 100755
--- a/dracut-gencmdline
+++ b/dracut-gencmdline
@@ -212,7 +215,7 @@ findstoragedriverinsys () {
         sysfs=$(freadlink ${sysfs%/*})
     fi
 
-    if [[ ! "$sysfs" =~ '^/sys/.*block/.*$' ]]; then
+    if [[ ! "$sysfs" =~ ^/sys/.*block/.*$ ]]; then
         #error "WARNING: $sysfs is a not a block sysfs path, skipping"
         return
     fi
@@ -223,12 +226,12 @@ findstoragedriverinsys () {
         *) handleddevices="$handleddevices $sysfs" ;;
     esac
 
-    if [[ "$sysfs" =~ '^/sys/.*block/md[0-9]+$' ]]; then
+    if [[ "$sysfs" =~ ^/sys/.*block/md[0-9]+$ ]]; then
         local raid=${sysfs##*/}
         vecho "Found MDRAID component $raid"
         handleraid $raid
     fi
-    if [[ "$sysfs" =~ '^/sys/.*block/dm-[0-9]+$' ]]; then
+    if [[ "$sysfs" =~ ^/sys/.*block/dm-[0-9]+$ ]]; then
         vecho "Found DeviceMapper component ${sysfs##*/}"
         handledm $(cat $sysfs/dev |cut -d : -f 1) $(cat $sysfs/dev |cut -d : -f 2)
     fi

