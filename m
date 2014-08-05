From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: Using initqueue
Date: Tue, 5 Aug 2014 19:08:59 +0400
Message-ID: <CACaajQsEKUVkF7wWVDM0gL3XjQTd=-i9EqaUbDrNagnbbPz5Cw@mail.gmail.com>
References: <CAAXZ8mfWJ4OgmsO4dS74sPiDbiUJgnVk9i8-MNsKC=KQNU751A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8es6SOPsxzGwnzThRYvYd+VtpEieMzFFO0LvAytZbsY=;
        b=QyZYsDnkpQx/TdzKjZgq06VuFDOojfyTbPy59xtucbUClOdKQxZlbxA1XW653VoFHy
         RsRmMjTQbCUZxDi5jo0yGO5Jlm0BgoCpm9yFpzggGHLcmh53zDjSDSpgJqjhay0vT9Of
         mipap7SRQVL8BGvcdWnAiDVUsk+cM3+/uFcno=
In-Reply-To: <CAAXZ8mfWJ4OgmsO4dS74sPiDbiUJgnVk9i8-MNsKC=KQNU751A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I think that you send email to wrong team. dracut team not merge my
patches, because i don't complete them.
You can send me full log in personal email.

2014-08-05 15:44 GMT+04:00 Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi!
> I try create my module for dracut and in module-genrules.sh call
>   /sbin/initqueue --settled --onetime --unique /sbin/overlayfs-root
> "{root@live:}"
> But in log I don't see executing overlayfs-root.sh.
> What do i wrong?
> Regards,
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
