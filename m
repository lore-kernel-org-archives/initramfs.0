From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 2/2] let user specify action after systemd start dracut-emergency
Date: Thu, 30 May 2013 16:50:24 +0800
Message-ID: <51A712D0.80002@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369816679.git.bhe@redhat.com> <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dc98d3640cb7f265d9a84a11b87e494635485e8d.1369816679.git.bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 04:38 PM, Baoquan He wrote:

> If failed to mount /sysroot, triggering OnFailure= dependencies
> of initrd-xxx.service, then dracut-emergency will be started by
> systemd and enter into emergency shell.
> 
> Here add a judgement in dracut-emergency. If user specify
> "action_on_fail=continue", continue though mount root failed.
> Otherwise enter into interactive shell.
> 
> v1-v2->
>       action_on_fail function can't be used directly here, discard
>       it. Instead add a judgement to handle this.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/98systemd/dracut-emergency.sh |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/98systemd/dracut-emergency.sh b/modules.d/98systemd/dracut-emergency.sh
> index 8ab045e..51e1f80 100755
> --- a/modules.d/98systemd/dracut-emergency.sh
> +++ b/modules.d/98systemd/dracut-emergency.sh
> @@ -30,7 +30,12 @@ if getargbool 1 rd.shell -d -y rdshell || getarg rd.break -d rdbreak; then
>      echo
>      [ -f /etc/profile ] && . /etc/profile
>      [ -z "$PS1" ] && export PS1="$_name:\${PWD}# "
> -    exec sh -i -l
> +    if [ "$(getarg action_on_fail=)" = "continue" ]; then
> +        echo "Systemd is starting dracut emergency"
> +        echo "NoT dropping to emergency shell, because 'action_on_fail=continue' was set on kernel command line"
> +    else
> +        exec sh -i -l
> +    fi
>  else
>      warn "$action has failed. To debug this issue add \"rd.shell rd.debug\" to the kernel command line."
>      exit 1


Hi Harald,

Since adding ConditionKernelCommandLine=!action_on_fail=continue doesn't
work, do you mind applying this patch? Or do you have other suggestions?

Baoquan
Thanks a lot




