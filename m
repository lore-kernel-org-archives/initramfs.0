From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] str_replace() fix
Date: Thu, 22 Sep 2011 15:46:39 +0200
Message-ID: <4E7B3C3F.7050302@redhat.com>
References: <1316069157-3063-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316069157-3063-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 15.09.2011 08:45, Michal Soltys wrote:
> Whitespace removal in:
> 
> 	out="${out}${chop# }$r"
> 
> will damage certain strings, for example the following call:
> 
> 	str_replace ' aax aaxaa' x y
> 
> would return 'aayaayaa' instead of ' aay aayaa'.
> 
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> ---
>  modules.d/99base/dracut-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 50b1ed2..62c3bf5 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -24,7 +24,7 @@ str_replace() {
>  
>      while strstr "${in}" "$s"; do
>          chop="${in%%$s*}"
> -        out="${out}${chop# }$r"
> +        out="${out}${chop}$r"
>          in="${in#*$s}"
>      done
>      echo "${out}${in}"

pushed to temporary git: http://git.surfsite.org/dracut.git
