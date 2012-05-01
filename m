From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Does netroot=isci: option work with latest dracut
Date: Tue, 1 May 2012 12:47:04 -0400
Message-ID: <20120501164704.GA18202@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi,

On F17, I am trying kdump to an iscsi target. And I am passing a
netroot=iscsi:..... cmdline to dracut. But that does not seem to work.

Some debugging showed that we do parse the netroot= arguemnt in
parse-iscsiroot.sh but after that nothing happens. Nobody tries to
bring up the iscsi luns.

I see some code in iscsiroot.sh to call iscsistart to bring up iscsi
luns but that code does not seem to be hooked up. I could not figure
out who calls /sbin/iscsiroot.

So I am wondering if I am doing something wrong or there is some
disconnect in my understanding of how netroot= options works.

Thanks
Vivek
