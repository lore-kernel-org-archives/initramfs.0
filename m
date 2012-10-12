From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 2/2] ssh-client: add urandom seeding
Date: Fri, 12 Oct 2012 09:35:51 -0400
Message-ID: <20121012133551.GA9490@redhat.com>
References: <20121011080757.285843621@redhat.com>
 <20121011080918.972371593@redhat.com>
 <50768041.8000803@redhat.com>
 <20121011195823.GD2218@redhat.com>
 <5077A035.30008@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5077A035.30008-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Fri, Oct 12, 2012 at 12:44:37PM +0800, Dave Young wrote:
> On 10/12/2012 03:58 AM, Vivek Goyal wrote:
> 
> > On Thu, Oct 11, 2012 at 10:16:01AM +0200, Harald Hoyer wrote:
> >> Hmm, wouldn't that mean, that the generator is seeded with the _same_ seed on
> >> every reboot?
> >> How is this different from booting with no seed at all?
> > 
> > Atleast it can help with kdump where we might regenerate the initramfs
> > upon user config change and capture the new seed.
> > 
> > Also kdump does not happen often on the machine. So I guess for once in 
> > a while operation it is still better to use random-seed then not using
> > anything at all.
> 
> 
> For normal boot case, I think something like
> systemd-random-seed-load.service is fine because rootfs is always
> mounted in initramfs. But I'm not sure how to handle the mount issue if
> /var/lib if mounted to another partition.
> 
> Or simply add below to pre-pivot hook:
> 
> if [ -f /proc/vmcore ]; then
>     cat /var/lib/random-seed > /dev/urandom
> else
>     if [ -f /sysroot/var/lib/random-seed ]; then
>         cat /sysroot/var/lib/random-seed > /dev/urandom
>     fi
> fi
> 

Or how about doing it rhel6 way. Let kdump module pack in
/var/lib/random-seed in kdump initramfs and if this file is present,
feed it to /dev/urandom.

Thanks
Vivek
