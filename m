From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: Re: [PATCH v2 1/2]: dracut: 95resume: avoid possible symbolic link
 creation error on bootup
Date: Fri, 15 Apr 2016 10:55:22 +0200
Message-ID: <1460710522.3382.5.camel@trentalancia.net>
References: <1460387473.2670.20.camel@trentalancia.net>
	 <1460390439.2670.24.camel@trentalancia.net> <5710A8B2.60704@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5710A8B2.60704-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2016-04-15 at 10:39 +0200, Harald Hoyer wrote:
> On 11.04.2016 18:00, Guido Trentalancia wrote:
> > Avoid symbolic link creation error (should apply to latest dracut
> > version).
> >=20
> > Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
> > ---
> > =C2=A0modules.d/95resume/parse-resume.sh |=C2=A0=C2=A0=C2=A0=C2=A02=
 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > --- dracut-044/modules.d/95resume/parse-resume.sh	2015-11-25=20
> > 14:22:28.000000000 +0100
> > +++ dracut-044-95resume-force-symlink/modules.d/95resume/parse-
> > resume.sh	2016-04-11 17:53:20.664983390 +0200
> > @@ -67,7 +67,7 @@ if ! getarg noresume; then
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0printf -- '%s\n' ' RUN+=3D"/sbin/initqueue --finished --
> > unique --name 00resume echo %M:%m=C2=A0=C2=A0> /sys/power/resume"'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} >> /etc/ude=
v/rules.d/99-resume.rules
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" =
] && { ln -s "%s" /dev/resume 2>
> > /dev/null; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '[ -e "%s" =
] && { ln -sf "%s" /dev/resume 2>
> > /dev/null; rm -f -- "$job" "%s/initqueue/timeout/resume.sh"; }\n' \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0"$resume" "$resume" "$hookdir" >>
> > $hookdir/initqueue/settled/resume.sh
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{

>=20
> patching file modules.d/95resume/parse-resume.sh
> patch: **** malformed patch at line 8:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf -- '%s\n'
> ' RUN+=3D"/sbin/initqueue --finished --unique --name 00resume
> echo %M:%m=C2=A0=C2=A0> /sys/power/resume"'

Very strange. I have checked again (version 2 of the patch, not version
1) and it applies cleanly to version 044 and git.

> anyway.. applied by hand and pushed.

Excellent. Thanks.

Regards,

Guido
