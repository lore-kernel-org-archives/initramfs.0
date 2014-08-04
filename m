From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Rework kernel modules detection on ARM
Date: Mon,  4 Aug 2014 22:04:36 +0200
Message-ID: <1407182679-22580-1-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=VnLpAKgUCkFpiDVwJG0f5grB4oTb01ny0kjIhd1ZIwg=;
        b=as9V9Qu4D9PPlSWDG2v3y1K9N0aRmB0snnVEKJaV6g/u+soHWpjyxGQC8aphmSapGC
         KcC2SDXMkY2eqOoOm+Goym/VZK2NItZS1NB1TcePCRcRquCzm/ARh+W+13qU00rSfyrR
         s44kF7ntl1iULtAH8ODySvc0mIxdQC6WWFBQ82uwrqJ1THy4fawGH+0fHaISflbpW20d
         hGhZHHGyK9/fs1gzcbBa09KcNNCTIEwloIonecmYVdcv58SB3SLN8VqbtY8siPFyUqKz
         nA5OOzMeriPJD0t0RAEuYMNL6aVMQw54IesfIUDm0J66YekI18Hy14Fq/314xtQqdeTu
         47gQ==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="gb2312"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

 Handle backlight power and related drm dependencies on ARM
  (Tested tegra on Toshiba AC100/Trimslice)


# Fedora 21 armhfp
#  before: "vanilla" dracut-038-14.git20140724.fc21.armv7hl
#  after: dracut + patches

 time dracut -N initramfs-N-before $(uname -r)
real	5m43.169s
user	1m58.385s
sys	4m19.735s

# time dracut -H initramfs-H-before $(uname -r)
real	3m21.537s
user	0m50.595s
sys	2m58.565s

#  time dracut -N initramfs-N-after.img $(uname -r)
real	5m52.874s
user	2m8.385s
sys	4m35.090s

[#  time dracut -H initramfs-H-after.img $(uname -r)
real	3m15.968s
user	0m53.250s
sys	2m58.165s

ls -al
 ls -al initramfs-*
-rw-------. 1 root root 12195212  4 ao=C3=BBt  18:36 initramfs-H-before=
=2Eimg
-rw-------. 1 root root 12057377  4 ao=C3=BBt  19:47 initramfs-H-after.=
img
-rw-------. 1 root root 29522799  4 ao=C3=BBt  18:18 initramfs-N-before=
=2Eimg
-rw-------. 1 root root 30359836  4 ao=C3=BBt  19:40 initramfs-N-after.=
img


lsinitrd initramfs-H-after.img |grep simple-panel shows the module
along with all depencies that will allow to enable the backlight
on the device. (Toshiba AC100)


    v4 - Drop tegra_drm case
       - Categorize ARM needed modules in 90kernel-modules
         and removed drm ones
       - Add rtc, regulators, i2c ARM modules in 90kernel-modules
         drop hostonly=3D'' before instmods
       - Introduce and Categorize ARM needed modules in 50drm
   =20
    v3 - Drop module-setup.sh hook (better patch by pbrobinson)
       - Drop rtc hook
   =20
    v2 - Merged patch for kernel-modules for ahci_imx
       - Use "=3Ddrivers/ata" to select all ATA drivers
       - Install rtc drivers on ARM - initially reported as rhbz#107400=
2
        (WIP) need to install hwclock and sync time beforce network tim=
e sync
       - Use case in for drm on ARM when modalias is handled by
        a different module than the KMS one
       - Add backlight and pwm to the bundle for drm
       - Fix unbalanced parenthesis


Nicolas Chauvet (3):
  [ARM] Test soc path for modalias needed by drm
  [ARM] Categorize needed modules on ARM
  [ARM] Introduce ARM specific modules needed by drm

 modules.d/50drm/module-setup.sh            | 12 +++++++++++-
 modules.d/90kernel-modules/module-setup.sh |  7 ++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

--=20
1.8.3.1
