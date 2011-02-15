From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: understanding mdraid initialization logic
Date: Tue, 15 Feb 2011 15:47:32 +0300
Message-ID: <AANLkTinpHgBb3EJaXxj+-tznm9S=6asfTmePgDF-c8DL@mail.gmail.com>
References: <201102151243.23744.lists@egidy.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rybZSYpk6CTCtmYgPkqg1foiYlErrpkkkrh5XifwKc4=;
        b=Ov4kKskPvvWvk6ZTP+zDA7MFEeWhS5BqpYXey6kod1PK1HvpTidrMEy75nJ1Q0grBj
         skSLR5VZXdnGgeFRobM9g4fqss2+IdJ9B5sPNqlPmp+YbbRp9G9xkzTcbz3mhwG8uD+k
         u5RiubKy75q37+WfvXEyjvILBCuVIuaCCd3u8=
In-Reply-To: <201102151243.23744.lists-6VzpN07DMvo@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gerd v. Egidy" <lists-6VzpN07DMvo@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Trying to guess ...

On Tue, Feb 15, 2011 at 2:43 PM, Gerd v. Egidy <lists-6VzpN07DMvo@public.gmane.org> wrote:
> Hi,
>
> I'm trying to understand what goals dracut wants to reach regarding mdraids -
> what should the status of the mdraids be when dracut is finished?
>
> Currently I see that when dracut includes an mdadm.conf, all these mds will
> stay active when dracut ends. When dracut does not use/include an mdadm.conf,
> the mds will be deactivated again at the end of dracut unless they are needed
> for the root filesystem.
>
> This logic is in modules.d/90mdraid/parse-md.sh, it is done by conditionally
> deleting the mdraid-cleanup.sh.
>
> What is the reason for deactivating the mds? Why is this handled differently
> when an mdadm.conf is present?
>

mdadm.conf is present only if you build initrd in hostonly mode - i.e.
when you include only modules that are needed for currently running
hardware. In this case it can be assumed that all arrays are actually
present and used by currently booting system.

If mdadm.conf is not present, it is generic image. In this case you
can't be sure that all arrays actually belong to and will be activated
by booting system. So they are stopped to avoid confusion.

> I need an dracut image which is portable across a lot of machines so I can't
> include an mdadm.conf. But when the real system starts after dracut is done,
> all mds except the root one are gone and can't be mounted through fstab. I use
> filesystem labels in fstab, so the md numbers are irrelevant.
>

Well, usually system is expected to boot without initrd as well, so it
should be capable of activating those resources itself. I wonder what
distro are you using?
