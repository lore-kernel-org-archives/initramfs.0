From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: qemu -hda /dev/null
Date: Thu, 18 Jun 2009 22:57:21 -0400
Message-ID: <1245380241.28792.10.camel@lap75545.ornl.gov>
References: <4A3A90CC.7070309@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <4A3A90CC.7070309-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2009-06-18 at 15:09 -0400, Warren Togami wrote:
> # Need this so kvm-qemu will boot (needs non-/dev/zero local disk)
>      if ! dd if=/dev/zero of=client.img bs=1M count=1; then
>          echo "Unable to make client sda image" 1>&2
>          return 1
>      fi
> 
>      $testdir/run-qemu -hda client.img -m 128M -nographic \
> 
> Technically this isn't true.  You can use -hda /dev/null and it will 
> boot just fine.  But I guess we need that disk as a means to pass the 
> nfs-OK messages?

We need the disk as means for that, yes, but qemu-kvm would not boot
with -hda /dev/null IIRC, at least in the configuration I was using.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
