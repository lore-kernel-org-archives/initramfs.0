From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fix gzip compress then it not supports rsyncable option
Date: Wed, 29 Oct 2014 14:13:41 +0100
Message-ID: <5450E805.4060200@redhat.com>
References: <1414406633-5262-1-git-send-email-v.tolstov@selfip.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414406633-5262-1-git-send-email-v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 27.10.2014 11:43, Vasiliy Tolstov wrote:
> dracut fail to create initramfs when compressor gzip and
> it not have rsyncable option
> 
> Signed-off-by: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
> ---
>  dracut.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 1c7e208..7aa1264 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -822,7 +822,7 @@ case $compress in
>      bzip2) compress="bzip2 -9";;
>      lzma)  compress="lzma -9 -T0";;
>      xz)    compress="xz --check=crc32 --lzma2=dict=1MiB -T0";;
> -    gzip)  compress="gzip -n -9 --rsyncable"; command -v pigz > /dev/null 2>&1 && compress="pigz -9 -n -T -R";;
> +    gzip)  compress="gzip -n -9"; command -v gzip --help 2>&1 | grep -q rsyncable && compress="gzip -n -9 --rsyncable"; command -v pigz > /dev/null 2>&1 && compress="pigz -9 -n -T -R";;
>      lzo)   compress="lzop -9";;
>      lz4)   compress="lz4 -l -9";;
>  esac
> 

Thanks! pushed
