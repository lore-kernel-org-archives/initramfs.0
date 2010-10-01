From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 99base/init: honor env. vars provided by kernel (PATH,
 HOME and TERM)
Date: Fri, 01 Oct 2010 11:39:02 +0200
Message-ID: <4CA5AC36.8080907@redhat.com>
References: <4c9e7524.9804cc0a.3175.65a0@mx.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4c9e7524.9804cc0a.3175.65a0-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/26/2010 12:06 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Let take a look at Linux sources, /usr/src/linux-2.6.35/init/main.c:
>
>    204: char * envp_init[MAX_INIT_ENVS+2] =3D { "HOME=3D/", "TERM=3Dl=
inux", NULL, };
>
>    857: run_init_process("/sbin/init");
>
>    817: static void run_init_process(char *init_filename)
>    818: {
>    819:        argv_init[0] =3D init_filename;
>    820:        kernel_execve(init_filename, argv_init, envp_init);
>    821: }
>
> As we can see HOME=3D/ and TERM=3Dlinux are provided for init and thi=
s might be
> expected on some systems (Gentoo comes to my mind, here ;-)).  That's=
 why we
> should give to init the same set of env. vars as Linux kernel does.
> ---
>   modules.d/99base/init |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/modules.d/99base/init b/modules.d/99base/init
> index 5a02ade..dc0a0df 100755
> --- a/modules.d/99base/init
> +++ b/modules.d/99base/init
> @@ -59,8 +59,8 @@ emergency_shell()
>       fi
>   }
>
> +OLD_PATH=3D"$PATH"
>   export PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
> -export TERM=3Dlinux
>   NEWROOT=3D"/sysroot"
>
>   trap "emergency_shell Signal caught!" 0
> @@ -327,8 +327,8 @@ info "Switching root"
>   wait_for_loginit
>
>   umask $OLD_UMASK
> -unset HOME
> -unset TERM
> +export PATH=3D"$OLD_PATH"
> +
>   exec switch_root "$NEWROOT" "$INIT" $initargs || {
>       echo "Something went very badly wrong in the initramfs.  Please=
 "
>       echo "file a bug against dracut."

pushed
