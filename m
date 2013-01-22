From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch dracut v2] fix teamd exec in case config does not include
 devname
Date: Tue, 22 Jan 2013 15:35:43 +0100
Message-ID: <50FEA3BF.1090309@redhat.com>
References: <1357826571-1877-1-git-send-email-jiri@resnulli.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357826571-1877-1-git-send-email-jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 10.01.2013 15:02, schrieb Jiri Pirko:
> In case that configuration file did not include name of team device,
> teamd would not start. Fix this by adding "-t" parameter.
> 
> Signed-off-by: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
> ---
> 
> v2->v1:
> -fixed bad order of args
> 	
> modules.d/40network/ifup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
> index 216b1e3..6c3133e 100755
> --- a/modules.d/40network/ifup.sh
> +++ b/modules.d/40network/ifup.sh
> @@ -187,7 +187,7 @@ if [ -e /tmp/team.info ]; then
>              fi
>          done
>          # Do not add slaves now
> -        teamd -d -U -n -f /etc/teamd/$teammaster.conf
> +        teamd -d -U -n -t $teammaster -f /etc/teamd/$teammaster.conf
>          for slave in $working_slaves; do
>              # team requires the slaves to be down before joining team
>              ip link set $slave down
> 

merged
