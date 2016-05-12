From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dracut: Add drivers/tty/serial on arm
Date: Thu, 12 May 2016 21:04:33 +0100
Message-ID: <CALeDE9PW+KdECc_u2t4fv9-7ixyOwQ9JM=9sY-5290oFgAHhkQ@mail.gmail.com>
References: <1463066902-11767-1-git-send-email-kwizart@gmail.com>
	<1463066902-11767-2-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=by7lFUo1Br5vWCGjn7XZcSWNhzNcbEo4AjKWzk1Fk98=;
        b=nxdIToP4SxLFyivYzdWk6MZXis5IXrdnXskO96LNkM45KVoGhp5tTGD/jdrep+7jEY
         Iqg5adAZn3xSZoKyLnfFXdlbx9LpYMmNcQRt5BxUQYds4xZLLPHpUsfz3xt4bfM9m5tY
         /mVEwMrodRPSuLqHfpwCSOgweGCtnfUfa/TiYfo78kVVrxZ1vYD0+UL+iJFv4j2pEfu5
         LN4OH16ZmXARiYf4TnoByDb/idBKz41gdJ8sowXykZ86DQpkFtIDvnPN8FE0V9E48cT6
         9+v3UyIgy3IweiaE6cMjgCuSB/Fwm944LoY2F8YOYU1LC4FnVVtEqJnFGO8k6GFEs1/Z
         YgVQ==
In-Reply-To: <1463066902-11767-2-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, May 12, 2016 at 4:28 PM, Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This is needed when serial drivers are compiled as module on arm
> Current candidates are 8250_omap or msn_serial

Neither of these are used for serial consoles so why do they need to
be in the initrd?

Peter

> Signed-off-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index 7904c02..215f468 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -30,6 +30,7 @@ installkernel() {
>                  "=drivers/i2c/busses" \
>                  "=drivers/regulator" \
>                  "=drivers/rtc" \
> +                "=drivers/tty/serial" \
>                  "=drivers/usb/host" \
>                  "=drivers/usb/phy" \
>                  ${NULL}
> --
> 2.4.11
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
