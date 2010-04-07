From: Tony Wan <visual2me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: help about dracut
Date: Wed, 7 Apr 2010 17:52:25 +0800
Message-ID: <i2u69b8237b1004070252s1254e5e2l3d083b0671c70828@mail.gmail.com>
References: <p2t69b8237b1004060511w87a32eb3qc6f4c273bd6bb121@mail.gmail.com>
	 <4BBC4D45.90801@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SNpxOfNozb9ru8h4l2apqxyWF55ysTQ9OmW29etVI3k=;
        b=ESiObYkeGlIaPn33KT2RoHRTM7mssfeJaahDMmww2nxqTKH4c/VIHZ1GH/ehrSLxrf
         7DJpWtVXrw6lOkmw7Bs7ApnS+/iIlFmIzyHJ136J34gh5SJhwoq4NXMID2Rc2nCHb9E2
         1aM22FGmuTvlLYUkCzc/yWko56pevsGv2hau8=
In-Reply-To: <4BBC4D45.90801-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thank you very much. But I still have a question -- can I specify 2 or
more crypto_LUKS partitions after "rd_LUKS_UUID=3D"?

On Wed, Apr 7, 2010 at 5:15 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Am 06.04.2010 14:11, schrieb Tony Wan:
>>
>> Hi List,
>>
>> Sorry for interrupt. I'm totally a newbie for dracut and have no ide=
a
>> how to make a customized initramfs with it on Fedora Core 12. I have=
 a
>> luks-crypted partition, but I don't want to mount it at boot time, s=
o
>> there's no need to ask for the password during the boot process. My
>> question is how to disable dracut to auto-detect crypto_LUKS
>> partitions and ask for the password during boot (or just for a
>> specific partition with a UUID). Anyone can give me help, since it's
>> really difficult to find a tutorial for dracut on internet. Thanks i=
n
>> advance.
>
>
> $ man dracut
>
> crypto LUKS
> =A0 =A0 =A0 rd_NO_LUKS
> =A0 =A0 =A0 =A0 =A0disable crypto LUKS detection
>
> =A0 =A0 =A0 rd_LUKS_UUID=3D<luks uuid>
> =A0 =A0 =A0 =A0 =A0only activate the LUKS partitions with the given U=
UID Any
> =A0 =A0 =A0 =A0 =A0"luks-" of the LUKS UUID is removed before compari=
ng to
> =A0 =A0 =A0 =A0 =A0<luks uuid>. =A0The comparisons also matches, if <=
luks uuid> is
> =A0 =A0 =A0 =A0 =A0only the beginning of the LUKS UUID, so you don=92=
t have to
> =A0 =A0 =A0 =A0 =A0specify the full UUID.
>
>



--=20
Best regards,
Tony Wan
