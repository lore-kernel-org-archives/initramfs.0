From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dmsquash-live-root + NFS?
Date: Wed, 09 Jun 2010 10:36:20 +0200
Message-ID: <4C0F5284.4030706@redhat.com>
References: <AANLkTilxH61gB7Kx9EXP6rW--0Fhd5SKYQvFyd1miLXH@mail.gmail.com> <AANLkTile6XogMyj-4ga8ftqbDIPUNRD8cjuBcWT1z8kj@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTile6XogMyj-4ga8ftqbDIPUNRD8cjuBcWT1z8kj-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Scott Olsen <olesen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/04/2010 03:35 AM, Scott Olsen wrote:
> First of all, many thanks for all the work on Dracut. We're moving our
> network clients over to Dracut from custom mkinitrd build environment,
> and wow, what an improvement.
>
> What we are looking to do is: the exact execution path of
> dmsquash-live (with an ext3fs.img inside of squashfs) and copy to
> live_ram but with the source of the image being a NFS mount instead of
> a block device.
>
> We hacked it to work, but I want to know the proper way to put this
> into the dracut framework/architecture.
>
> What we have now is:
>
> - inside cmdline/parse-dmsquash-live, we set netroot to be the nfs server
>
> - let everything proceed as normal
>
> - then at the end of /sbin/nfsroot we just call
> /sbin/dmsquash-live-root and everything works (after a few tweaks)
> since the NFS mount is already mounted on NEWROOT and live_dir points
> to the squashfs image.
>
> --
>
> Like I said, its up and working but is there a better way to implement
> this?  any architecture pointers would be greatly appreciated!!
>
> Is there any bad effect of having the udev rules created by
> dmsquash-live-genrules run along with the netroot/nfsroot code run?
>
> We had to disable the initqueue check_finished test in init because
> init would break after the retry limit saying no root device found
> (it's there but does not pass the test).  Is this a consequence of
> having both dmsquash-live and nfsroot?
>
>
> thanks
>
> Scott

Care to show your modifications, so I can get a better feeling what you are doing?
