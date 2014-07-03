From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] lsinitrd.sh: don't choke on LZO-compressed images
Date: Thu, 03 Jul 2014 09:22:04 +0200
Message-ID: <53B5049C.8030306@redhat.com>
References: <1401764374-17744-1-git-send-email-tobias.geerinckx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401764374-17744-1-git-send-email-tobias.geerinckx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tobias Geerinckx <tobias.geerinckx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03.06.2014 04:59, Tobias Geerinckx wrote:
> lsinitrd (and hence dracut) currently fail to list the contents of any
> LZO-compressed image, and merely spit out misleading xzcat errors.
> 
> I guess no-one actually uses them.
> ---
>  lsinitrd.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lsinitrd.sh b/lsinitrd.sh
> index a697bc2..4ba8752 100755
> --- a/lsinitrd.sh
> +++ b/lsinitrd.sh
> @@ -180,6 +180,9 @@ CAT=$({
>              $'\x02\x21'*)
>                  echo "lz4 -d -c"
>                  ;;
> +            $'\x89'LZO$'\0'*)
> +                echo "lzop -d -c"
> +                ;;
>              *)
>                  if echo "test"|xz|xzcat --single-stream >/dev/null 2>&1; then
>                      echo "xzcat --single-stream --"
> 

Thanks! In dracut-038
