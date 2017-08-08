From: Uwe Sauter <uwe.sauter.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: read-only OverlayFS (for NFS root)
Date: Tue, 8 Aug 2017 15:19:12 +0200
Message-ID: <ebabb7d0-f02c-edb9-c9b5-9ce7c555a764@gmail.com>
Reply-To: uwe.sauter.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Wje+cEFP7XqYDVgW2qh01cTojmWWXFPvgp+ZVmBgLNs=;
        b=HTVVKdLf1lrnFdWkzdrco1vuH/ot86Rv8rE+Lj7roNN5VEfMizrQnn2kJt1ErxIcBD
         4gEIquLfFjeymgLrX//v1dRYS5Vxb69qBe2o7xwfF44HyhsHNuiIWw1oMeIQUiZO5klg
         7cHZSxVfmhSYPupy1wxM1MuuS1uxlljg7PEE3ArZWbvCvEw6beX6UJ7JMbztdCVMN+AU
         ot5Vm5RdkpydHgQXXfEBz8RUvbn8aFcKOPRM7SOC05v3hsWoV4etdJWAxW/HctlYrFkz
         PLUUFM6g369zN/5qdyYd9i8NfWAkQDxWD7IZF70UHf7FiFWIWImOeU+9sFfHrhSYUzXb
         2LRg==
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

TL;DR
Is it possible to use OverlayFS [1] to merge a clean / unconfigured NFS root share and a second NFS
share that holds all configuration into /sysroot?



I'd like to get your opinion for a new Dracut module. To allow different hosts to use the
same read-only NFS share as / but also have host/host-type specific configuration I was
thinking about using OverlayFS [1] in initramfs to merge the unconfigured share with the config
share.

Due to compatibility with the Dracut NFS syntax I was thinking of using "+" (plus) as a new
delimiter for cmdline configuration, e.g.

root=OVERLAY=nfs4:nfsserver:/nfs/config/compute,async+nfs4:nfsserver:/nfs/rootshare,async

In this case nfs4:nfsserver:/nfs/rootshare would contain a filesystem tree created by syncing
a running CentOS using

rsync --archive --delete --delete-excluded --hard-links --one-file-system --exclude '/tmp/*' --exclude '/var/tmp/*' --exclude
'/var/lib/yum/yumdb/*' / nfsserver:/nfs/rootshare

and nfsserver:/nfs/config/compute would contain a partial filesystem tree which only hold
the required configuration files for the host-type "compute", e.g. etc/fstab.

For details see [2] and [3].


I'm still in the planing phase and some things are not yet clear to me:

* Do you think this is a practical way to go?
* How to reuse as much of work already done in other Dracut modules as possible?
  (It might be beneficial to also support other root=XXX parameters.)
* How to find the correct point in the boot process to merge all lower filesystems into
  the new /sysroot? This should be done before other filesystems are mounted on top of
  /sysroot (like rpc_pipefs, which currently is mounted twice in the boot process when
  booting from NFS).
* How to wait in hook scripts until resources become available? Or how to tell Dracut that
  a hook script should be executed only after availability of a resource?
* What environment is passed to the hook scripts? What variables should be returned or exported?


Background:
I'm working for a university institute that has a Linux cluster with several hundred compute nodes
on different hardware types (with/without graphics card, with/without local disks, etc.).
We're currently working on the migration from Scientific Linux 6.x to CentOS 7.x and as part of
that we are looking into different possible ways to provide the configuration options to those nodes.

One condition is that all nodes boot from a read-only NFS share (several NFS servers for the cluster).

The current solution is a bit hackish. It uses CFengine to distribute the whole configuration
to the NFS servers and some custom scripts included in initrd, in /etc/rc.d and /etc/rc.local
configure the nodes while booting (depending on custom parameters in kernel cmdline).

With the transition to CentOS 7 I was thinking of using OverlayFS to merge a "clean" base
NFS root share together with a separate NFS config share that is specific to the host type
or even to a specific host.

The difficulty in this approach is the correct order of mounting the lower filesystems,
the (read-only) OverlayFS to /sysroot and mounting additional required filesystems (e.g. rpc_pipefs).


I'd like to get input on this topic as well as other ideas on how to provide host specific configuration
to hosts that have no persistent storage.


Best regards,

    Uwe Sauter


[1] https://www.kernel.org/doc/Documentation/filesystems/overlayfs.txt
[2]
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html-single/Storage_Administration_Guide/index.html#diskless-nfs-config
[3] https://access.redhat.com/solutions/2196881
