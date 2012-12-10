From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: =?UTF-8?q?=5BRFC=5D=20iscsid=20/=20systemd=20/=20dracut=20integration=20effort?=
Date: Mon, 10 Dec 2012 14:08:32 -0800
Message-ID: <1355177316-25803-1-git-send-email-cleech@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Sorry about the cross-posting, but I think that in order to get this ri=
ght I'm
going to need as much feedback as I can get.

I think I've got this working pretty well now (at least for my iBFT con=
figured
iSCSI root test case), although the dracut module still needs work.  Th=
is is
based on the iscsid socket activation patch from Tomasz Torcz and the u=
nit
files from Tomasz and J=C3=B3hann B. Gu=C3=B0mundsson.

Attempting to start iscsid using systemd unit files (socket activated o=
r not)
was impacting my iscsi-root test setup.  Rather than try to preserve th=
e old
logic that used the _netdev mount flag to determine when iscsid could b=
e safely
shutdown, I've been working on following the guidelines for root storag=
e
daemons http://www.freedesktop.org/wiki/Software/systemd/RootStorageDae=
mons.

1) I patched iscsid to set argv[0][0] =3D '@' if a new --initrd flag is=
 passed on
   the command line.  It's simple, it works, we don't kill iscsid befor=
e the
   root filesystem is unmounted.

2) When starting iscsid from the initrd, I then ran into issues of iscs=
id not
   functioning properly after the switch_root.  It's not mentioned in t=
he
   RootStorageDaemons documentation, but if a process left running from=
 the
   initrd needs further filesystem access at runtime it will need to be=
 able to
   chroot itself before the switch_root.  I patched iscsid and iscsiadm=
 with a
   newroot command (using plymouth as an example), and used a dracut cl=
enaup
   hook to call "iscsiadm --newroot /sysroot".

3) Related to #2, launching iscsid as a Type=3Dsimple service from the =
initrd
   (I'm testing this with Fedora 18 beta, where dracut uses systemd in =
the
   initrd) results in STDOUT/STDERR access after the switch_root failin=
g with
   EPIPE.  It seems that the connection to the journal process is dead =
once the
   initrd instantiated systemd-journald is replaced with the runtime pr=
ocess.

   I can at least keep iscsid functioning if I run it as Type=3Dforking=
, but I'm
   not sure if I'm losing runtime logging or not.  I may be able to do
   something with the StandardOutput and StandardError options in the s=
ervice
   file.

4) None of this helps if the sessions are shutdown when we still need t=
hem.
   Rather than the all-or-nothing _netdev mount option checks that have=
 been
   used in the past, I'm attempting to use the fact that iscsiadm will =
skip
   over session that match a node with startup=3Donboot set when doing =
a
   logoutall.  The iscsi_mark_root_nodes script is borrowed from the SU=
SE init
   scripts in the open-iscsi repos written by Hannes Reinecke.  I've ma=
de minor
   changes to export the list of sessions activated in the initramfs, a=
nd then
   mark those as onboot when starting iscsi.service.

Things that still need looking into.

1) Command line configured iSCSI parameters.  If iscsistart is to be fu=
lly
   removed something needs to setup the node from the command line.  Or
   iscsistart needs to be able to run alongside iscsid.

2) Proper ordering of the iscsi.service for non-root filesystems.

Any and all feedback and/or help welcome.

- Chris
