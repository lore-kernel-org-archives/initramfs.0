From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix "can't shift that many" crash with empty /proc/cmdline
Date: Tue, 17 May 2011 10:33:16 +0200
Message-ID: <4DD232CC.80402@gmail.com>
References: <1305587877-14485-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=V555gkHYDfAy6zqzcx2GK1++CDq4iVesrXoi0ZyuDBQ=;
        b=hpoeXW62KzDuGnptFp9+yuVQVD0YLheYkLNa8YV3/7tkesWUMEeSBS4uhMz6dmyXn9
         W1BL8WlTz7WBIetfHh0Iem6q8e7Ri21dfJw7gNSoI6cWjSBr7hIBWHcYkQRxJtIvdxRH
         Fkn10Bb1qPkObmkjyh98QdCmarMf3+twMUhck=
In-Reply-To: <1305587877-14485-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 17.05.2011 01:17, schrieb Will Woods:
> If /proc/cmdline is empty (like if root=... is set in /etc/cmdline),
> modules.d/99base/init will crash with a message saying "can't shift that
> many" right before switch_root. The problem is in the block of code that
> tries to look for init args. It does something like:
> 
> read CMDLINE </proc/cpuinfo
>     [...]
>     set $CMDLINE
>     shift
> 
> If CMDLINE="" then "set $CMDLINE" will dump all the variables to stdout.
> (That should be "set -- $CMDLINE" instead.) Since there's no $1, the
> "shift" causes an error, and dracut crashes.
> 
> The 'shift' was copy-and-pasted from the previous block. It doesn't
> belong here; remove it.
> 
> Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99base/init |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index e2c34c7..87778ac 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -361,8 +361,8 @@ if getarg init= >/dev/null ; then
>      ignoreargs="console BOOT_IMAGE"
>      # only pass arguments after init= to the init
>      CLINE=${CLINE#*init=}
> -        set $CLINE
> -        shift
> +        set -- $CLINE
> +        shift # clear out the rest of the "init=" arg
>          for x in "$@"; do
>              for s in $ignoreargs; do
>                  [ "${x%%=*}" = $s ] && continue 2
> @@ -372,8 +372,7 @@ if getarg init= >/dev/null ; then
>          unset CLINE
>  else
>      set +x # Turn off debugging for this section
> -    set $CLINE
> -    shift
> +    set -- $CLINE
>      for x in "$@"; do
>          case "$x" in
>              [0-9]|s|S|single|emergency|auto ) \


Thanks! Pushed
