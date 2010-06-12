From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: One warning message when switching root to /sysroot (which is the 
	mount point for NFS)
Date: Sat, 12 Jun 2010 15:27:24 +0800
Message-ID: <AANLkTik38g1JnWlVZTTCRV2QNlQythULFrtHzu9E1tw5@mail.gmail.com>
References: <AANLkTimBgxVQ4C-dUBPVhG6BHNDQVpD2XFL8NmuhaDZB@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7XX8eJ/lFPOy6MEeO10mzetETE7KpnRCud+N21IWMcw=;
        b=uFQ9uuLZUQkpTd7ul5f2mc7DNAkJbSKZJqUkHRk4JSIUgKM5fKmzJYQKYYxCNbXAoD
         kA+m5JpQwsJs2KxSKmfxcMkSZWs8bVSdfLdJYCorzdq/A7LoJU8vaLHbtdF2Fvc2c7UP
         BtocFAdQc+l6Z6tjF7oE3l3ZL6nx72TALdLTA=
In-Reply-To: <AANLkTimBgxVQ4C-dUBPVhG6BHNDQVpD2XFL8NmuhaDZB-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I have found the reason for "mount: only root can do that (effective
UID is -2)",
The nfs server is NFSv4-powered, NFSv4 has a concept of a root of the
overall exported file system. The export point exported with fsid=3D0 i=
s
used as this root. If we didn't specify "fsid=3D0" in the /etc/exports
file, when it is mounted by the NFS client, all the owner of the
overall exported file system will become "nfsnobody:nfsnobody".
Because of this, the owner of "/bin/mount" is changed to
"nfsnobody:nfsnobody" from "root:root". when "mount" is called, the
warning message is shown.

On Sat, Jun 12, 2010 at 2:47 PM, Min Jun,Xi <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> Hi all,
>
> I am using one NFS directory as the root file system; at first, I use
> yum with "--installroot=3D/tmp/rootimg" option to install all the
> necessary rpm packages into "/tmp/rootimg". Then, I added one simple
> dracut module into the rootimg (which only output some information
> indeed), and I run "chroot /tmp/rootimg dracut xxx" to generate the
> "initrd.gz" file.
>
> I updated my kernel command lines like this:
> ++++++++++++++++++++++++++++++++++
> #netboot rhel6-ppc64-compute
> timeout=3D5
> image=3Dxcat/netboot/rhel6/ppc64/compute/kernel
> =C2=A0 =C2=A0 =C2=A0 =C2=A0label=3Dxcat
> =C2=A0 =C2=A0 =C2=A0 =C2=A0initrd=3Dxcat/netboot/rhel6/ppc64/compute/=
initrd.gz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0append=3D"root=3Dnfs4:192.168.11.107:/tmp/=
rootimg:rw =C2=A0ip=3Ddhcp
> rdshell rdinfo rdinitdebug"
> +++++++++++++++++++++++++++++++++++
>
> The diskless node can be booted, but with some error/warning messages
> during the scripts under /etc/init.d/ are being executed. You can see
> them from the following message.
>
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> + exec switch_root /sysroot /sbin/init
> mount: only root can do that (effective UID is -2)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Welcome to Red=
 Hat Enterprise Linux Server
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Press 'I' to e=
nter interactive startup.
> Starting udev: [ =C2=A0OK =C2=A0]
> Setting hostname ca4dsls02: =C2=A0[ =C2=A0OK =C2=A0]
> Setting up Logical Volume Management: =C2=A0 No volume groups found
> [ =C2=A0OK =C2=A0]
> Checking filesystems
> WARNING: couldn't open /etc/fstab: No such file or directory
> Checking all file systems.
> [ =C2=A0OK =C2=A0]
> mount: only root can do that (effective UID is -2)
> Mounting local filesystems: =C2=A0mount: only root can do that (effec=
tive UID is -2)
> [FAILED]
> chgrp: changing group of `/var/run/utmp': Invalid argument
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chgrp:
> changing group of `/var/log/wtmp': Invalid argument
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 chown: changing ownership
> of `/tmp/.ICE-unix': Invalid argument
> =C2=A0Enabling /etc/fstab swaps: =C2=A0swapon: /etc/fstab: open faile=
d: No such
> file or directory
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[FAILED]
> Entering non-interactive startup
> Retrigger failed udev events[ =C2=A0OK =C2=A0]
> Starting sshd: /var/empty/sshd must be owned by root and not group or
> world-writable.
> [FAILED]
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>
> So, here, I have several questions,
> 1) why does "mount: only root can do that (effective UID is -2)" show
> here? what can I do to make it not show here?
>
> 2) "/etc/fstab" is not there, should I create one before switching
> root to the NFS mountpoint?
>
> 3) "chgrp" and "chown" fails here, should I prepare the directories
> myself before switching root?
>
> Thank you!
>



--=20
best regards,
Xi Minjun
xCAT Development Team Member in CDL,IBM
Notes ID: Min Jun Xi/China/IBM/
