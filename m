From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dmraid - possible boot fail due to mdraid rules?
Date: Wed, 21 Jan 2015 14:04:58 +0100
Message-ID: <54BFA3FA.9030304@redhat.com>
References: <20150109135054.66bac1f1@pulsar.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150109135054.66bac1f1-h/dpFJZgkqBSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miroslav Shaltev <shaltev-ng3u6l8Qjkg@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09.01.2015 13:50, Miroslav Shaltev wrote:
> Dear all,
> 
> i have a question regarding the dmraid module.
> 
> On a centos 7 system (but i am afraid the problem is distro independent)
> 
> kernel: 3.10.0-123.13.2.el7.x86_64
> dracut: dracut-033-161.el7.x86_64
> storage: dmraid 1 with lvm on top
> 
> with a root on a dmraid device, some mdraid udev rules get pulled into
> the initramfs.
> 
> The output of dracut -M 
> 
> bash i18n network ifcfg drm plymouth dm dmraid kernel-modules lvm
> resume rootfs-block terminfo udev-rules biosdevname systemd usrmount
> base fs-lib shutdown
> 
> gives no hint about that. However 
> 
> grep -r "64-md-raid.rules"  dracut/modules.d/*
> 
> dracut/modules.d/90dmraid/module-setup.sh: inst_rules 64-md-raid.rules 
> 
> dracut/modules.d/90mdraid/module-setup.sh: inst_rules 64-md-raid.rules
> 
> Due to the mdraid rules, the actual dmraid device cannot be activated,
> as a result the /dev/mapper links are pointing to wrong devices and the
> boot fails.
> 
> Commenting out the line in dracut/modules.d/90dmraid/module-setup.sh
> allows me to create bootable initramfs images.
> 
> Could it be, that the line in dracut/modules.d/90dmraid/module-setup.sh
> was introduced just by a mistake or should i fill a bug report?
> 
> Cheers,
> miroslav
> 

Oh wow.. actually, that dates back to commit b2a843b

$ git show b2a843b4
commit b2a843b471931a8686fffc76cd0afeacabdc5b63
Author: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Fri Mar 6 15:26:24 2009 -0600

    Make 90dmraid load the dm-raid udev rules instead of 95udev-rules


And yes, this is a bug. Please file a bug report!

Thanks for your discovery!

