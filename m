From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] fstab: do not mount and fsck from fstab if using systemd
Date: Tue, 1 Apr 2014 15:06:46 +0800
Message-ID: <20140401070646.GJ2944@dhcp-17-89.nay.redhat.com>
References: <20140401051913.GA644@dhcp-17-89.nay.redhat.com>
 <1396335961.11970.4.camel@Nokia-N900>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396335961.11970.4.camel@Nokia-N900>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 04/01/14 at 11:06am, Alexander Tsoy wrote:
> On Tue Apr=A0  1 09:19:13 2014 WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > If using systemd in initramfs, we could run into a race condition w=
hen
> > dracut and systemd both are trying to mount and run fsck for the sa=
me
> > filesystem, and mount or fsck could be a failure.
> >=20
> > To fix such failure, we should use systemd to mount/fsck from /etc/=
fstab
> > only.
> >=20
> > Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >=A0  modules.d/95fstab-sys/mount-sys.sh | 6 +++++-
> >=A0  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/modules.d/95fstab-sys/mount-sys.sh
> > b/modules.d/95fstab-sys/mount-sys.sh index 12711a0..d65cafd 100755
> > --- a/modules.d/95fstab-sys/mount-sys.sh
> > +++ b/modules.d/95fstab-sys/mount-sys.sh
> > @@ -27,7 +27,11 @@ fstab_mount() {
> >=A0 =A0 =A0 =A0 =A0  return 0
> >=A0  }
> >=A0 =20
> > -[ -f /etc/fstab ] && fstab_mount /etc/fstab
> > +# systemd will mount and run fsck from /etc/fstab and we don't wan=
t to
> > +# run into a race condition.
> > +if [ `readlink -f /init` !=3D '/usr/lib/systemd/systemd' ]; then
>=20
> It's better to test DRACUT_SYSTEMD variable here:
>=20
> if [ -z "$DRACUT_SYSTEMD" ]; then

Right. Will post v2. Thanks.

WANG Chao

>=20
> > +=A0 =A0 =A0  [ -f /etc/fstab ] && fstab_mount /etc/fstab
> > +fi
> >=A0 =20
> >=A0  # prefer $NEWROOT/etc/fstab.sys over local /etc/fstab.sys
> >=A0  if [ -f $NEWROOT/etc/fstab.sys ]; then
> > --=20
> > 1.8.5.3
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe initramfs=
" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at=A0  http://vger.kernel.org/majordomo-info.ht=
ml
>=20
> --=20
> Alexander Tsoy
