From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3] Change the fs_passno of nfs to 0
Date: Tue, 02 Jun 2015 12:25:56 +0200
Message-ID: <556D84B4.1050809@redhat.com>
References: <1432116434-18050-1-git-send-email-cfan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432116434-18050-1-git-send-email-cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

pushed, thanks

On 20.05.2015 12:07, Chao Fan wrote:
> There is a bug that kdump-initrd contains entry requesting nfs dump
> filesystem to get filesystemchecked. And there is an erro message said
> that nfs need be checked. But there's no fsck for nfs utility, e.g
> fsck.nfs like other file system. Whatever fs_passno 0 or 2 are passed,
> no fsck is executed at all for nfs mount.But in dracut, set it to be 2
> always, so the erro message appear and it should be set to 0.
> 
> In the fstab,the sixth variable fs_passno stands for that the device need
> checked or not,and dracut set it to "2".To fix this issue, it should
> be "0" when the device is nfs.The third variable stands for the type of
> the filesystem and we can use it to judge whether the device is nfs.
> So when the third variable of fstab contains "nfs", the sixth variable
> fs_passno should be set to "0".
> 
> Signed-off-by: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 6215b36..2d1860f 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1518,6 +1518,7 @@ if [[ $kernel_only != yes ]]; then
>          [ -z "${line[3]}" ] && line[3]="defaults"
>          [ -z "${line[4]}" ] && line[4]="0"
>          [ -z "${line[5]}" ] && line[5]="2"
> +        strstr "${line[2]}" "nfs" && line[5]="0"
>          echo "${line[@]}" >> "${initdir}/etc/fstab"
>      done
>  
> 
