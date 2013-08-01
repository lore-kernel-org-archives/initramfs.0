From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Change the implementation of action_on_fail
Date: Thu, 1 Aug 2013 09:48:23 -0400
Message-ID: <20130801134823.GD15235@redhat.com>
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
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Jul 23, 2013 at 06:16:00PM +0800, Baoquan He wrote:

[..]
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

Bao,

Ok, so you have completely removed the parameter rd.action_on_fail. I got
confused with above message "'action_on_fail=continue' was set on the
kernel command line".

I see that it has been fixed in the commit and replaced with following
message.

"Not dropping to emergency shell, because $initdir/lib/dracut/no-emergency-shell exists."

This makes sense now.

Thanks
Vivek
