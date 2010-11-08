From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Live module for root=nfs using Aufs
Date: Mon, 8 Nov 2010 09:19:31 +0100
Message-ID: <4CD7B293.8050809@bfh.ch>
References: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=7coxwNNu22um=qO7Tz18QZj_N7h3=G5ABnjqV-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 11/08/2010 01:43 AM, Jon Ander Hernandez wrote:
> Hello,
>
> We are currently developing a tool for creating simple beowulf
> clusters, and we decided to use Dracut instead of initramfs-tools on
> Debian. We found Dracut to be very well designed.
>
> We have developed a very simple module, which allows us to have a
> writable overlay over a read-only exported nfs4 using aufs :
>
> http://kestrelhpc.svn.sourceforge.net/viewvc/kestrelhpc/Kestrelhpc/Src/dracut/union_mount_with_aufs.diff
>
> Well, it is so general that also allows to get a writable overlay over
> any root mounted by Dracut.

I just had a quick look over the patch and in itself it looks ok. 
Although I'm not sure if having the aufs at this stage is necessary. 
What if you just mount it later inside the rootfs? (Background: I'm 
using aufs overlays for our read only nfs-roots, and I just put the 
necessary aufs mounts inside fstab)

> I've seen that you are changing Dracut's parameter's namespace, and I
> would like to know if this kind of "live" use case could fit in them
> somehow, because it seems that the actual live namespace implies the
> classic live cd-rom use case.
>
> We also have several patches for make Dracut 007's network work on
> Ubuntu Maverick. Should I open a bug on Debian's bugzilla or should
> they be reviewed on this list instead?

Please post your patches here. There's more eyes here I think :-)


Regards,
Philippe
