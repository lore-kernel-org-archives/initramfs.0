From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: kdump in dracut
Date: Mon, 17 Feb 2014 16:10:41 +0100
Message-ID: <1644005.SfM4K48qYX@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Julian Wolf <juwolf-l3A5Bk7waGM@public.gmane.org>

Hi,

it looks like Redhat has made up their own kdump dracut module
in the kexec-tools Fedora package:
http://pkgs.fedoraproject.org/cgit/kexec-tools.git/tree/

dracut-kdump.sh
dracut-module-setup.sh
dracut-monitor-dd-progress.sh

I wonder whether there are any plans to get those into the
dracut mainline git repository.
Otherwise we (SUSE) and others will have to come up with our
own implementations and we are where we do not want to end up:
Different initrd implementations, setups, configurations across
Linux distributions.

Thanks,

     Thomas
