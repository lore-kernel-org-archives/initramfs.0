From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] use lib function ismounted in convertfs module
Date: Thu, 20 Sep 2012 10:38:04 +0200
Message-ID: <505AD5EC.9020704@redhat.com>
References: <20120917100110.GA18642@darkstar.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120917100110.GA18642-4/PLUo9XfK+sDdueE5tM26fLeoKvNuZc@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Hmm, I want the convertfs.sh script to be dracut independent, so other it can be
used as a standalone script for the conversion.

Am 17.09.2012 12:01, schrieb Dave Young:
> 
> convertfs module use a private function of ismounted(), this is
> duplicate of the one in dracut-lib.sh.
> 
> Change to use global ismounted
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/30convertfs/convertfs.sh |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --- dracut.orig/modules.d/30convertfs/convertfs.sh
> +++ dracut/modules.d/30convertfs/convertfs.sh
> @@ -9,6 +9,8 @@ if [[ ! -d "$ROOT" ]]; then
>      exit 1
>  fi
>  
> +type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
> +
>  if [[ "$ROOT" -ef / ]]; then
>      echo "Can't convert the running system."
>      echo "Please boot with 'rd.convertfs' on the kernel command line,"
> @@ -73,13 +75,6 @@ if [[ ! -e "$testfile" ]]; then
>  fi
>  rm -f "$testfile"
>  
> -ismounted() {
> -    while read a m a; do
> -        [[ "$m" = "$1" ]] && return 0
> -    done < /proc/mounts
> -    return 1
> -}
> -
>  # clean up after ourselves no matter how we die.
>  cleanup() {
>      echo "Something failed. Move back to the original state"
> 
