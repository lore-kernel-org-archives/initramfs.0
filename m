From: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Out of tree drivers missing from initramfs
Date: Thu, 24 Jan 2013 17:26:43 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1301241718240.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301221612280.31163@jlaw-desktop.mno.stratus.com> <50FFFF93.2080209@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50FFFF93.2080209-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joe Lawrence <Joe.Lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 23 Jan 2013, Harald Hoyer wrote:

> Am 22.01.2013 23:04, schrieb Joe Lawrence:
>
> > 2 - Do modules underneath /lib/modules/ver/{updates,extras} need to 
> >     include their respective directory structure (ie, 'drivers/scsi'). 
> 
> yes

Is this a dracut requirement, general convention, etc?  I tried to search 
google for a definitive document on updates/extra modules and couldn't 
find much aside from Documentation/kbuild/modules.txt in the kernel tree.

This change is easy enough to make, but I'd like to get it right. :)
 
> Thanks for reporting this, will fix this bug!

See below for one possible solution.  It may be more correct to filter on 
kernel* and updates* and extra*, but as proof of concept, it 
successfully built a initramfs with a driver located at:

  /updates/lsb-ft/drivers/scsi/mpt2sas/mpt2sas.ko

Regards,

-- Joe

From b45c6d7eb70dea5bc44b683b2f46876b33ca062a Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 24 Jan 2013 14:30:56 -0500
Subject: [PATCH] Support out-of-tree and updated drivers in initramfs creation

The find_kernel_modules_by_path function shouldn't filter out modules not
located underneath the /lib/modules/ver/kernel directory as out-of-tree
drivers may reside in /lib/modules/ver/extra and updated drivers in
/lib/modules/ver/updates.

Signed-off-by: Joe Lawrence <joe.lawrence-7+ureL1bLXNBDgjK7y7TUQ@public.gmane.org>
---
 dracut-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index e23db76..f7e3ec8 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -1502,7 +1502,7 @@ find_kernel_modules_by_path () (
         _OLDIFS=$IFS
         IFS=:
         while read a rest; do
-            [[ $a = kernel*/$1/* ]] || continue
+            [[ $a = */$1/* ]] || continue
             echo $srcmods/$a
         done < $srcmods/modules.dep
         IFS=$_OLDIFS
-- 
1.8.0.2
