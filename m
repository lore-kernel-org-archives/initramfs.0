From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut-lib.sh: typo fix
Date: Mon, 15 Jun 2015 11:32:33 +0200
Message-ID: <557E9BB1.8050702@redhat.com>
References: <1434358579-11674-1-git-send-email-lzhong@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434358579-11674-1-git-send-email-lzhong-IBi9RG/b67k@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Lidong Zhong <lzhong-IBi9RG/b67k@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 15.06.2015 10:56, Lidong Zhong wrote:
> Signed-off-by: Lidong Zhong <lzhong-IBi9RG/b67k@public.gmane.org>
> ---
>  modules.d/99base/dracut-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 6498f9d..08110cc 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -313,7 +313,7 @@ getargs() {
>      _args="$@"
>      set --
>      for _i in $_args; do
> -        if [ "$i" = "-d" ]; then
> +        if [ "$_i" = "-d" ]; then
>              _deprecated=1
>              continue
>          fi
> 

merged, thanks!
