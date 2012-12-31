From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] Add a special handler when mount rootfs failed
Date: Mon, 31 Dec 2012 16:12:41 +0800
Message-ID: <50E148F9.4050903@redhat.com>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe@redhat.com> <d98a268350d0f13f6dd4d464a1a21517668eeb57.1356080083.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d98a268350d0f13f6dd4d464a1a21517668eeb57.1356080083.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/21/2012 04:55 PM, Baoquan He wrote:
> Dracut will drop into shell in case anything wrong with rootfs mounting,
> but for kdump we does not depends on rootfs for non-rootfs dump and
> kdump will handle the default fail action based on user configuration
> in /etc/kdump.conf.
>
> Here call exception_handle_check and specify a handler continue_on_fail.
> If user add a cmdline like rd.exceptionhandler=continue_on_fail, then
> go on. If no cmdline rd.exceptionhandler=continue_on_fail added, just
> drop into shell as before.
>
> Signed-off-by: Baoquan He<bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   modules.d/98systemd/dracut-initqueue.sh |    7 ++++++-
>   1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/dracut-initqueue.sh
> index c10b32f..1d8d5a5 100755
> --- a/modules.d/98systemd/dracut-initqueue.sh
> +++ b/modules.d/98systemd/dracut-initqueue.sh
> @@ -102,9 +102,14 @@ while :; do
>       done
>
>       i=$(($i+1))
> -    [ $i -gt 20 ]&&  emergency_shell "Can't mount root filesystem"
In below code "$$" should be "&&". I tested this patchset by changing 
mount-loop limitation count to 1.
     +    [ $i -gt 20 ] && failure='yes' && break
> +    [ $i -gt 20 ]&&  failure='yes' $$ break
>   done
>
> +if [ "$failure" = "yes" ]; then
> +    exception_handle_check -h "continue_on_fail" "Can't mount root filesystem"
> +    failure="no"
> +fi
> +
>   {
>       echo -n "Mounted root filesystem "
>       while read dev mp rest; do [ "$mp" = "$NEWROOT" ]&&  echo $dev; done<  /proc/mounts
