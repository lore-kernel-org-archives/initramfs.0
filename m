From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: Most efficient way to compute initramfs.img memory needs once
 uncompressed?
Date: Thu, 23 Mar 2017 17:53:39 +0100 (CET)
Message-ID: <2035004172.8785478.1490288019461.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <876275948.8764054.1490287670503.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <876275948.8764054.1490287670503.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


I'm desperately trying to find a good way to compute the memory required in terms of ramfs? 
This must work on all maintained distros that use dracut. (at least centos-6, fedora-25, ...) 

In other words, is there a simple/common way to compute the following command line parametters given an initramfs.img file? 
ramdisk_blocksize=1024 ramdisk_size=?????? 

- lsinitrd doesn't have this capacity 
- informations stored in the initramfs doesn't have this info 
- lsinitcpio has this capability but seems to be specific to archlinux. 

Regards, 

-- 
   Olivier LAHAYE
