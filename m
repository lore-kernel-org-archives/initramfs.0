From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Makefile: installing configs from dracut.conf.d and README
 files
Date: Thu, 01 Jul 2010 09:47:20 +0200
Message-ID: <4C2C4808.5050906@redhat.com>
References: <20100630213946.1dd59b45@etiriah>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100630213946.1dd59b45@etiriah>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/30/2010 09:39 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Install configs from dracut.conf.d (in source tree) into
> /usr/share/doc/dracut-$(VERSION).  It is so, because the package
> maintainer or user should decide which configs should be included by
> Dracut.  The configs in dracut.conf.d need to have suffix ".example".
> This is so, because we'd like to use configs in Dracut local mode and
> not including them all.  Just create symlink like
> foo.conf.example ->  foo.conf to load it when calling dracut with '-l=
'.
>
> I've also provided READMEs install for, I hope, users convenience.
>
> (I'm using configs in this way in i18n module.  If it's OK, I'll
> prepare final patch with i18n module.)


Is it really necessary to compress them?

>
> ---
>   Makefile |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a009b97..8e26b00 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,5 +1,6 @@
>   VERSION=3D006
>   GITVERSION=3D$(shell [ -d .git ]&&  git rev-list  --abbrev-commit  =
-n 1 HEAD  |cut -b 1-8)
> +COMPRESS=3Dbzip2 -f
>
>   prefix ?=3D /usr
>   datadir ?=3D ${prefix}/share
> @@ -7,6 +8,7 @@ pkglibdir ?=3D ${datadir}/dracut
>   sysconfdir ?=3D ${prefix}/etc
>   sbindir ?=3D ${prefix}/sbin
>   mandir ?=3D ${prefix}/share/man
> +docdir ?=3D ${prefix}/share/doc/dracut-$(VERSION)
>
>
>   .PHONY: install clean archive rpm testimage test all check AUTHORS
> @@ -28,6 +30,7 @@ install:
>   	mkdir -p $(DESTDIR)$(sysconfdir)
>   	mkdir -p $(DESTDIR)$(pkglibdir)/modules.d
>   	mkdir -p $(DESTDIR)$(mandir)/man{5,8}
> +	mkdir -p $(DESTDIR)$(docdir)
>   	install -m 0755 dracut $(DESTDIR)$(sbindir)/dracut
>   	install -m 0755 dracut-gencmdline $(DESTDIR)$(sbindir)/dracut-genc=
mdline
>   	install -m 0755 dracut-catimages $(DESTDIR)$(sbindir)/dracut-catim=
ages
> @@ -38,12 +41,14 @@ ifeq (1,${WITH_SWITCH_ROOT})
>   endif
>   	install -m 0644 dracut.conf $(DESTDIR)$(sysconfdir)/dracut.conf
>   	mkdir -p $(DESTDIR)$(sysconfdir)/dracut.conf.d
> +	[ -d dracut.conf.d ]&&  for f in dracut.conf.d/*.conf.example; do [=
 -f $$f ]&&  install -m 0644 $$f $(DESTDIR)$(docdir)&&  $(COMPRESS) $(D=
ESTDIR)$(docdir)/$$(basename $$f); done || true
>   	install -m 0755 dracut-functions $(DESTDIR)$(pkglibdir)/dracut-fun=
ctions
>   	cp -arx modules.d $(DESTDIR)$(pkglibdir)
>   	install -m 0644 dracut.8 $(DESTDIR)$(mandir)/man8
>   	install -m 0644 dracut-catimages.8 $(DESTDIR)$(mandir)/man8
>   	install -m 0644 dracut-gencmdline.8 $(DESTDIR)$(mandir)/man8
>   	install -m 0644 dracut.conf.5 $(DESTDIR)$(mandir)/man5
> +	for f in README*; do [ -f $$f ]&&  install -m 0644 $$f $(DESTDIR)$(=
docdir)&&  $(COMPRESS) $(DESTDIR)$(docdir)/$$(basename $$f); done
>   ifeq (1,${WITH_SWITCH_ROOT})
>   	rm $(DESTDIR)$(pkglibdir)/modules.d/99base/switch_root
>   endif
