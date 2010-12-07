From: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: create ldconfig aux cache directory on the
 initrd
Date: Tue, 7 Dec 2010 12:11:33 +0100
Message-ID: <20101207111133.GA32623@neptun>
References: <1291686260-32371-1-git-send-email-christian.ch.heinz@gmail.com>
 <1291715126-sup-971@ittemni>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to;
        bh=ZUQ6x7TsyfqInIDTdsyVvT9Q79xtQxj8GeryJ7S9OR0=;
        b=ukHm1qsSs7xxx5Qyjq/NsjAt+4Nqw50hKrVfvFhJpqtUUBtSzouxNiqTpu7TOPw3q6
         UZXcxHzFsLJFd4vnwgwQpQPzcOjHZKkh1T4bIqaUAkHxqJ/RRrAcEvLORL9yvvIiy9vV
         dvkLgOrMQC4oUvSXVL8O5c8HA3PrbVF8QFcKg=
Content-Disposition: inline
In-Reply-To: <1291715126-sup-971@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

> What is the benefit of "falling partially" over "falling completely".
> I'm wondering if there shouldn't be check if dracut is run by non-root
> and then exit immediately.  Normal user cannot read some files (e.g.
> /bin/mount), so what's the point?

Not having read permission for /bin/mount as normal user looks weird to
me. I use dracut on Arch Linux, though I also just tested on a Fedora VM
and everything builds/runs just fine without root permissions. Are there
any compelling reasons to restrict image generation to root only? Am
I missing something fundamental?

Regards,
Christian
