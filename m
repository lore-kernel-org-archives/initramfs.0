From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch] Check rd.zfcp= format in dracut hook:cmdline process
 stage
Date: Fri, 13 Nov 2015 14:02:38 +0100
Message-ID: <5645DF6E.4020804@redhat.com>
References: <1444961074-5096-1-git-send-email-bjzgdeng@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444961074-5096-1-git-send-email-bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Zhiguo Deng <bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 16.10.2015 04:04, Zhiguo Deng wrote:
> When using rd.zfcp= parameter in generic.prm file, wrong format
> parameters will prevent the zfcp driver to add the correct SCSI
> disk. dracut should die when a wrong rd.zfcp= parameter supplied.
> 
> Signed-off-by: Zhiguo Deng <bjzgdeng-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> ---
>  modules.d/95zfcp/parse-zfcp.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/modules.d/95zfcp/parse-zfcp.sh b/modules.d/95zfcp/parse-zfcp.sh
> index 9b22d93..91d790b 100755
> --- a/modules.d/95zfcp/parse-zfcp.sh
> +++ b/modules.d/95zfcp/parse-zfcp.sh
> @@ -5,6 +5,8 @@
>  getargbool 1 rd.zfcp.conf -d -n rd_NO_ZFCPCONF || rm /etc/zfcp.conf
>  
>  for zfcp_arg in $(getargs rd.zfcp -d 'rd_ZFCP='); do
> +    echo $zfcp_arg | grep '0\.[0-9a-fA-F]\.[0-9a-fA-F]\{4\},0x[0-9a-fA-F]\{16\},0x[0-9a-fA-F]\{16\}' >/dev/null
> +    test $? -ne 0 && die "For argument 'rd.zfcp=$zfcp_arg'\nSorry, invalid format."
>      (
>          IFS=","
>          set $zfcp_arg
> 

Thanks! Pushed.
