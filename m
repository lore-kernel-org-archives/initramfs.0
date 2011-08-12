From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] parse-lvm.sh: fix for generated initqueue/finished script
Date: Fri, 12 Aug 2011 08:07:31 +0200
Message-ID: <4E44C323.2040001@redhat.com>
References: <1311856810-2481-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1311856810-2481-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 28.07.2011 14:40, Michal Soltys wrote:
> The script that was generated always returned the status of the last test
> condition, potentially missing any earlier non-existing devices.
> 
> The change assures, that the script returns 0 only if all expected
> devices are found.
> 
> Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
> ---
>  modules.d/90lvm/parse-lvm.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/modules.d/90lvm/parse-lvm.sh b/modules.d/90lvm/parse-lvm.sh
> index 2e21d82..b85a1ac 100755
> --- a/modules.d/90lvm/parse-lvm.sh
> +++ b/modules.d/90lvm/parse-lvm.sh
> @@ -10,7 +10,7 @@ if ! getargbool 1 rd.lvm -n rd_NO_LVM; then
>      rm -f /etc/udev/rules.d/64-lvm*.rules
>  else
>      for dev in $(getargs rd.lvm.vg rd_LVM_VG=) $(getargs rd.lvm.lv rd_LVM_LV=); do
> -        printf '[ -e "/dev/%s" ]\n' $dev \
> +        printf '[ -e "/dev/%s" ] || return 1\n' $dev \
>              >> $hookdir/initqueue/finished/lvm.sh
>          {
>              printf '[ -e "/dev/%s" ] || ' $dev

pushed
