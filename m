From: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dracut: add support for updating the CPU microcode
Date: Sat, 16 Apr 2016 09:01:06 +0300
Message-ID: <5711D522.3090907@gmail.com>
References: <1460762332.3054.2.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=FcUL02Os6PqgJbSwJEM/LRlsfu1ksYnZrQ0yIYz0dDc=;
        b=eN83G/1Ap7VTjuMMrfZl6sUp69xx+jYiw90lSq7YHEVmbSZLG+M/OmL4OsF7Tb6eTY
         ZvbGcGNPx+0EPfJV9DwtLH+036NaRWkIiuR7TbZTM+ZRvAyECwSNu/IktcnWhRyOnNc2
         nRbN7ht2RHIyNNODiE7Nztltbw8e5ua2sqB+9OEGoE5PyFP2b4MNRiUc/gr72gOGS8QO
         ikWFTcc6umLyl0wL6xQvO0s1Ernm+s3Z5h452cp44dFC4nUK9XLmwdQSEKzFQkqlSXHU
         dM9Scv0WzZzDL0pRaGN3u0vBWFof4i97WQHQ1OeRtViTaCD6edS9hXWqDNTXfPbByeOd
         iwMA==
In-Reply-To: <1460762332.3054.2.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

16.04.2016 02:18, Guido Trentalancia =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> This is the initial version of a new "microcode" dracut module
> that can be used to update the microcode on Intel(R) CPUs.
>=20

??? dracut already supports early microcode loading, why it is not
enough and what problem this patch solves?

> Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> ---
>  modules.d/00microcode/module-setup.sh |   26 +++++++++++++++++++++++=
+++
>  modules.d/99base/init.sh              |    9 +++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff -pruN dracut-git/modules.d/00microcode/module-setup.sh dracut-gi=
t-microcode-update/modules.d/00microcode/module-setup.sh
> --- dracut-git/modules.d/00microcode/module-setup.sh	1970-01-01 01:00=
:00.000000000 +0100
> +++ dracut-git-microcode-update/modules.d/00microcode/module-setup.sh=
	2016-04-16 01:11:20.719287468 +0200
> @@ -0,0 +1,26 @@
> +#!/bin/bash
> +
> +# Dracut module to update the microcode on Intel(R) CPUs
> +# Copyright 2016 Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> +
> +# called by dracut
> +check() {
> +    [[ "$mount_needs" ]] && return 1
> +
> +    require_binaries microcode_ctl || return 1
> +
> +    return 0
> +}
> +
> +# called by dracut
> +depends() {
> +    return 0
> +}
> +
> +# called by dracut
> +install() {
> +    inst microcode_ctl
> +
> +    inst_dir /lib/firmware
> +    inst /lib/firmware/microcode.dat
> +}
> diff -pruN dracut-git/modules.d/99base/init.sh dracut-git-microcode-u=
pdate/modules.d/99base/init.sh
> --- dracut-git/modules.d/99base/init.sh	2016-04-14 22:21:22.681548895=
 +0200
> +++ dracut-git-microcode-update/modules.d/99base/init.sh	2016-04-16 0=
1:09:58.517080944 +0200
> @@ -62,6 +62,15 @@ if ! ismounted /dev/shm; then
>      mount -t tmpfs -o mode=3D1777,noexec,nosuid,nodev,strictatime tm=
pfs /dev/shm >/dev/null
>  fi
> =20
> +# Update CPU microcode
> +if [ -x /usr/sbin/microcode_ctl ]; then
> +    MICROCODE_CTL=3D/usr/sbin/microcode_ctl
> +elif [ -x /sbin/microcode_ctl ]; then
> +    MICROCODE_CTL=3D/sbin/microcode_ctl
> +fi
> +[ $MICROCODE_CTL ] && [ ! -e /dev/cpu/microcode ] && echo "Creating =
microcode update device..." && mknod /dev/cpu/microcode c 10 184
> +[ $MICROCODE_CTL ] && [ -e /lib/firmware/microcode.dat ] && $MICROCO=
DE_CTL -u
> +
>  if ! ismounted /run; then
>      mkdir -m 0755 /newrun
>      if ! str_starts "$(readlink -f /bin/sh)" "/run/"; then
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
