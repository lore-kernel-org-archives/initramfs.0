From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RESEND] SUSE patches which should show up mainline
Date: Wed, 17 Dec 2014 11:26:04 +0100
Message-ID: <54915A3C.9050409@redhat.com>
References: <1418309193-11208-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418309193-11208-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11.12.2014 15:45, Thomas Renninger wrote:
> Hi,
> 
> Changes to last post:
> - Removed unnecessary IFS variable restoring
> - Removed inst_multiple sed and host from nfs module
> - Removed warpclock patch/module (according Chao Wang this is done by systemd
>   by copying /etc/{localtime,adjtime} to initramfs)
> 
> One cleanup for the future I have in mind:
> As udev rules are often moved around in timeline (just the number changes),
> it would be nice if systemd enforces that udev rules must be unique.
> That would mean this is forbidden:
> 01-ruleXXX
> 05-ruleXXX
> Then dracut could implement:
> inst_rule ruleXXX
> and it would work for all distros and versions.
> But this needs clarification with systemd people first.
> 
> Would be great to see as many of these applied already.
> E.g. mkinitrd-suse: Update to sles12 SUSE state
> should not be a big deal to apply.
> 
> Thanks a lot,
> 
>        Thomas
> 


Reviewed the patches, added one patch for module handling.
Test suite passed!

Pushed! Many thanks!
