From: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dracut: Add drivers/tty/serial on arm
Date: Mon, 6 Jun 2016 10:49:48 +0200
Message-ID: <CABr+WTkOJS0ZXEymgi7ackzVEZk-2-52FhtfK3x2-EQGn9xCdA@mail.gmail.com>
References: <1463066902-11767-1-git-send-email-kwizart@gmail.com> <1463066902-11767-2-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wVgnYDl7WaGvJuJcQrBg3AudYdL5B4CmzN/j9b0bod8=;
        b=tAPdl7mNHwnwBOXkMDOsQITn5c6d/Es74B5DdW/NnpQJEjQTFX+Ac1qYk5+QUKQgZO
         fUdDs7gYpZi2AdnQEUaEA2V2bp350YaQEbOVBabKS7knakzA13s8tDPg3LRCnSHEyYGx
         5SdNazmE2sBBnVKrtMkFLJa/gEg9Ev2zc5U84WqBOd2IH8qrjdE0GZsQxe2/GvjhUmFh
         fgPmzk4AyiIh9BxYxYsOP0hrXVaZPwYt98Sb3alGhjy1967yGUMcGQMPymnoxg2Qj/V5
         ai0jDcLA+b/FI73y8wCJovZf1l/FDVMFgSzENO2ktkjlF+kdFS9GcwqKoMu2thK6fJ7o
         mBVg==
In-Reply-To: <1463066902-11767-2-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

2016-05-12 17:28 GMT+02:00 Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> This is needed when serial drivers are compiled as module on arm
> Current candidates are 8250_omap or msn_serial
>
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
@peter, thx for review, and sorry for the late answear.


I've got the following confirmation by the upstream msn_serial maintainer:

<sboyd> nchauvet: if the tty driver is built as a module the console
part can't be used
<sboyd> you can run a getty though
<sboyd> I've done that to test the module loading of that driver and
it works fine

It means that bundling the tty_serial as a module into the initramfs
would requires to have a getty.
Given that there is currently no need to have a getty into the
initrafms I expect this can wait for the rootfs to be available.
So I discard this patch.

FYI the reason why I've started to experiment building the msm_serial
as a module is because there is a a spurious message related to msm
init() even on unrelated hardware (so before probe())
[    3.135866] msm_serial: driver initialized


Is there any issue with the other patch ? (it's unrelated to this one).

-- 
-

Nicolas (kwizart)
