From: Mike Christie <michaelc-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>
Subject: Re: [RFC] iscsid / systemd / dracut integration effort
Date: Fri, 14 Dec 2012 13:01:18 -0600
Message-ID: <50CB777E.20402@cs.wisc.edu>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1355177316-25803-1-git-send-email-cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 12/10/2012 04:08 PM, Chris Leech wrote:
> Sorry about the cross-posting, but I think that in order to get this =
right I'm
> going to need as much feedback as I can get.
>=20
> I think I've got this working pretty well now (at least for my iBFT c=
onfigured
> iSCSI root test case), although the dracut module still needs work.  =
This is
> based on the iscsid socket activation patch from Tomasz Torcz and the=
 unit
> files from Tomasz and J=F3hann B. Gu=F0mundsson.
>=20
> Attempting to start iscsid using systemd unit files (socket activated=
 or not)
> was impacting my iscsi-root test setup.  Rather than try to preserve =
the old
> logic that used the _netdev mount flag to determine when iscsid could=
 be safely
> shutdown, I've been working on following the guidelines for root stor=
age
> daemons http://www.freedesktop.org/wiki/Software/systemd/RootStorageD=
aemons.
>=20
> 1) I patched iscsid to set argv[0][0] =3D '@' if a new --initrd flag =
is passed on
>    the command line.  It's simple, it works, we don't kill iscsid bef=
ore the
>    root filesystem is unmounted.
>=20
> 2) When starting iscsid from the initrd, I then ran into issues of is=
csid not
>    functioning properly after the switch_root.  It's not mentioned in=
 the
>    RootStorageDaemons documentation, but if a process left running fr=
om the
>    initrd needs further filesystem access at runtime it will need to =
be able to
>    chroot itself before the switch_root.  I patched iscsid and iscsia=
dm with a
>    newroot command (using plymouth as an example), and used a dracut =
clenaup
>    hook to call "iscsiadm --newroot /sysroot".
>=20
> 3) Related to #2, launching iscsid as a Type=3Dsimple service from th=
e initrd
>    (I'm testing this with Fedora 18 beta, where dracut uses systemd i=
n the
>    initrd) results in STDOUT/STDERR access after the switch_root fail=
ing with
>    EPIPE.  It seems that the connection to the journal process is dea=
d once the
>    initrd instantiated systemd-journald is replaced with the runtime =
process.
>=20
>    I can at least keep iscsid functioning if I run it as Type=3Dforki=
ng, but I'm
>    not sure if I'm losing runtime logging or not.  I may be able to d=
o
>    something with the StandardOutput and StandardError options in the=
 service
>    file.
>=20
> 4) None of this helps if the sessions are shutdown when we still need=
 them.
>    Rather than the all-or-nothing _netdev mount option checks that ha=
ve been
>    used in the past, I'm attempting to use the fact that iscsiadm wil=
l skip
>    over session that match a node with startup=3Donboot set when doin=
g a
>    logoutall.  The iscsi_mark_root_nodes script is borrowed from the =
SUSE init
>    scripts in the open-iscsi repos written by Hannes Reinecke.  I've =
made minor
>    changes to export the list of sessions activated in the initramfs,=
 and then
>    mark those as onboot when starting iscsi.service.
>=20
> Things that still need looking into.
>=20
> 1) Command line configured iSCSI parameters.  If iscsistart is to be =
fully
>    removed something needs to setup the node from the command line.  =
Or
>    iscsistart needs to be able to run alongside iscsid.
>=20

The iscsi tools changes look ok to me. For 1), in this type of setup we
are always only doing

iscsiadm -m fw -l

(saw that in the iscsiroot.sh part of patch).

If so, then just modify to take params. I think you could just take
parse_param/apply_params from iscsistart and use them.

