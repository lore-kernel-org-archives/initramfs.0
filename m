From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: rd.break=cmdline broken
Date: Fri, 12 Jul 2013 08:44:27 +0200
Message-ID: <51DFA5CB.10200@redhat.com>
References: <20130712043749.GA4867@dhcp16-109.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130712043749.GA4867-ALckc1lQpMDv8MId6FTy5BcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 07/12/2013 06:37 AM, WANG Chao wrote:
> Hi, Harald
> 
> I find that rd.break=cmdline will cause a dead lock of service
> dependencies.
> 
> dracut-cmdline.service:
> [..]
> Before=systemd-vconsole-setup.service
> 
> dracut-emergency.service:
> [..]
> After=systemd-vconsole-setup.service
> Wants=systemd-vconsole-setup.service
> 
> So it appears to be a dead lock between systemd-vconsole-setup.service
> and dracut-cmdline.service if we issue dracut-emergency.service with
> rd.break=cmdline.
> 
> Because vconsole.conf is generated under cmdline hook, so simply remove
> 'Before=systemd-vconsole-setup.service' wouldn't be a decent solution.
> 
> Wondering if you have any idea how to fix it.
> 
> Thanks,
> WANG Chao
> 

We/I should either make the vconsole.conf cmdline parsing script a generator and
be moved out of the cmdline hook; or more likely remove the deprecated,
following kernel command line parameters, when using systemd:

- KEYTABLE
- SYSFONT
- CONTRANS
- UNIMAP
- KEYMAP
- FONT
- FONT_MAP
- FONT_UNIMAP
- UNICODE
- EXT_KEYMAP
- LANG
- LC_ALL

and only accept vconsole.* and locale.* parameters, which are handled by systemd
out of the box.
