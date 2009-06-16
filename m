From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Some netboot doc cleanups
Date: Tue, 16 Jun 2009 09:39:51 +0200
Message-ID: <4A374C47.2040502@redhat.com>
References: <4A36B285.2080905@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A36B285.2080905-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/15/2009 10:43 PM, Warren Togami wrote:
> https://sourceforge.net/apps/trac/dracut/wiki/commandline
>> Configuration in initrd =B6
>>
>> /conf/conf.d/*
>> command line options can override values set here
>
> What is the intent here? This is only used from
> modules.d/95iscsi/iscsiroot and nowhere else.

This is intended to be a mechanism to inject (sensible) configuration f=
iles in=20
the pregenerated image.

We could use this globally, if more modules need this.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
