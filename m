From: Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [DRACUT PATCH] lvm_scan: use '--ignoremonitoring' rather than
 '--monitor n'
Date: Wed, 10 Mar 2010 14:31:38 -0500
Message-ID: <20100310193138.GA13399@redhat.com>
References: <1268249058-23510-1-git-send-email-snitzer@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1268249058-23510-1-git-send-email-snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lvm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Wed, Mar 10 2010 at  2:24pm -0500,
Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> lvchange and vgchange '--monitor n' will not prevent lvm from
> attempting to dlopen the libdevmapper-event library.
> 
> dracut git commit 47ab3b6c5e introduced the use of '--monitor n' but
> '--ignoremonitoring' is needed now that the libdevmapper-event library
> isn't copied into the initramfs (ever since 0fae59d6eb3)

And just to be clear:
'--monitor n' is "stop monitoring this (VG or LV)"
'--ignoremonitoring' is "don't do any monitoring".

We'll be fixing up lvm's vgchange and lvchange man pages so that they
are more precise on what '--monitor n' means.

Mike
