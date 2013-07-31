From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 95rootfs-block: fix PARTUUID parsing
Date: Wed, 31 Jul 2013 16:20:43 +0200
Message-ID: <51F91D3B.7010401@redhat.com>
References: <CAEm7KtxJhmN-p0b9UVq162d5=OEV35tVpJ7hLgpiLaOU90So2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEm7KtxJhmN-p0b9UVq162d5=OEV35tVpJ7hLgpiLaOU90So2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brandon Philips <brandon-J/aRLfwL2k0@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/23/2013 03:17 AM, Brandon Philips wrote:
> In the kernel comments PARTUUID is shown using uppercase A-F:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/init/do_mounts.c?id=HEAD#n183
> 
> However, dracut tries to use the value of PARTUUID directly in
> /dev/disks/by-partuuid/ which expects the hex to be lowercase. This will
> cause root to never be found, oops!
> 
> Fix dracut so it can, like the Kernel, accept either casing.
> 
> Untested but I added a hack on my local system that was similar.
> 

pushed, thanks
