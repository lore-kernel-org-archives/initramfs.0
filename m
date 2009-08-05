From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Implement extended iscsi: rfc4173 syntax which allows
 specifying credentials
Date: Wed, 05 Aug 2009 16:23:05 +0200
Message-ID: <4A7995C9.100@redhat.com>
References: <1249029076-3531-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1249029076-3531-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/31/2009 10:31 AM, Hans de Goede wrote:
> As discussed before, it would be nice to be able to specify
> the iscsi chap credentials inside the netroot=iscsi:.....
> syntax, this patch implements this in a backwards compatible way, like
> this:
> iscsi:username:pass-savSHZN5Fh8qMp+WYRx65w@public.gmane.org::3260::iqn.2009-01.com.example:testdisk
> iscsi:username:pass:reverse:pass-savSHZN5Fh8qMp+WYRx65w@public.gmane.org::3260::iqn.2009-01.com.example:test
>
> The only downside is that the backwards compatibility is broken when there
> is an @ in the iscsi target name (very unlikely), that can still be used,
> but only like this:
> iscsi:@192.168.1.100::3260::iqn.2009-01.com.example:testdi@sk
> ---
>   modules.d/95iscsi/iscsiroot |   18 ++++++++++++++++++
>   1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
> index a9ad14a..e28cbaa 100755
> --- a/modules.d/95iscsi/iscsiroot
> +++ b/modules.d/95iscsi/iscsiroot
> @@ -77,6 +77,24 @@ fi
>   # override conf/commandline options by dhcp root_path
>   # FIXME this assumes that all values have been provided
>   OLDIFS="$IFS"
> +IFS=@
> +set $iroot
> +if [ $# -gt 1 ]; then
> +    authinfo=$1; shift
> +    iroot=$*
> +    # allow empty authinfo to allow having an @ in iscsi_target_name like this:
> +    # netroot=iscsi:@192.168.1.100::3260::iqn.2009-01.com.example:testdi@sk
> +    if [ -n "$authinfo" ]; then
> +        IFS=:
> +        set $authinfo
> +        iscsi_username=$1
> +        iscsi_password=$2
> +        if [ $# -gt 2 ]; then
> +            iscsi_in_username=$3
> +            iscsi_in_password=$4
> +        fi
> +    fi
> +fi
>   IFS=:
>   set $iroot
>   iscsi_target_ip=$1; shift

merged in git
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
