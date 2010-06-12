From: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: One warning message when switching root to /sysroot (which is the 
	mount point for NFS)
Date: Sat, 12 Jun 2010 14:47:47 +0800
Message-ID: <AANLkTimBgxVQ4C-dUBPVhG6BHNDQVpD2XFL8NmuhaDZB@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ErWV/LeVGsB6++tjgR8Ig3rgMDQtmZn1t8MhZCk1Bms=;
        b=PsqXxqiMbqeemPM6dJBh2S5xPtn/3VKirL9K+WzalrY0OQ1rP7dpMVSV156OCWPifS
         vruNQKy42az7BYBbze8LFB1VUdPO6DnP/1AOY0p+zkuFHSS0ZhFDtYHba4jaPqaA5QHi
         zbH/4Z40P3YMDRNXyfy6zVh/roH2MZI1wvyb8=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

I am using one NFS directory as the root file system; at first, I use
yum with "--installroot=/tmp/rootimg" option to install all the
necessary rpm packages into "/tmp/rootimg". Then, I added one simple
dracut module into the rootimg (which only output some information
indeed), and I run "chroot /tmp/rootimg dracut xxx" to generate the
"initrd.gz" file.

I updated my kernel command lines like this:
++++++++++++++++++++++++++++++++++
#netboot rhel6-ppc64-compute
timeout=5
image=xcat/netboot/rhel6/ppc64/compute/kernel
        label=xcat
        initrd=xcat/netboot/rhel6/ppc64/compute/initrd.gz
        append="root=nfs4:192.168.11.107:/tmp/rootimg:rw  ip=dhcp
rdshell rdinfo rdinitdebug"
+++++++++++++++++++++++++++++++++++

The diskless node can be booted, but with some error/warning messages
during the scripts under /etc/init.d/ are being executed. You can see
them from the following message.

++++++++++++++++++++++++++++++++++++++++++++++++++
+ exec switch_root /sysroot /sbin/init
mount: only root can do that (effective UID is -2)
                Welcome to Red Hat Enterprise Linux Server
                Press 'I' to enter interactive startup.
Starting udev: [  OK  ]
Setting hostname ca4dsls02:  [  OK  ]
Setting up Logical Volume Management:   No volume groups found
[  OK  ]
Checking filesystems
WARNING: couldn't open /etc/fstab: No such file or directory
Checking all file systems.
[  OK  ]
mount: only root can do that (effective UID is -2)
Mounting local filesystems:  mount: only root can do that (effective UID is -2)
[FAILED]
chgrp: changing group of `/var/run/utmp': Invalid argument
                                                          chgrp:
changing group of `/var/log/wtmp': Invalid argument

                                             chown: changing ownership
of `/tmp/.ICE-unix': Invalid argument
 Enabling /etc/fstab swaps:  swapon: /etc/fstab: open failed: No such
file or directory

                [FAILED]
Entering non-interactive startup
Retrigger failed udev events[  OK  ]
Starting sshd: /var/empty/sshd must be owned by root and not group or
world-writable.
[FAILED]
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

So, here, I have several questions,
1) why does "mount: only root can do that (effective UID is -2)" show
here? what can I do to make it not show here?

2) "/etc/fstab" is not there, should I create one before switching
root to the NFS mountpoint?

3) "chgrp" and "chown" fails here, should I prepare the directories
myself before switching root?

Thank you!
