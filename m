From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] split emergency_shell function
Date: Wed, 01 Aug 2012 14:42:36 +0200
Message-ID: <5019243C.40308@redhat.com>
References: <20120801100751.GA13552@dhcp-16-143.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120801100751.GA13552-je1gSBvt1Td3da3rpXeqgR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

pushed

Am 01.08.2012 12:07, schrieb Dave Young:
> 
> Kdump dracut hooks need to enter emergency shell, currently it directly call
> "sh -i -l", with recent dracut this does not work anymore without proper ctty.
> 
> It will be convinient to seperate a standalone function _emergency_shell for
> dracut modules to call.
> 
> ---
>  modules.d/99base/dracut-lib.sh |   58 ++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> --- dracut.orig/modules.d/99base/dracut-lib.sh
> +++ dracut/modules.d/99base/dracut-lib.sh
> @@ -864,6 +864,37 @@ wait_for_loginit()
>      rm -f /run/initramfs/loginit.pipe /run/initramfs/loginit.pid
>  }
>  
> +_emergency_shell()
> +{
> +    local _name="$1"
> +    if [ -x /lib/systemd/systemd ]; then
> +        > /.console_lock
> +        echo "PS1=\"$_name:\${PWD}# \"" >/etc/profile
> +        systemctl start emergency.service
> +        debug_off
> +        while [ -e /.console_lock ]; do sleep 1; done
> +        debug_on
> +    else
> +        echo "Dropping to debug shell."
> +        echo
> +        export PS1="$_name:\${PWD}# "
> +        [ -e /.profile ] || >/.profile
> +
> +        _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
> +        if [ -z "$_ctty" ]; then
> +            _ctty=console
> +            while [ -f /sys/class/tty/$_ctty/active ]; do
> +                _ctty=$(cat /sys/class/tty/$_ctty/active)
> +                _ctty=${_ctty##* } # last one in the list
> +            done
> +            _ctty=/dev/$_ctty
> +        fi
> +        [ -c "$_ctty" ] || _ctty=/dev/tty1
> +        strstr "$(setsid --help 2>/dev/null)" "ctty" && CTTY="-c"
> +        setsid $CTTY /bin/sh -i -l 0<$_ctty 1>$_ctty 2>&1
> +    fi
> +}
> +
>  emergency_shell()
>  {
>      local _ctty
> @@ -883,32 +914,7 @@ emergency_shell()
>      echo
>  
>      if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
> -        if [ -x /lib/systemd/systemd ]; then
> -            > /.console_lock
> -            echo "PS1=\"$_rdshell_name:\${PWD}# \"" >/etc/profile
> -            systemctl start emergency.service
> -            debug_off
> -            while [ -e /.console_lock ]; do sleep 1; done
> -            debug_on
> -        else
> -            echo "Dropping to debug shell."
> -            echo
> -            export PS1="$_rdshell_name:\${PWD}# "
> -            [ -e /.profile ] || >/.profile
> -
> -            _ctty="$(getarg rd.ctty=)" && _ctty="/dev/${_ctty##*/}"
> -            if [ -z "$_ctty" ]; then
> -                _ctty=console
> -                while [ -f /sys/class/tty/$_ctty/active ]; do
> -                    _ctty=$(cat /sys/class/tty/$_ctty/active)
> -                    _ctty=${_ctty##* } # last one in the list
> -                done
> -                _ctty=/dev/$_ctty
> -            fi
> -            [ -c "$_ctty" ] || _ctty=/dev/tty1
> -            strstr "$(setsid --help 2>/dev/null)" "ctty" && CTTY="-c"
> -            setsid $CTTY /bin/sh -i -l 0<$_ctty 1>$_ctty 2>&1
> -        fi
> +        _emergency_shell $_rdshell_name
>      else
>          warn "$action has failed. To debug this issue add \"rd.shell\" to the kernel command line."
>          # cause a kernel panic
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
