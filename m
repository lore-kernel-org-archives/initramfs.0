From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: help about dracut
Date: Wed, 07 Apr 2010 11:15:49 +0200
Message-ID: <4BBC4D45.90801@redhat.com>
References: <p2t69b8237b1004060511w87a32eb3qc6f4c273bd6bb121@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <p2t69b8237b1004060511w87a32eb3qc6f4c273bd6bb121-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Tony Wan <visual2me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 06.04.2010 14:11, schrieb Tony Wan:
> Hi List,
>
> Sorry for interrupt. I'm totally a newbie for dracut and have no idea
> how to make a customized initramfs with it on Fedora Core 12. I have =
a
> luks-crypted partition, but I don't want to mount it at boot time, so
> there's no need to ask for the password during the boot process. My
> question is how to disable dracut to auto-detect crypto_LUKS
> partitions and ask for the password during boot (or just for a
> specific partition with a UUID). Anyone can give me help, since it's
> really difficult to find a tutorial for dracut on internet. Thanks in
> advance.


$ man dracut

crypto LUKS
        rd_NO_LUKS
           disable crypto LUKS detection

        rd_LUKS_UUID=3D<luks uuid>
           only activate the LUKS partitions with the given UUID Any
           "luks-" of the LUKS UUID is removed before comparing to
           <luks uuid>.  The comparisons also matches, if <luks uuid> i=
s
           only the beginning of the LUKS UUID, so you don=92t have to
           specify the full UUID.
