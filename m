From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] cryptroot-ask: check that plymouth is running before
 use
Date: Fri, 11 Mar 2011 09:41:54 +0100
Message-ID: <4D79E052.6020806@redhat.com>
References: <1299797644-6951-1-git-send-email-arvidjaar@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299797644-6951-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 10.03.2011 23:54, schrieb Andrey Borzenkov:
> Otherwise there is no way to skip pasword prompt. --has-active-vt
> seems to correctly catch also the case when plymouthd is started
> but splash is disabled.
> 
> Signed-off-by: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
>  modules.d/90crypt/cryptroot-ask.sh |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
> index 5150688..9c99ccc 100755
> --- a/modules.d/90crypt/cryptroot-ask.sh
> +++ b/modules.d/90crypt/cryptroot-ask.sh
> @@ -80,9 +80,8 @@ if [ -n "$(getarg rd.luks.key)" ]; then
>      rmdir "$mntp"
>      unset mntp keypath keydev
>  else
> -    # Prompt for password with plymouth, if installed.
> -    # Should we check if plymouthd is running?
> -    if [ -x /bin/plymouth ]; then
> +    # Prompt for password with plymouth, if installed and running.
> +    if [ -x /bin/plymouth ] && /bin/plymouth --has-active-vt; then
>          prompt="Password [$device ($luksname)]:" 
>          if [ ${#luksname} -gt 8 ]; then
>              sluksname=${sluksname##luks-}

Very nice! Thank you!
