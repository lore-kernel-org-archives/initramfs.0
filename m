From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 95ssh-client: attempt to copy UserKnownHostsFile to
 kdump's initramfs
Date: Fri, 2 Dec 2016 10:00:04 +0800
Message-ID: <20161202020004.GB3329@dhcp-128-65.nay.redhat.com>
References: <1480039895-20001-1-git-send-email-tonli@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480039895-20001-1-git-send-email-tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/25/16 at 10:11am, Tong Li wrote:
> Bug related to this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1360131
> Now dracut only attempts to copy GlobalKnownHostsFile while generating kdump's
> initramfs. This method will cause kdump's failure if users set customized
> UserKnownHostsFile in /etc/ssh/ssh_config. This patch simply attempts to copy
> those files too while going through /etc/ssh/ssh_config. Note that we need to
> make sure ~/foo will be copied as /root/foo in kdump's initramfs.
> 
> Signed-off-by: Tong Li <tonli-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/95ssh-client/module-setup.sh | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/modules.d/95ssh-client/module-setup.sh b/modules.d/95ssh-client/module-setup.sh
> index 0a0e80c..bebcae5 100755
> --- a/modules.d/95ssh-client/module-setup.sh
> +++ b/modules.d/95ssh-client/module-setup.sh
> @@ -45,11 +45,18 @@ inst_sshenv()
>          inst_simple /etc/ssh/ssh_config
>          sed -i -e 's/\(^[[:space:]]*\)ProxyCommand/\1# ProxyCommand/' ${initdir}/etc/ssh/ssh_config
>          while read key val || [ -n "$key" ]; do
> -            [[ $key != "GlobalKnownHostsFile" ]] && continue
> -            inst_simple "$val"
> -            break
> -        done < /etc/ssh/ssh_config
> -    fi
> +            if [ $key != "GlobalKnownHostsFile" ]; then
> +                inst_simple "$val"
> +            # Copy customized UserKnowHostsFile
> +            elif [ $key != "UserKnownHostsFile" ]; then
> +                # Make sure that ~/foo will be copied as /root/foo in kdump's initramfs
> +                if str_starts "$val" "~/"; then
> +                    val="/root/${val#"~/"}"

This should be handled by inst_* automaticlly, really should not be
here.

> +                fi
> +                inst_simple "$val"
> +            fi

The if/else means we install either Global or User knownhostsfile.
Actually both of them can coexist, should install them all if exist.

> +         done < /etc/ssh/ssh_config
> +     fi
>  
>      return 0
>  }
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
