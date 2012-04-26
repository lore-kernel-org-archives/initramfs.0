From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: What are the semantics of --mount option
Date: Thu, 26 Apr 2012 07:40:01 -0400
Message-ID: <20120426114001.GC21447@redhat.com>
References: <20120425215006.GA19485@redhat.com>
 <4F991CEF.3020307@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F991CEF.3020307-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Thu, Apr 26, 2012 at 12:01:19PM +0200, Harald Hoyer wrote:
> Am 25.04.2012 23:50, schrieb Vivek Goyal:
> > Hi Harald,
> > 
> > What are the semantics of --mount option. If I call dracut with --mount
> > option, can I expect that resulting initramfs will mount that
> > filesystem (including network file system) by the time  pre-pivot hook of
> > a module is called?
> 
> yes, but network setup has to be crafted on the kernel cmdline or in a
> /etc/cmdline.d/*.conf

This is interesting. General theme of dracut seems to be that for
networking, iscsi etc, we will include relevant tools (binaries/config
files etc) but will not store the specific configuration of target and
expect the configuration either on command line (iscsiroot, netroot etc)
or in /etc/cmdline.d/*.conf.

I am confused why that's the case. I mean I can understand this for
generic initramfs. But for hostonly initramfs, don't we want to bring
up all the devices encountered in root path by default? Why a user is
supposed to specify specific iscsi, network configuration on the
command line again. dracut has access to alll this information while
traversing the device stack and should be able to store it in initramfs.

IOW, will it make sense that in hostonly mode, various modules also starting
saving associated configuration of device (as needed) and by default
try to bring up those devices on boot (in addition to honoring any
command line options passed)?

Thanks
Vivek
