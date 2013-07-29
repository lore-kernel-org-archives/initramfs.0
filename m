From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] base: setup correct system time and time zone in initrd
Date: Mon, 29 Jul 2013 09:08:31 +0200
Message-ID: <51F614EF.3090306@redhat.com>
References: <20130606095611.GA29287@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130606095611.GA29287-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/06/2013 11:56 AM, WANG Chao wrote:
> Currently in initrd, hardware clock is always considered to use UTC time
> format and system time zone is also UTC. Thus system time isn't correct
> if hw clock is localtime or we're using other time zone in real root.
> 
> To fix this, install /etc/adjtime and /etc/localtime to initrd. If not
> using systemd, install /usr/sbin/hwclock for dracut init to setup system
> time.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  modules.d/99base/init.sh         |  9 +++++++++
>  modules.d/99base/module-setup.sh | 11 +++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/modules.d/99base/init.sh b/modules.d/99base/init.sh
> index 880a2c0..c72129b 100755
> --- a/modules.d/99base/init.sh
> +++ b/modules.d/99base/init.sh
> @@ -55,6 +55,15 @@ if ! ismounted /dev; then
>      exit 1
>  fi
>  
> +# setup system time
> +if [ -f /etc/adjtime ]; then
> +    if strstr "$(cat /etc/adjtime)" LOCAL; then
> +        hwclock --hctosys --localtime
> +    else
> +        hwclock --hctosys --utc
> +    fi
> +fi
> +
>  # prepare the /dev directory
>  [ ! -h /dev/fd ] && ln -s /proc/self/fd /dev/fd >/dev/null 2>&1
>  [ ! -h /dev/stdin ] && ln -s /proc/self/fd/0 /dev/stdin >/dev/null 2>&1
> diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
> index 4955b7b..77ba79c 100755
> --- a/modules.d/99base/module-setup.sh
> +++ b/modules.d/99base/module-setup.sh
> @@ -28,6 +28,17 @@ install() {
>      egrep '^root:' "$initdir/etc/passwd" 2>/dev/null || echo  'root:x:0:0::/root:/bin/sh' >> "$initdir/etc/passwd"
>      egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
>  
> +    # install /etc/adjtime and time zone data
> +    if [[ $hostonly ]]; then
> +        dracut_install -o /etc/adjtime \
> +                          /etc/localtime
> +    fi
> +
> +    # Our init.sh script needs hwclock to set system time
> +    if [[ $hostonly ]] && ! dracut_module_included "systemd"; then
> +        dracut_install -o hwclock
> +    fi
> +
>      # install our scripts and hooks
>      inst_script "$moddir/init.sh" "/init"
>      inst_script "$moddir/initqueue.sh" "/sbin/initqueue"
> 

Hmm, people do not like it :-/

Bug 981617 - please take /etc/adjtime out of the initramfs so it doesn't
override the existing file system version

https://bugzilla.redhat.com/show_bug.cgi?id=981617

