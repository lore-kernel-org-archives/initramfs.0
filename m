From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 21/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 10:15:36 +0100
Message-ID: <20090209091536.GA3205@nb.net.home>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com> <f81e4c7fec7010a32da9bd6e98c19eec70874af0.1234137268.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f81e4c7fec7010a32da9bd6e98c19eec70874af0.1234137268.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Feb 08, 2009 at 04:36:15PM -0800, Victor Lowther wrote:
> Simplified get_dso_deps
> 
> This takes advantage of several bash specific constructs to make
> get_dso_deps easier to read and understand.
> ---
>  dracut-functions |   85 +++++++++++++++++------------------------------------
>  1 files changed, 27 insertions(+), 58 deletions(-)
> 
> diff --git a/dracut-functions b/dracut-functions
> index 26254a4..d7717d8 100755
> --- a/dracut-functions
> +++ b/dracut-functions
> @@ -21,73 +21,42 @@
>  #       Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>  #       Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>  #       Jakub Jelinek <jakub-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> -#
> -#
>  
>  IF_RTLD=""
>  IF_dynamic=""
>  get_dso_deps() {
>      local bin="$1" ; shift
> +    local FILES=() LDSO NAME IO FILE ADDR I1 n f TLIBDIR
>  
> -    declare -a FILES
> -    declare -a NAMES
> -
> -    local LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null  |grep interpreter |awk {'print $4;'} |sed -e 's/]$//')
> -    [ -z "$LDSO" -o "$LDSO" == "$bin" ] && local LDSO="$IF_RTLD"
> -    [ -z "$LDSO" -o "$LDSO" == "$bin" ] && return 1
> -    [ -z "$IF_RTLD" ] && IF_RTLD="$LDSO"
> +    LDSO=$(LANG=C eu-readelf -l $bin 2>/dev/null | \
> +	awk '/interpreter/ {print $4}' |sed -e 's/]$//')

    awk '/interpreter/ { sub(/]$/,"",$4); print $4 }'

> +    [[ $LDSO && $LDSO != $bin ]] || LDSO="$IF_RTLD"
> +    [[ $LDSO && $LDSO != $bin ]] || return 1
> +    [[ $IF_RTLD ]] || IF_RTLD="$LDSO"

   IF_RTLD=${IF_RTLD:-"$LDSO"}

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
