From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] resume: fix double escaping in printf
Date: Tue, 28 Jan 2014 15:41:15 +0100
Message-ID: <52E7C18B.8060009@redhat.com>
References: <1389372684-26465-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389372684-26465-1-git-send-email-zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= <zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/10/2014 05:51 PM, Zbigniew J=C4=99drzejewski-Szmek wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1045704
> ---
>  modules.d/95resume/parse-resume.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/modules.d/95resume/parse-resume.sh b/modules.d/95resume/=
parse-resume.sh
> index 8682a03..44c62dd 100755
> --- a/modules.d/95resume/parse-resume.sh
> +++ b/modules.d/95resume/parse-resume.sh
> @@ -59,10 +59,10 @@ if ! getarg noresume; then
>              fi
>              printf -- "KERNEL=3D=3D\"%s\", " ${resume#/dev/};
>              printf -- "ACTION=3D=3D\"add|change\", ENV{ID_FS_TYPE}=3D=
=3D\"suspend|swsuspend|swsupend\","
> -            printf -- "%s" " RUN+=3D\"/sbin/initqueue --finished --u=
nique --name 00resume echo %%M:%%m > /sys/power/resume\"\n"
> +            printf -- " RUN+=3D\"/sbin/initqueue --finished --unique=
 --name 00resume echo %%M:%%m > /sys/power/resume\"\n"
>              printf -- "SYMLINK=3D=3D\"%s\", " ${resume#/dev/};
> -            printf -- "%s" "ACTION=3D=3D\"add|change\", ENV{ID_FS_TY=
PE}=3D=3D\"suspend|swsuspend|swsupend\","
> -            printf -- "%s" " RUN+=3D\"/sbin/initqueue --finished --u=
nique --name 00resume echo %%M:%%m  > /sys/power/resume\"\n"
> +            printf -- "ACTION=3D=3D\"add|change\", ENV{ID_FS_TYPE}=3D=
=3D\"suspend|swsuspend|swsupend\","
> +            printf -- " RUN+=3D\"/sbin/initqueue --finished --unique=
 --name 00resume echo %%M:%%m  > /sys/power/resume\"\n"
>          } >> /etc/udev/rules.d/99-resume.rules
> =20
>          printf '[ -e "%s" ] && { ln -s "%s" /dev/resume; rm -f -- "$=
job" "%s/initqueue/timeout/resume.sh"; }\n' \
>=20

Thanks! Pushed a slightly different version
