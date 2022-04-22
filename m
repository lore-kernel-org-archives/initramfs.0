From: German Maglione <gmaglione-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: dmsquash-live: overlay module can be built-in the kernel
Date: Fri, 22 Apr 2022 13:04:45 +0200
Message-ID: <CAJh=p+6s1q3yxVxTPePDOx1JyGKi+14RXqtzHirqYYtAihdqww@mail.gmail.com>
References: <20220420071523.1185188-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650625531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=890HH12pAxh81Z6jD2R6oguD5HKqGJxngJqHFRfe7BI=;
        b=aDCCBso+F6zy5Daks5yQ/Oi7vVPhv3O3Nb0AN5pt5Hx5IlOqtzboi9OGxkXmlpdg2cKF2e
        VqFj0xg1tRL37NjOqFHF2NXZwH7fT6/1LHfE6kt5y3FED5CUUSMKIOXDKjG6vJ9JZFV7rr
        1108qT6QVybey8jnb9eVYtXV80cVPiQ=
In-Reply-To: <20220420071523.1185188-1-federico.vaga-vJEk5272eHo@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Apr 20, 2022 at 9:17 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>
> The dmsquash-live module assumes that `overlay` is always a module.
> Therefore, when `overlay` is built-in the kernel, this module will fail
> to detect the presence of such a feature.
>
> This patch adds a fallback mechanism to check also `/proc/filesystem`.
> This is also what happens with the dracut NSF module when loading the
> kernel module `rpc_pipefs`.
>
> Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
> ---
>  modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> index fd8a858a..b4a44e92 100755
> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> @@ -170,7 +170,7 @@ do_live_overlay() {
>          fi
>      fi
>      if [ -n "$overlayfs" ]; then
> -        if ! modprobe overlay; then
> +        if ! (modprobe overlay || strstr "$(cat /proc/filesystems)" overlay); then

if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then

I recently made the same mistake of using a subshell.

>              if [ "$overlayfs" = required ]; then
>                  die "OverlayFS is required but not available."
>                  exit 1
> --
> 2.27.0
>


-- 
German

