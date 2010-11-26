From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fix installation of `modules.builtin.bin'
Date: Fri, 26 Nov 2010 09:36:42 +0100
Message-ID: <4CEF719A.6060209@redhat.com>
References: <1290738077-17335-1-git-send-email-christian.ch.heinz@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290738077-17335-1-git-send-email-christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 26.11.2010 03:21, schrieb Christian Heinz:
> `modules.builtin.bin' is installed like a regular file, thereby ending
> up in the wrong place when `--kmoddir' is in effect. Fix this by
> specifying the installation destination.
> ---
>   modules.d/90kernel-modules/install |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
> index 863ffac..b635216 100755
> --- a/modules.d/90kernel-modules/install
> +++ b/modules.d/90kernel-modules/install
> @@ -4,4 +4,4 @@
>   [ -f /etc/modprobe.conf ]&&  dracut_install /etc/modprobe.conf
>   dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
>   inst_hook cmdline 01 "$moddir/parse-kernel.sh"
> -inst "$srcmods/modules.builtin.bin"
> +inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.builtin.bin"


pushed
