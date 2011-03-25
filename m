From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 6/9] 40network: install dhclient, brctl and ifenslave
 optionally
Date: Fri, 25 Mar 2011 16:30:40 +0100
Message-ID: <4D8CB520.60504@bfh.ch>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-6-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-2?Q?Amadeusz_=AFo=B3nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 03/25/2011 03:56 PM, Amadeusz =AFo=B3nowski wrote:
> Warning given by check() function in case if any of those binaries
> doesn't exist was removed, because it's produces by "dracut_install -=
o"
> later.

I'll have to object to this, sorry. The current network implementation=20
does not check if these binaries are there and throws errors if ip=3Ddh=
cp=20
is provided and no dhclient is available.

> ---
>   modules.d/40network/module-setup.sh |    9 ++-------
>   1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/modules.d/40network/module-setup.sh b/modules.d/40networ=
k/module-setup.sh
> index 59f358f..f32745c 100755
> --- a/modules.d/40network/module-setup.sh
> +++ b/modules.d/40network/module-setup.sh
> @@ -11,12 +11,6 @@ check() {
>               return 1
>           fi
>       done
> -    for program in dhclient brctl ifenslave tr; do
> -        if ! type -P $program>/dev/null; then
> -            dwarn "Could not find program \"$program\" it might be r=
equired " \
> -                "by network."
> -        fi
> -    done
>
>       return 255
>   }
> @@ -48,7 +42,8 @@ installkernel() {
>   }
>
>   install() {
> -    dracut_install ip dhclient brctl arping ifenslave tr
> +    dracut_install ip arping tr
> +    dracut_install -o dhclient brctl ifenslave
>       inst "$moddir/ifup" "/sbin/ifup"
>       inst "$moddir/netroot" "/sbin/netroot"
>       inst "$moddir/dhclient-script" "/sbin/dhclient-script"
