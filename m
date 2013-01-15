From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] Add an exception handle check function
Date: Tue, 15 Jan 2013 15:22:32 +0800
Message-ID: <50F503B8.2060501@redhat.com>
References: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <76d7b2f339455dcea6a2827b004bfcd9c6fa2315.1356080083.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Harald,

Could you review this patchset and give some suggestion?

Thanks a lot!


On 12/21/2012 04:55 PM, Baoquan He wrote:
> In some cases, exception happened, default handling is called. However,
> user may not like the handling, want to specify a handler for these
> exceptions.
>
> Add an exception handle check function. Call it where exceptions happened,
> and specify a extra special handler. If user want the special handler handles
> this exception, related cmdline is added.
>
> Then Dracut will check the cmdline, if related cmdline exists, call the
> specified handler; if not, call the default handler.
>
> The function can be called like below:
> exception_handle_check -h continue_on_fail
>
> Signed-off-by: Baoquan He<bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   modules.d/99base/dracut-lib.sh |   40 ++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
> index cc6c7e8..35ed3a3 100755
> --- a/modules.d/99base/dracut-lib.sh
> +++ b/modules.d/99base/dracut-lib.sh
> @@ -938,6 +938,46 @@ emergency_shell()
>       [ -e /run/initramfs/.die ]&&  exit 1
>   }
>
> +exception_handle_check()
> +{
> +    local action_wanted
> +    if [ "$1" = "-h" ]; then
> +        [ $# -le 1 ]&&  echo "No exception handler specified"&&  emergency_shell
> +        action_wanted=$2;
> +        case "$action_wanted" in
> +        continue_on_fail)
> +            ;;
> +        reboot)
> +            ;;
> +        emergency_shell)
> +            ;;
> +        *)
> +            echo "Wrong exception handler input: $action_wanted"
> +            action_wanted=emergency_shell
> +        esac
> +    else
> +        action_wanted=emergency_shell
> +    fi
> +
> +    case "$action_wanted" in
> +    continue_on_fail)
> +        action=$(getarg rd.exceptionhandler=)
> +        [ -z "$action" -o  "$action" != "continue_on_fail" ]&&  emergency_shell
> +        ;;
> +    emergency_shell)
> +        emergency_shell
> +        ;;
> +    reboot)
> +        reboot -f
> +        ;;
> +    *) #default
> +        ##impossible come here
> +        ;;
> +    esac
> +
> +    return 0
> +}
> +
>   # Retain the values of these variables but ensure that they are unexported
>   # This is a POSIX-compliant equivalent of bash's "export -n"
>   export_n()
