From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Tainting the initrd
Date: Thu, 19 Feb 2009 08:57:54 -0300
Message-ID: <82ecf08e0902190357l576547f5s5f156c3e9c64a4aa@mail.gmail.com>
References: <t7sv66-dk4.ln1@news.researchut.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yREuxglRTNUaj0mFdubQjZfX+L6GUsCtwre//xyonns=;
        b=t2y+TayslRuB1sc3cv8KFhRqNNgXZg1MrQ2mkO5jjZ1EDlL/uyoPWhn3IQT15dNX8E
         4vCCWpn9H+m0D0MxXqRBhMb60u60u6jrmCLanNhQdcvyYa5FqUmSzPAzWjqM6OTmaEAJ
         XeSl3AV9P7tjkv5J3AvpcEeO1dzvjv90LwE5Q=
In-Reply-To: <t7sv66-dk4.ln1-b1aPebNLFEbkkoF7R9+BZ0EOCMrvLtNR@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Well, since the original initrd is vendor provided you could simply
ask for a md5sum of the current initrd and match it against existing /
known initrds...

No?

Thiago Galesi

On Thu, Feb 19, 2009 at 8:26 AM, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org> wrote:
> Hi,
>
> I hope it is not too late to discuss this problem.
> I have a bugzilla filed for this, filed here:
> https://bugzilla.redhat.com/show_bug.cgi?id=435033
>
> The problem described in the above bugzilla entry is about "How do we
> authenticate initrd images"
> We sure have a huge dependency on the initrd. And day-by-day that dependency
> is increasing. Multipath SAN Boot, NFS et cetera all depend on the proper
> execution of an initrd image.
>
> We see a lot of problems in the SAN space, where users end up shuffling among
> 2 versions of HBA drivers. One from the OS Vendor, the other from the HBA
> vendor. And then we see IHVs and ISVs using their own set of utils to tamper
> the initrd. This is just an example.
>
> Currently, we don't have a way to identify, like what initrd image has the
> OS booted from. And we don't have a way to verify whether the initrd image
> from which the OS has booted from (and ended up with a bug), is the same
> initrd image that the OS vendor generates.
>
> Since this is a re-write effort, I'd like to know opinions here.
> * Do we see this situation as a problem ?
> * If yes, how can we overcome it ?
>
> I have some proposals listed in the bugzilla, but all are half-baked. I hope
> with your help, we can come up with a better approach. Probably, we just
> need a set of strict and enforcing assumptions.
>
> Ritesh
> --
> If possible, Please CC me when replying. I'm not subscribed to the list.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
