From: Maarten Vanraes <maarten.vanraes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: patches
Date: Wed, 21 Jul 2010 17:18:28 +0200
Message-ID: <201007211718.28574.maarten.vanraes@gmail.com>
References: <201007140205.35944.maarten.vanraes@gmail.com> <4C46DAF1.1090603@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=++7Kp3kdtFa9UsE9rswr8i3J5XqU/pFFmyRqITTGW/c=;
        b=YHflh8Jxu/8A6JvoIg1VfR3UqRC4w3b9R8QyiEtJfHVfAyMjGRjeiBnHBG+zOnLwE6
         JcL1Hd07+Mky+zMiSgUoilY47dBCLgsD4jvGgfpTMsIl0RKU/KC0fAW77GTm59zT+VOW
         3Vt4FsiKeLzlPkc31Xnj+QD/JqI93uiKm7MnA=
In-Reply-To: <4C46DAF1.1090603-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Op woensdag 21 juli 2010 13:33:05 schreef Harald Hoyer:
> On 07/14/2010 02:05 AM, Maarten Vanraes wrote:
> > Hi,
> >
> > Here are some patches, some that were used as patches in the mandriva
> > builds, and a first one from me, to fix nfs hostonly on chrooted
> > installs.
> >
> > Kind regards,
> >
> > Maarten Vanraes
> 
> -[ "$1" = "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
> +[ "$1" = "-h" ] && ! egrep -q '\s/\s+nfs[34]?\s' /etc/fstab && exit 1
> 
> Hmm, I think "hostonly" should be really "hostonly", so the check is valid.
> 
> You can always force the addition of nfs, if you are building a special
>  image for an NFS client. Or just boot with the generic (non-hostonly) one,
>  and build the hostonly one on the client.
> 

i see what you mean, but i beg to differ.

this thing is not really about nfs, it's about building an initrd on a chroot.

if you're building initrd on a chroot, it's always a hostonly, in fact, only 
distros ship generic initrds. and even that's not always true.

this fix has no consequences whatsoever in any case, except that it checks 
fstab instead of /proc/mounts. which means if you adjust your fstab, because 
you're going to run it elsewhere.

I was planning on checking everywhere and trying to reduce the dependencies on 
/proc and /sys, IF it works the same everywhere without any consequences (just 
like this here).

Also, if you look at it; not having / mounted as an nfs WILL disable the use 
of this module entirely and thus all the root=nfs stuff will fail.

What do you think?
