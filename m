From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/5] network/netroot
Date: Fri, 12 Jun 2009 16:15:22 -0400
Message-ID: <4A32B75A.4090405@redhat.com>
References: <4A32703A.8080603@bfh.ch> <4A3271CC.9090608@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3271CC.9090608-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/12/2009 11:18 AM, Seewer Philippe wrote:
> +    # Default: We don't know the interface to use, handle all
> +    else +    printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup
> $env{INTERFACE}"\n'
> +    fi

"else +"?

BTW, could you please remove the die() and push all of this to a git 
repo so it can be pulled cleanly?

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
