From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] dracut: Add drivers/clk by default on arm
Date: Tue, 7 Jun 2016 10:50:04 +0200
Message-ID: <6b6be825-8331-4de7-6cdd-bae0bc055f07@redhat.com>
References: <1463066902-11767-1-git-send-email-kwizart@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463066902-11767-1-git-send-email-kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 12.05.2016 um 17:28 schrieb Nicolas Chauvet:
> This will bundle clock drivers into the initramfs on arm
> 
> Tested on ti dm8148-t410 where adpll is needed on 4.6+ kernel
> This will avoid to rely on (maybe broken) bootloader clocks.
> 
> Theses modules are also usually loaded early. Having them bundled into
> the initramfs will avoid lot of deferred probes and others delay.
> 
> Signed-off-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  modules.d/90kernel-modules/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/modules.d/90kernel-modules/module-setup.sh b/modules.d/90kernel-modules/module-setup.sh
> index c30715d..7904c02 100755
> --- a/modules.d/90kernel-modules/module-setup.sh
> +++ b/modules.d/90kernel-modules/module-setup.sh
> @@ -26,6 +26,7 @@ installkernel() {
>          if [[ "$(uname -p)" == arm* ]]; then
>              # arm specific modules
>              instmods \
> +                "=drivers/clk" \
>                  "=drivers/i2c/busses" \
>                  "=drivers/regulator" \
>                  "=drivers/rtc" \
> 

Thanks! Pushed.
