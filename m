From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 98systemd: also install systemd-journald-dev-log.socket
Date: Thu, 03 Jul 2014 09:22:27 +0200
Message-ID: <53B504B3.3080605@redhat.com>
References: <1403170705-1936-1-git-send-email-farbing@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403170705-1936-1-git-send-email-farbing-S0/GAf8tV78@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Daniel Schaal <farbing-S0/GAf8tV78@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 19.06.2014 11:38, Daniel Schaal wrote:
> The /dev/log socket was moved to /run on systemd 214, install the
> newly added socket unit.
> ---
>  modules.d/98systemd/module-setup.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/modules.d/98systemd/module-setup.sh b/modules.d/98systemd/module-setup.sh
> index cf1b2e7..bf3f4b1 100755
> --- a/modules.d/98systemd/module-setup.sh
> +++ b/modules.d/98systemd/module-setup.sh
> @@ -106,6 +106,7 @@ install() {
>          $systemdsystemunitdir/sockets.target.wants/systemd-udevd-control.socket \
>          $systemdsystemunitdir/sockets.target.wants/systemd-udevd-kernel.socket \
>          $systemdsystemunitdir/sockets.target.wants/systemd-journald.socket \
> +        $systemdsystemunitdir/sockets.target.wants/systemd-journald-dev-log.socket \
>          $systemdsystemunitdir/sysinit.target.wants/systemd-udevd.service \
>          $systemdsystemunitdir/sysinit.target.wants/systemd-udev-trigger.service \
>          $systemdsystemunitdir/sysinit.target.wants/kmod-static-nodes.service \
> 

Thanks! In dracut-038
