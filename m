From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Failed to use read-only NFS as the root filesystem
Date: Mon, 5 Jul 2010 00:48:12 +0800
Message-ID: <AANLkTimW2-WTf1oqheGOQgfIHcUVpFOEakpnAO8aiQGf@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=zf2eGmAE/U0E7idZvDMk84VuVfchF9w7XC+vgTOJqSc=;
        b=fcpoaeR2iNgfwSaqpybBy3K7QODQo+3SMC1ePOWAuM4s4sINwLRTV1qLm7Ewpfxw3D
         Bx8K3cP9r0XLr7uh60n1/buqMLTVCk7bcaywZaMX+R816Chy0xyTMH3tWvcDtbHh6+pA
         svyXRt2DWSC8b8d+h5pw8aZTcqPAJdpoLbA9o=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Hi All,
there's one problem here.
I tried to set one read-only NFS directory as the root filesystem, but
there're several problems, and lead to one situation that the root
filesystem is remounted using read-write option.
The kernel parameter is here:
+++++++++++
append=3D"root=3Dnfs:192.168.11.107:/install/netboot/rhel6/ppc64/comput=
e/rootimg:ro
STATEMNT=3D XCAT=3D192.168.11.107:3001=C2=A0ip=3Ddhcp"
+++++++++++
#please ignore STATEMNT and XCAT, which are the OPTIONS created by myse=
lf.
Before "switch_root" command is running, we can see the root
filesystem is mounted read-only, you can find it here:
++++++++++++
192.168.11.107:/install/netboot/rhel6/ppc64/compute/rootimg on
/sysroot type nfs (ro,nolock,nfsvers=3D3,addr=3D192.168.11.107)
++++++++++++
However, after "switch_root" is running, all have been changed like thi=
s:
+++++++++++++++++++++++++++++++++++++++++
dracut: Switching root
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Welcome to=
 Red Hat Enterprise Linux Server
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Press 'I' =
to enter interactive startup.
Starting udev: [ =C2=A0OK =C2=A0]
Setting hostname ca4dsls02: =C2=A0[ =C2=A0OK =C2=A0]
Setting up Logical Volume Management: =C2=A0 No volume groups found
[ =C2=A0OK =C2=A0]
Checking filesystems
Checking all file systems.
[ =C2=A0OK =C2=A0]
Remounting root filesystem in read-write mode: =C2=A0[ =C2=A0OK =C2=A0]
Mounting local filesystems: =C2=A0[ =C2=A0OK =C2=A0]
++++++++++++++++++++++++++++++++++++++++++
Can you find it? =C2=A0"Remounting root filesystem in read-write mode: =
=C2=A0[ =C2=A0OK =C2=A0]"
=46inally, I found something related with it.
In "/etc/init.d/rc.sysinit", the code looks like this:
+++++
639 =C2=A0Remount the root filesystem read-write.
640 update_boot_stage RCmountfs
641 if remount_needed ; then
642 =C2=A0 action $"Remounting root filesystem in read-write mode: " mo=
unt
-n -o rem =C2=A0 =C2=A0ount,rw /
643 fi
+++++
It seems the "update_boot_state" function tells us we need to remount
the NFS directory, then it remounts the root filesystem with
read-write option.
Is there any option or flag which can be used to disable it? I think
the developers from redhat should know about it.
Thank you!
