From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] crypt: Wait for udev to settle before unlocking disk
Date: Wed, 31 Jul 2013 15:51:05 +0200
Message-ID: <51F91649.3090203@redhat.com>
References: <1375128622-8307-1-git-send-email-jlee@thestaticvoid.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375128622-8307-1-git-send-email-jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Lee <jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/29/2013 10:10 PM, James Lee wrote:
> To eliminate a race condition that occurs when unlocking one device
> depends on the result of unlocking a device before it, the crypt
> module must wait for udev to settle between each unlock attempt.
> 
> Example
> 
> /etc/crypttab:
> 
>   keyfile /dev/md1 none luks
>   sda4_crypt /dev/sda4 /dev/mapper/keyfile luks
>   sdb4_crypt /dev/sdb4 /dev/mapper/keyfile luks
> 
> Without this patch, sometimes /dev/sda4 fails to unlock because udev
> doesn't have time to create /dev/mapper/keyfile before it's needed.
> ---
>  modules.d/90crypt/parse-crypt.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
> index 961ec61..4e42d59 100755
> --- a/modules.d/90crypt/parse-crypt.sh
> +++ b/modules.d/90crypt/parse-crypt.sh
> @@ -23,7 +23,7 @@ else
>                  {
>                      printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
>                      printf -- 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
> -                    printf -- 'RUN+="%s --unique --onetime ' $(command -v initqueue)
> +                    printf -- 'RUN+="%s --settled --unique --onetime ' $(command -v initqueue)
>                      printf -- '--name cryptroot-ask-%%k %s ' $(command -v cryptroot-ask)
>                      printf -- '$env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $tout
>                  } >> /etc/udev/rules.d/70-luks.rules.new
> @@ -31,7 +31,7 @@ else
>                  {
>                      printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", '
>                      printf -- 'ENV{ID_FS_UUID}=="*%s*", ' $luksid
> -                    printf -- 'RUN+="%s --unique --onetime ' $(command -v initqueue)
> +                    printf -- 'RUN+="%s --settled --unique --onetime ' $(command -v initqueue)
>                      printf -- '--name systemd-cryptsetup-%%k %s start ' $(command -v systemctl)
>                      printf -- 'systemd-cryptsetup@luks$$(dev_unit_name -$env{ID_FS_UUID}).service"\n'
>                  } >> /etc/udev/rules.d/70-luks.rules.new
> @@ -51,13 +51,13 @@ else
>          if [ -z "$DRACUT_SYSTEMD" ]; then
>              {
>                  printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="%s ' $(command -v initqueue)
> -                printf -- '--unique --onetime --name cryptroot-ask-%%k '
> +                printf -- '--unique --settled --onetime --name cryptroot-ask-%%k '
>                  printf -- '%s $env{DEVNAME} luks-$env{ID_FS_UUID} %s"\n' $(command -v cryptroot-ask) $tout
>              } >> /etc/udev/rules.d/70-luks.rules.new
>          else
>              {
>                  printf -- 'ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="%s ' $(command -v initqueue)
> -                printf -- '--unique --onetime --name crypt-run-generator-%%k '
> +                printf -- '--unique --settled --onetime --name crypt-run-generator-%%k '
>                  printf -- '%s $env{DEVNAME} luks-$env{ID_FS_UUID}"\n' $(command -v crypt-run-generator)
>              } >> /etc/udev/rules.d/70-luks.rules.new
>          fi
> 


thanks! pushed
