From: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>
Subject: Re: [PATCH] include biosdevname calls in dracut
Date: Fri, 31 Dec 2010 08:57:40 -0600
Message-ID: <20101231145740.GB29376@auslistsprd01.us.dell.com>
References: <20101206005229.GA687@auslistsprd01.us.dell.com> <20101214195807.GB31714@auslistsprd01.us.dell.com> <1292947718-sup-548@ittemni>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1292947718-sup-548@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amadeusz ??o??nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Dec 21, 2010 at 05:16:17PM +0100, Amadeusz ??o??nowski wrote:
> Excerpts from Matt Domsch's message of Tue Dec 14 20:58:07 +0100 2010:
> > On Sun, Dec 05, 2010 at 06:52:29PM -0600, Matt Domsch wrote:
> > > For your consideration.  This allows biosdevname to be called from
> > > network-using functions in dracut.  biosdevname is included in
> > > Fedora 15, and there are tickets open to include it in other
> > > distros.
> > 
> > Any thoughts on this patch?
> 
> I think that better would be to include your patch with first its usage.
> Having additional dependencies without a real use brings mess.  But it's
> just my opinion and I'm not in charge. :-)

The use case is simple - any network-using functions that are started
using dracut (NFS root, iSCSI root, FCoE root) will then use the
biosdevname names for devices, rather than the non-deterministic
kernel names ethX.

The three instances where <interface> can be passed are:

ip=<interface>:{dhcp|on|any|dhcp6|auto6}
bootdev=<interface>
netroot=fcoe:<interface|MAC>:<dcb|nodcb>

plus the forceable rewrite rule:
ifname=<interface>:<MAC>
which only works when you already know the MAC address of the target device.

The biosdevname method behaves similarly to the ifname= method, except
you get device names from BIOS, without needing to know the MAC
address of the target device(s).  

With this patch, you no longer need to use bootdev=eth0  and later
have udev rename eth0 to be em1, which leads to different devices names
for configuration at different times (dracut and post-dracut).  Both
dracut and post-dracut use the same device names.

Thanks,
Matt

-- 
Matt Domsch
Technology Strategist
Dell | Office of the CTO
