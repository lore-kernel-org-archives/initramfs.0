From: Ross Lagerwall <ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Require all interfaces to be up before using iscsistart
 -b
Date: Mon, 15 Jun 2015 10:34:23 +0100
Message-ID: <557E9C1F.4060102@citrix.com>
References: <1431592211-5652-1-git-send-email-ross.lagerwall@citrix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431592211-5652-1-git-send-email-ross.lagerwall-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

ping!

On 05/14/2015 09:30 AM, Ross Lagerwall wrote:
> If multiple targets are specified in the ibft, iscsistart will log into
> all of them, possibly using multiple interfaces. Since iscsistart is run
> indirectly from ifup, require that all interfaces are up before actually
> logging into the targets.
> ---
>   modules.d/95iscsi/iscsiroot.sh |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/modules.d/95iscsi/iscsiroot.sh b/modules.d/95iscsi/iscsiroot.sh
> index 1de6fb7..b9e99cb 100755
> --- a/modules.d/95iscsi/iscsiroot.sh
> +++ b/modules.d/95iscsi/iscsiroot.sh
> @@ -45,6 +45,11 @@ fi
>
>   handle_firmware()
>   {
> +    # iscsistart -b may use multiple interfaces so only run when
> +    # all are ready.
> +    type all_ifaces_up >/dev/null 2>&1 || . /lib/net-lib.sh
> +    all_ifaces_up || return 1
> +
>       if ! [ -e /tmp/iscsistarted-firmware ]; then
>           if ! iscsistart -f; then
>               warn "iscistart: Could not get list of targets from firmware."
>
