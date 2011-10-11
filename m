From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] bash3 compat patch
Date: Tue, 11 Oct 2011 07:11:41 +0000 (UTC)
Message-ID: <j70q7d$ldn$1@dough.gmane.org>
References: <1318283885-1792-1-git-send-email-soltys@ziu.info>
	<1318283885-1792-2-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 10 Oct 2011 23:58:04 +0200, Michal Soltys wrote:

> +            function rotor() {
> +                local _f1 _f2
> +                while read _f1; do
> +                    echo "$_f1"
> +                    if read _f2; then 
> +                        echo "$_f2" 1>&${_side2} 
> +                    fi
> +                done | bmf1 1>&${_merge} +            }
>              # Use two parallel streams to filter alternating modules.
> -            local merge side2
> -            ( ( local _f1 _f2
> -                while  read _f1; do   echo "$_f1" 
> -                   if read _f2; then echo "$_f2" 1>&${side2}; fi 
> -                done \
> -                | bmf1     1>&${merge}    ) {side2}>&1 \ 
> -             
>   | bmf1  )      {merge}>&1 
> +            eval "( ( rotor ) ${_side2}>&1
> | bmf1 ) ${_merge}>&1"
>          }
>          hostonly='' instmods sr_mod sd_mod scsi_dh scsi_dh_rdac
>          scsi_dh_emc hostonly='' instmods pcmcia firewire-ohci

Interesting function, if i understand it correctly, it parallelizes
the stream into two so that can speed up the pattern filtering?

My brain spins...
