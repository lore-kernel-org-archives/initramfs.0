From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] add function getargnum
Date: Fri, 11 Jan 2013 10:59:20 +0100
Message-ID: <50EFE278.6040509@redhat.com>
References: <20121126023847.GA6884@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121126023847.GA6884-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jstancek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 26.11.2012 03:38, schrieb Dave Young:
> 
> 
> For cmdline argument with numeric value, add a new function getargnum
> It will get proper value with default value as $1, max value as $2.
> valid result will be echo to stdout, for nul or value not valid it will just
> echo the default value.
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99base/dracut-lib.sh |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> --- dracut.orig/modules.d/99base/dracut-lib.sh
> +++ dracut/modules.d/99base/dracut-lib.sh
> @@ -167,6 +167,25 @@ getargbool() {
>      return 0
>  }
>  
> +# getargnum <defaultval> <maxval> <args...>
> +# Will echo the arg if it's in range [0 - maxval].
> +# If it's not set or it's not valid, will set it <defaultval>.
> +getargnum() {
> +    local _b
> +    unset _b
> +    local _default
> +    local _max
> +    _default=$1; shift
> +    _max=$1; shift
> +    _b=$(getarg "$@")
> +    [ $? -ne 0 -a -z "$_b" ] && _b=$_default
> +    if [ -n "$_b" ]; then
> +        [[ "$_b" =~ ^[0-9]+$ ]] && _b=$(($_b)) && \

we can't use "=~" because it's not posix shell. We restricted ourselves to dash
syntax in the initramfs. sorry.


> +        [[ $_b -ge 0 && $_b -le $_max ]] && echo $_b && return
> +    fi
> +    echo $_default
> +}
> +
>  _dogetargs() {
>      debug_off
>      local _o _found _key
> 
