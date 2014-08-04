From: Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Readonly root filesystem
Date: Mon, 4 Aug 2014 14:48:00 +0300
Message-ID: <CAAXZ8mdd+urmcF5D39k_pKv3iJ-cOxQfC=31_MJ0AFYLUC9ETg@mail.gmail.com>
References: <CAAXZ8mcdNna12Tfz2AShs6nFxxgqpFmOzpvKHa1x0Jb74NmnWA@mail.gmail.com>
 <CACaajQvjyE6ZhGUU3kraE3=dvcEdSYUGa-SWpHMAprNaJPv+yQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=lXIPlA/DakaGZjeXnjDAoRYSAvhbgt/rNSppET3nIbs=;
        b=SAOE5jkIbfHjIy52UmRUijxcQAY4RgK3WWsAOaTuiep6Bp74NBOhVlti1f2+Z1AZfq
         qQ72v6+7SvcsftU8KE2FXOmbXWRhLcRFURoQOfmtHyBJUi9Q7pPUyw6PS6n0cpqHKnXB
         u8EbwbYcr5yLZZGrHg4V/zbRozy1CNnD++n+RvbONFNlNFEUftZufVSsYZn4TsLXe0v0
         5kQKwBZMgNDNtLfdx3qsOAJKE/X5KAMeMWime4bu0WLJ1lH0o+4gtT6B9iDRlbdhPJQw
         3vggFMhu1NJKPyeqoCvbZtedrjqc5dHNXLpFzaGtBpBaXK3Oql6nQUrvm6ebZpwpZeQB
         1Uug==
In-Reply-To: <CACaajQvjyE6ZhGUU3kraE3=dvcEdSYUGa-SWpHMAprNaJPv+yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Sorry, but can you provide some links for this?
Thank you!

2014-08-04 13:59 GMT+03:00 Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>:
> 2014-08-04 12:08 GMT+04:00 Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hello!
>> I try to make my root filesystem read only. I need this to create
>> power failsafe linux for headless router. I want use unionfs where
>> write layer would tmpfs (or always recreate small partition) and root
>> filesystem within read only layer. I try to do this how in debian make
>> fsprotect (but in opensuse 13.1 i can't find aufs, so use unionfs).
>> And question is anybody do such things?
>> I can make root filesystem ro with rootflags=ro, but where I must add
>> hook to create another layers pre-mount, mount or switch_root?
>> Regards,
>> Alexander Perepelica
>
>
> Please see github patches for aufs and overlayfs support.
>
> --
> Vasiliy Tolstov,
> e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
> jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
