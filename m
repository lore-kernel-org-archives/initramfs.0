From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i18n: fix udev error due to empty rules file
Date: Wed, 10 Nov 2010 15:22:51 +0100
Message-ID: <4CDAAABB.4090403@redhat.com>
References: <1288974698-21387-1-git-send-email-arvidjaar@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288974698-21387-1-git-send-email-arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/05/2010 05:31 PM, Andrey Borzenkov wrote:
> Empty rule file is causing udev error:
>
> dracut: udevd[99]: can not read '/etc/udev/rules.d/10-console.rules'
>
> Remove file completely instead of truncating it.
>
> Signed-off-by: Andrey Borzenkov<arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> ---
>   modules.d/10i18n/parse-i18n.sh |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/modules.d/10i18n/parse-i18n.sh b/modules.d/10i18n/parse-i18n.sh
> index 0a58cc2..8f7f8f8 100755
> --- a/modules.d/10i18n/parse-i18n.sh
> +++ b/modules.d/10i18n/parse-i18n.sh
> @@ -35,5 +35,5 @@ if [ -e /dev/tty0 ]; then
>       # if the device already exists, yes
>       # clear the udev rules and run it
>       /lib/udev/console_init /dev/tty0
> ->  /etc/udev/rules.d/10-console.rules
> +    rm /etc/udev/rules.d/10-console.rules
>   fi


http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=6545b9d7920cd4e09274b1d38d45c191e9991646
