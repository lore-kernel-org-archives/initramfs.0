From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] arm64: mmc drivers
Date: Thu, 20 Apr 2017 08:37:06 +0100
Message-ID: <CALeDE9NMEEZj8NovD2FbYd=hpvcONRNPiKnNqj4PLz7u2gXKuA@mail.gmail.com>
References: <20170420065847.18368-1-lintonrjeremy@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YETDi/JxU4Sdnk3tktCS2eXZYnFECv42Pa8iYKrSw04=;
        b=C0WNrEvG5TV6KeEDGFs3Eo6VceFtHn5qCVnSlO5bXlOwER6QK58EQOiTUmLSNGkivq
         zopHoxc2OacmqtGzu5fOc2L7J0DF57P8INducGLLOu8OAjpju3wSCaTv/20VHHLZ4627
         fkw9ieiO++7ytGxZ2sfC4k1VlT9K6f6UlMZxWuuPE6IwZ4ExpC8PyzIC6ETRKINBsRgu
         CUQwfZdo3gjnMFv61LNVWgSIt217tzGv8KwefNguNMkzOKo97wOQE5WUDv6dxYaHUOnK
         y+s+7nHwVh8wbIHMu77t85VlxBvSlc2gn5FRroUB/I+Tl9IeU3rWYnvEBe52KVpM8M47
         KesA==
In-Reply-To: <20170420065847.18368-1-lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Apr 20, 2017 at 7:58 AM, Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> It is common for arm64 devices to boot from mmc & sd devices
> we need to assure that those drivers make it to the initrd.

The MMC host drivers are pulled in via local _blockfunc, the core are
pulled in via the deps of those so neither need to be listed here
explicitly. MFD is fine that way though.

Peter

> Signed-off-by: Jeremy Linton <lintonrjeremy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index b1bced69..5d022a9b 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -29,6 +29,9 @@ installkernel() {
>                  "=drivers/clk" \
>                  "=drivers/dma" \
>                  "=drivers/i2c/busses" \
> +                "=drivers/mfd" \
> +                "=drivers/mmc/core" \
> +                "=drivers/mmc/host" \
>                  "=drivers/phy" \
>                  "=drivers/power" \
>                  "=drivers/regulator" \
> --
> 2.12.2
>
