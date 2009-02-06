From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 11:12:22 -0700
Message-ID: <e9c3a7c20902061012w15a31e7br6ce2074b7b9db555@mail.gmail.com>
References: <20090206164019.GD552@redhat.com>
	 <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
	 <20090206165601.GF11144@nostromo.devel.redhat.com>
	 <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
	 <20090206173814.GA3541@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=NavCMVtp2YKGy1RJ6LLxug4kJ+7erMbzP9Xz6gUAZ9w=;
        b=Egaq8LAQ3qsWLzDg8073Ot/8QhKmFjaQvYOY3djOsINOk2B8F9QE9JWGUqQ8VbPEIQ
         WwgTSwd6nvIJZpSg10pxo6yEzKdt69bTNjJJ4U9xRdhkDrsFP3FgirKPuAYHu5MalLQu
         VtehB4jAJLPsMgN8tD3U/lJrgH/eAHtX/J7/Q=
In-Reply-To: <20090206173814.GA3541-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

On Fri, Feb 6, 2009 at 10:38 AM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Dan Williams (dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said:
>> It is not just setting writable, mdmon is also there to clear the bit
>> when writes have quiesced.
>
> Let me just see if I understand this infrastructure correctly.
>
> - device is set writable
> - kernel tells userspace
...tells userspace that we want to transition the array from clean to dirty, yes

> - userspace frobs bit in superblock to say 'I want to be dirty!'
yes

> - userspace tells kernel
...yup array is dirty, start writing.

> - kernel writes bit to disk
> ... stuff happens ...
> - userspace tells kernel to unmount, or remount R/O
> - kernel tells userspace "hey, i unmounted this"
> (userspace freaks out because the filesystem the daemon is running on
>  just went away)
mdmon does not know or care if the *filesystem* is read-only.  It is
reading and writing /proc, /sys, and the raw disk devices.

> - userspace frobs bit in superblock to say 'This array is CLEAN!'
...not in this scenario no.

> - userspace tells kernel
> - kernel writes bit to disk
>
> Is that really how it's supposed to work?
You lost me at userspace freaks out, but that is the general flow.

> So, why isn't the ext* journal or filesystem unclean flag
> handled via a userspace file monitoring daemon, then?
I'm not trying to be obtuse, but because it isn't.  Put another way,
consider what extra tools the initramfs would need if we wanted to
support an ntfs-3g rootfs.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
