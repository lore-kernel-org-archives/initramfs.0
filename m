From: Dan =?ISO-8859-1?Q?Hor=E1k?= <dan-mBPqX7VnFd4@public.gmane.org>
Subject: Re: [PATCH 3/3] url-lib: fix progressbar on s390, again
Date: Sat, 12 May 2012 10:16:52 +0200
Message-ID: <1336810612.2985.14.camel@eagle.danny.cz>
References: <1336776308-15211-1-git-send-email-wwoods@redhat.com>
	 <1336776308-15211-3-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336776308-15211-3-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Will Woods p=C3=AD=C5=A1e v P=C3=A1 11. 05. 2012 v 18:45 -0400:=20
> It turns out that you can't rely on s390 setting TERM to anything
> useful, so we just have to disable progressbar on all s390 systems.

seems it will be the only solution, for an installed system there is
TERM set to "dumb" for the console, but in the initrd environment it's
set to "linux", probably the default from kernel itself.


Dan

---
> modules.d/45url-lib/url-lib.sh |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url=
-lib.sh
> index 5721294..8a50c6f 100755
> --- a/modules.d/45url-lib/url-lib.sh
> +++ b/modules.d/45url-lib/url-lib.sh
> @@ -56,9 +56,9 @@ export CURL_HOME=3D"/run/initramfs/url-lib"
>  mkdir -p $CURL_HOME
>  curl_args=3D"--location --retry 3 --fail --show-error"
> =20
> -# technically "dumb" can handle the progress bar, but the only thing=
 I've ever
> -# seen using TERM=3Ddumb is s390 CMS, and it's too dumb for --progre=
ss-bar
> -[ "$TERM" !=3D "dumb" ] && curl_args=3D"$curl_args --progress-bar"
> +# s390 x3270 consoles are too dumb for --progress-bar, and they don'=
t seem to
> +# set TERM usefully, so we just have to disable it for all s390 syst=
ems.
> +strstr "$(uname -m)" "s390" || curl_args=3D"$curl_args --progress-ba=
r"
> =20
>  curl_fetch_url() {
>      local url=3D"$1" outloc=3D"$2"

