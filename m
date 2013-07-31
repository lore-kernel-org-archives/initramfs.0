From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Wed, 31 Jul 2013 10:27:05 -0400
Message-ID: <20130731142705.GA1233@redhat.com>
References: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <73cc07330929ba4b226f2a0623a5459cd42932b9.1374574542.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Tue, Jul 23, 2013 at 06:16:00PM +0800, Baoquan He wrote:
> Currently when action_on_fail is enabled, the emergency_shell won't be called.
> In kdump even though user specify the default action as emergency_shell,
> dracut skip it. Now change the implementation of action_on_fail to depend
> on a file which is created by kdump when making kdump initrd, then remove it
> at the beginning of kdump. This can solve the explicit emergency_shell problem.
> 
> And action_on_fail won't need paramenters, remove the relevant description in
> dracut man page.

Bao,

I think if you are taking away the capability to specify the action on
failure, then parameter name action_on_fail does not make much sense to
me.

A new parameter named "rd.no_emergency_shell" might be better in this
case.

Thanks
Vivek

> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dracut.cmdline.7.asc                         |    4 ---
>  modules.d/98systemd/dracut-emergency.service |    2 +-
>  modules.d/98systemd/emergency.service        |    2 +-
>  modules.d/99base/dracut-lib.sh               |   28 +++++++++----------------
>  4 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/dracut.cmdline.7.asc b/dracut.cmdline.7.asc
> index cf11d50..09c47e8 100644
> --- a/dracut.cmdline.7.asc
> +++ b/dracut.cmdline.7.asc
> @@ -121,10 +121,6 @@ Misc
>     specify the controlling terminal for the console.
>     This is useful, if you have multiple "console=" arguments.
>  
> -**rd.action_on_fail=**_{shell|continue}_::
> -   Specify the action after failure. By default it's emergency_shell.
> -   'continue' means: ignore the current failure and go ahead.
> -
>  [[dracutkerneldebug]]
>  Debug
>  ~~~~~
> diff --git a/modules.d/98systemd/dracut-emergency.service b/modules.d/98systemd/dracut-emergency.service
> index a4b81bc..5a6d525 100644
> --- a/modules.d/98systemd/dracut-emergency.service
> +++ b/modules.d/98systemd/dracut-emergency.service
> @@ -13,7 +13,7 @@ DefaultDependencies=no
>  After=systemd-vconsole-setup.service
>  Wants=systemd-vconsole-setup.service
>  Conflicts=emergency.service emergency.target
> -ConditionKernelCommandLine=!action_on_fail=continue
> +ConditionPathExists=!/lib/dracut/no-emergency-shell
>  
>  [Service]
>  Environment=HOME=/
> diff --git a/modules.d/98systemd/emergency.service b/modules.d/98systemd/emergency.service
> index c19fe37..5f1eaa2 100644
> --- a/modules.d/98systemd/emergency.service
> +++ b/modules.d/98systemd/emergency.service
> @@ -12,7 +12,7 @@ Description=Emergency Shell
>  DefaultDependencies=no
>  After=systemd-vconsole-setup.service
>  Wants=systemd-vconsole-setup.service
> -ConditionKernelCommandLine=!action_on_fail=continue
> +ConditionPathExists=!/lib/dracut/no-emergency-shell
>  
>  [Service]
>  Environment=HOME=/
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index 8eeebf3..2a3d831 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -1003,24 +1003,16 @@ emergency_shell()
>  
>  action_on_fail()
>  {
> -    local _action=$(getarg rd.action_on_fail= -d action_on_fail=)
> -    case "$_action" in
> -        continue)
> -            [ "$1" = "-n" ] && shift 2
> -            [ "$1" = "--shutdown" ] && shift 2
> -            warn "$*"
> -            warn "Not dropping to emergency shell, because 'action_on_fail=continue' was set on the kernel command line."
> -            return 0
> -            ;;
> -        shell)
> -            emergency_shell $@
> -            return 1
> -            ;;
> -        *)
> -            emergency_shell $@
> -            return 1
> -            ;;
> -    esac
> +    if [ -f "$initdir/lib/dracut/no-emergency-shell" ]; then
> +        [ "$1" = "-n" ] && shift 2
> +        [ "$1" = "--shutdown" ] && shift 2
> +        warn "$*"
> +        warn "Not dropping to emergency shell, because 'action_on_fail=continue' was set on the kernel command line."
> +        return 0
> +    fi
> +
> +    emergency_shell $@
> +    return 1
>  }
>  
>  # Retain the values of these variables but ensure that they are unexported
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
