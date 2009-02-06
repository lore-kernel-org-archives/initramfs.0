From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 13:26:27 -0700
Message-ID: <e9c3a7c20902061226m3f1e9e55pc2986a8527ade77@mail.gmail.com>
References: <20090206164019.GD552@redhat.com>
	 <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
	 <20090206165601.GF11144@nostromo.devel.redhat.com>
	 <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
	 <20090206173814.GA3541@nostromo.devel.redhat.com>
	 <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com>
	 <20090206182118.GA4413@nostromo.devel.redhat.com>
	 <e9c3a7c20902061119i2120cc5fpda0a5cdc3aedc17b@mail.gmail.com>
	 <20090206200818.GC6150@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=XOIs/M6iLRC5gm7Z5DQwQO01VFIu/lNNbD5rFyWdwXY=;
        b=IabqxdwN5V4PLpD+U1sN9b9f729r92Eh2Ut6LEab5adyI0A+VRRpkqGIJY2RaYtGeH
         3ngmV2nAw9/Ue5ixFaB8kBa3/DpXGhBUM12ah2djTBxq5wE3SIYwTMK1VQyZS0bDxTkh
         UhFXqd9hmmebv6YMd09iP2QhfFPU10zgO4aKk=
In-Reply-To: <20090206200818.GC6150-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

On Fri, Feb 6, 2009 at 1:08 PM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said:
>> Actually no, your not necessarily stuck with the mdmon from boot.  In
>> a pinch you could "mdmon /proc/mdstat /".
>
> Not really.
>
> You state:
>
>> One might say "just set the dirty bit, terminate, and wait for the
>> mdmon in the rootfs to take over".  The problem is that a disk could
>> fail in this window, and this event needs to be handled before the
>> kernel does anything else to the array.
> ...
>> The clean bit can be set as soon as the parity data is in sync with
>> the data on the other drives.  We typically wait for some period of
>> write-inactivity to avoid needlessly touching the metadata after every
>> write.
>
> You shut down the machine. After a while, you get to the point where
> you're getting ready to unmount the filesystem. Since mdmon's running
> on it (if you started it post boot), you have to kill it. After that
> point, there are going to be writes (a final sync, if nothing else,
> when you unmount the filesystem.) And you won't be able to set any
> RAID metadata flags then, as the daemon won't be running. So, doing
> a later run of "mdmon /proc/mdstat" doesn't fully protect you.
>

mdmon needs some coordination with the shutdown scripts to be kept
alive until the rootfs is marked readonly... actually up until the
point where the rootdev can be marked readonly.

If you take a look at Debian's killall implementation it has
provisions to exclude fuse and other critical userspace process from
killall.  A similar exclusion is needed for mdmon.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
