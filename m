From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut options for installing files and drivers
Date: Wed, 09 May 2012 15:35:32 +0800
Message-ID: <4FAA1E44.2090006@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi, harald

Dracut options '-I' and '-a' both mean optionally install file/ko

I wonder if dracut intend to do this for some reason. In kdump module
user probably need install extra files or kernel modules to kdump
initrd, we need to bail out if the files do not exist.

If there's no special reason, how about change it to fail by default for
non-exist files? Or need add other options?

-- 
Thanks
Dave
