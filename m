From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] 95uswsusp: Gentoo path for 'resume' binary
Date: Wed, 09 Jun 2010 17:39:54 +0200
Message-ID: <4C0FB5CA.1060301@redhat.com>
References: <20100609103605.50a6acec@etiriah.ds.pg.gda.pl> <20100609103836.6d14d542@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100609103836.6d14d542-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/09/2010 10:38 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> ---
>   modules.d/95uswsusp/check   |    2 +-
>   modules.d/95uswsusp/install |    7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/modules.d/95uswsusp/check b/modules.d/95uswsusp/check
> index ba95479..4b3f8fb 100755
> --- a/modules.d/95uswsusp/check
> +++ b/modules.d/95uswsusp/check
> @@ -1,2 +1,2 @@
>   #!/bin/sh
> -[ -x /usr/sbin/resume ]
> +[ -x /usr/sbin/resume ] || [ -x /usr/lib/suspend/resume ]
> diff --git a/modules.d/95uswsusp/install b/modules.d/95uswsusp/instal=
l
> index f8afe3a..6830763 100755
> --- a/modules.d/95uswsusp/install
> +++ b/modules.d/95uswsusp/install
> @@ -1,5 +1,10 @@
>   #!/bin/bash
> -inst /usr/sbin/resume
> +for bin in /usr/sbin/resume /usr/lib/suspend/resume
> +do
> +    [ -x "${bin}" ]&&  break
> +done
> +
> +inst "${bin}" /usr/sbin/resume
>   [ -f /etc/suspend.conf ]&&  inst /etc/suspend.conf
>
>   inst_hook cmdline 10 "$moddir/parse-uswsusp.sh"


pushed
