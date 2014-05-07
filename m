From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Intend of hostonly-cmdline?
Date: Wed, 07 May 2014 13:12:55 +0200
Message-ID: <2263850.UM9clb02rz@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I wonder for what this one is exactly for?

commit ab9457efd78ff74c654b4123956cdbd131935066
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Feb 25 12:35:32 2014 +0100

    Add flag to toggle hostonly cmdline storing in the initramfs
    
    --hostonly-cmdline:
        Store kernel command line arguments needed in the initramfs
    
    --no-hostonly-cmdline:
        Do not store kernel command line arguments needed in the initramfs



Wouldn't it be enough to simply add hostonly command line parameters
only in hostonly case like:
+    if [[ $hostonly == "yes" ]]; then
+        cmdline  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
+        echo  >> "${initdir}/etc/cmdline.d/90mdraid.conf"
+    fi

why is a hostonly-cmdline extra parameter needed?

Thanks,

  Thomas
