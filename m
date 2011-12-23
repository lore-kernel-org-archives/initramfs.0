From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/4 branch usrmove] add ssh client module
Date: Fri, 23 Dec 2011 16:04:16 +0800
Message-ID: <20111223080416.GA12662@darkstar.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soltys-R61QfzASbfY@public.gmane.org

Hi,

This is a ssh-client module for dracut. The first user could be kdump
because kdump need to scp vmcore to remote machine.

But It will benifit if it become an general module. Sometimes user need
an initrd which simply act as an emregency minimal ramdisk for test or
recovery use.

Currently it support both sshkey mode and interactive mode. With sshkey
mode user can precopy the key to remote machine and install sshkey to initrd.
With interactive mode user can drop into an emergency shell and ssh into
remote machine interactively.

For the interactive mode, due to there's no control tty for emergency shell,
so I add this feature based on Michal Soltys's "shell job control" patches, 

I rebased his patch to usrmove branch of Harald, post along with ssh patches

--
Thanks dave
