From: Vinay Venkataraghavan <raghavanvinay-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Building new initrd with dracut-network packages for iscsi boot.
Date: Wed, 1 Aug 2012 09:05:15 -0700 (PDT)
Message-ID: <1343837115.80604.YahooMailNeo@web121006.mail.ne1.yahoo.com>
Reply-To: Vinay Venkataraghavan <raghavanvinay-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1343837115; bh=LhTNVfodXhedlLWNz34BnpjSpx6TwgF0KOINIY04wjU=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KLvC0lZv35smKnBUK8lVDFr3VlqNB0npTnm6gXahsZzQAKhLkKPAnJOojgbg/WbgYZb5MmGT5UPIt1Z0+uZvbmhtr03bWVgsOmHn7NOlm/TMMuCpdYMtQ9QTdpAxldPcnLHulYz/u3n4k0ugHXmb+nOD9gX4/nb3DXhJ4XksT5w=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Vinay Venkataraghavan <raghavanvinay-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>

Hi all,

I have a few questions regarding building a new initrd which adds addit=
ional modules to the existing initrd.

The environment that I am working in is as follows:

1. that anaconda has completed the install and I prevent the system fro=
m rebooting.=20

2. Anaconda has installed the OS to an iscsi disk.=20


What I'd like to do now is to add the dracut-network and iscsi modules =
to the initrd so that when the system reboots it will be able to connec=
t to the remote iscsi target and mount the root device.

I have been working through this for about three weeks now and am stuck=
 at the phase where I can rebuild the initrd with the network modules a=
nd iscsi modules.=20


The installed system contains all the dependency rpms such as: dracut, =
dracut-kernel, dracut-network, and iscsi-initiator-utils.=A0

While in the anaconda shell I tried the following command:

dracut -v -a iscsi -m network new_initrd.img `uname -r`

Executing this command has two problems:

1. The network option is invalid. I'm wondering if this should be -m dr=
acut-network??

2. This does not add modules to the existing image. But it creates a ve=
ry minimal initrd.=20


What I would like is to add the network boot modules to boot from an is=
csi root device to the existing initrd.=20


I would appreciate any help in this matter. Please let me know if I can=
 furnish any further information.

Thanks in advance.
- Vinay
