From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] Bring up multipath devices that are configured in
 multipath.conf.
Date: Wed, 25 Nov 2009 16:53:42 +0100
Message-ID: <4B0D5306.8050706@redhat.com>
References: <4B0D4A9F.1090606@redhat.com> <1259162752-22372-5-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259162752-22372-5-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Patch 1-3 look good.

On 11/25/2009 04:25 PM, Peter Jones wrote:
> This brings up multipath devices which are configured in multipath.conf
> as we find them.
> ---
>   modules.d/90multipath/14-multipath-scan.rules |    9 +++++++++
>   modules.d/90multipath/install                 |    3 +++
>   modules.d/90multipath/multipath-scan.sh       |   16 ++++++++++++++++
>   3 files changed, 28 insertions(+), 0 deletions(-)
>   create mode 100644 modules.d/90multipath/14-multipath-scan.rules
>   create mode 100644 modules.d/90multipath/multipath-scan.sh
>
> diff --git a/modules.d/90multipath/14-multipath-scan.rules b/modules.d/90multipath/14-multipath-scan.rules
> new file mode 100644
> index 0000000..b4acf57
> --- /dev/null
> +++ b/modules.d/90multipath/14-multipath-scan.rules
> @@ -0,0 +1,9 @@
> +# scan for multipath devices
> +SUBSYSTEM!="block", GOTO="end_mpath_scan"
> +KERNEL!="sd*", GOTO="end_mpath_scan"
> +PROGRAM=="/bin/sh -c 'for i in //holders/dm-[0-9]*; do [ -e $$i ]&&  exit 0; done; exit 1;' ", GOTO="end_mpath_scan"
> +RUN+="/sbin/modprobe dm-multipath"
> +RUN+="/bin/echo 'queuing multipath scan'"
> +RUN+="/sbin/initqueue --settled --onetime --unique --name=mpscan /sbin/multipath-scan"
> +RUN+="/bin/sh -c '>/tmp/.multipath-scan-%k;'"
> +LABEL="end_mpath_scan"

Hmm, I just realized something, this rule will keep on triggering if a disk is
not part of a multipath setup. As in that case it will never become a holder
of a device mapper device.

And since things like opening /dev/sda rw (which /sbin/multipath might
very well do), trigger a change event, this feels like an infinite loop to me.

Maybe this rule should have a
ACTION!="add", GOTO="end_mpath_scan"

?

I think it would be best to discuss this with Harald.

Regards,

Hans
