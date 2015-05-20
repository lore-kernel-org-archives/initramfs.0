From: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the fs_passno of nfs to 0
Date: Wed, 20 May 2015 05:44:43 -0400 (EDT)
Message-ID: <834147643.1779220.1432115083557.JavaMail.zimbra@redhat.com>
References: <1432025842-25347-1-git-send-email-cfan@redhat.com> <20150520092534.GC7959@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520092534.GC7959-0VdLhd/A9PlfpSRLqpFUpR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

OK, thank you for your comment, I will update my patch according to your email.
Thanks,
Chao Fan

----- Original Message -----
From: "Baoquan He" <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: "Chao Fan" <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Sent: Wednesday, May 20, 2015 5:25:34 PM
Subject: Re: [PATCH] Change the fs_passno of nfs to 0

On 05/19/15 at 04:57pm, Chao Fan wrote:
> Set fs_passno, the sixth variable of fstab to "0" when the device is nfs.
> 
> The link of Bug 1186699:  bugzilla.redhat.com/show_bug.cgi?id=1186699
> The bug is that kdump-initrd contains entry requesting nfs dump filesystem
> to get filesystemchecked. And there is an erro message said that nfs need
> be checked.
> 
> In this issue, there's no fsck for nfs utility, e.g fsck.nfs like other
> file system. Whatever fs_passno 0 or 2 are passed, no fsck is executed
> at all for nfs mount.But in dracut, set it to be 2 always, so the erro
> message appear.
> 
> In the fstab,the sixth variable fs_passno stands for that the device need
> checked or not,and dracut set it to "2".To fix this issue, it should
> be "0" when the device is nfs.The third variable stands for the type of
> the filesystem and we can use it to judge whether the device is nfs.
> So when the third variable of fstab contains "nfs", the sixth variable
> fs_passno should be set to "0".

Could you rearrange your patch log to make it more clear? And erase the
redhat bugzilla stuff. This is dracut upstream mailing list, not a
certain distro.

> 
> Signed-off-by: Chao Fan <cfan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/dracut.sh b/dracut.sh
> index 6215b36..c22a8c0 100755
> --- a/dracut.sh
> +++ b/dracut.sh
> @@ -1517,7 +1517,13 @@ if [[ $kernel_only != yes ]]; then
>          line=($line)
>          [ -z "${line[3]}" ] && line[3]="defaults"
>          [ -z "${line[4]}" ] && line[4]="0"
> -        [ -z "${line[5]}" ] && line[5]="2"

Could it be like this? The curly braces looks uncomfortable. Surely you
need retest it if you would like to take my suggestion.

          [ -z "${line[5]}" ] && line[5]="2"
        strstr "${line[2]}" "nfs" && line[5]="0"

Thanks
Baoquan

> +        [ -z "${line[5]}" ] && {
> +        if strstr "${line[2]}" "nfs" ; then
> +                line[5]="0"
> +        else
> +                line[5]="2"
> +        fi
> +}
>          echo "${line[@]}" >> "${initdir}/etc/fstab"
>      done
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
