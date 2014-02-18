From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add default values in fstab_lines
Date: Tue, 18 Feb 2014 08:29:13 -0500
Message-ID: <20140218132912.GB12633@redhat.com>
References: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com>
 <20140217155512.GG11670@redhat.com>
 <20140218051946.GB3123@dhcp-16-198.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218051946.GB3123-je1gSBvt1Tc/CGXRbJeUwh/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Feb 18, 2014 at 01:19:46PM +0800, Dave Young wrote:
> On 02/17/14 at 10:55am, Vivek Goyal wrote:
> > On Fri, Feb 14, 2014 at 04:49:21PM +0800, Dave Young wrote:
> > > It's useful for passing a full fstab line including like fs_passn=
o so fsck
> > > can take effect.
> > >=20
> > > Previously it's assumed that there's no fs_freq and fs_passno in =
fstab lines
> > > so original code just append "0 0" at the end of each fstab lines=
=2E
> > >=20
> > > Improve this issue by assign default value in case they are not p=
assed in.
> > > Three field are handled here:
> > > fs_mntops: default to "defaults"
> > > fs_freq: default to "0"
> > > fs_passno: default to "0"=20
> > >=20
> > > Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  dracut.8.asc |    8 ++++++--
> > >  dracut.sh    |    6 +++++-
> > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > >=20
> > > --- dracut.orig/dracut.sh
> > > +++ dracut/dracut.sh
> > > @@ -1222,7 +1222,11 @@ if [[ $kernel_only !=3D yes ]]; then
> > >      [[ $kernel_cmdline ]] && printf "%s\n" "$kernel_cmdline" >> =
"${initdir}/etc/cmdline.d/01-default.conf"
> > > =20
> > >      while pop fstab_lines line; do
> > > -        printf "%s\n" "$line 0 0" >> "${initdir}/etc/fstab"
> > > +        line=3D($line)
> > > +        [ -z "${line[3]}" ] && line[3]=3D"defaults"
> > > +        [ -z "${line[4]}" ] && line[4]=3D"0"
> > > +        [ -z "${line[5]}" ] && line[5]=3D"0"
> > > +        echo "${line[@]}" >> "${initdir}/etc/fstab"
> > >      done
> > > =20
> > >      for f in $add_fstab; do
> > > --- dracut.orig/dracut.8.asc
> > > +++ dracut/dracut.8.asc
> > > @@ -311,9 +311,13 @@ provide a valid _/etc/fstab_.
> > >  **--add-fstab** _<filename>_::
> > >      Add entries of _<filename>_ to the initramfs /etc/fstab.
> > > =20
> > > -**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<f=
ilesystem options>_"::
> > > +**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<f=
ilesystem options>_ _<dump options>_ _<fsck order>_"::
> > >      Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ =
and _<filesystem
> > > -    options>_ in the initramfs
> > > +    options>_ in the initramfs. _<dump options>_ and _<fsck orde=
r>_ can also be
> >=20
> > How do you differentiate between filesystem options and dump option=
?  IOW,
> > what is used as separator so that dracut and find out what is a a
> > filesystem option and what is a dump option or pass number option?
>=20
> It should be same as fstab format, use space or tab to seperate them.

Ok, so filesystem options have to be comma separated. This was not clea=
r
from man page to me. I checked it on my system and we are passing
comma separated filesystem options.

dracut --hostonly -o 'plymouth dash' --mount '/dev/disk/by-uuid/87faf93=
0-fd28-49e0-8b0f-d775141e7f59 /mnt/wd-ssd1 ext4 rw,relatime,seclabel,da=
ta=3Dordered,nofail' -f /boot/initramfs-3.14.0-rc1+kdump.img 3.14.0-rc1=
+

If that's the case, then this approach should work.

Thanks
Vivek
