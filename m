From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 11/33] 95iscsi: Autodetect iSCSI firmware
Date: Wed, 10 Dec 2014 17:29:45 +0100
Message-ID: <1495590.WiuBmiIXgM@skinner>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <546EE10A.5010606@suse.de> <20141121073255.GE2591@dhcp-17-37.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121073255.GE2591-2coKmSd1Zb7VyFQaPrqbSRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Wieczorkiewicz <pwieczorkiewicz-IBi9RG/b67k@public.gmane.org>

On Friday, November 21, 2014 03:32:55 PM WANG Chao wrote:
> On 11/21/14 at 07:51am, Hannes Reinecke wrote:
> > On 11/21/2014 06:43 AM, WANG Chao wrote:
> > > Hi,
> > > 
> > > On 11/20/14 at 03:56pm, Thomas Renninger wrote:
> > >> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> > >> 
> > >> Some iSCSI initiator present firmware information in
> > >> /sys/firmware/ibft or /sys/firmware/iscsi_bootX
> > >> 
> > >> Whenever we detect one of those directories we should assume
> > >> that the iSCSI devices should be activated.
> > >> 
> > >> Also incorporates SUSE patches:
> > >> 0049:
> > >> 95iscsi: Use 'ip=ibft' for ibft autoconfiguration
> > >> 
> > >> For iBFT autoconfiguration we should be setting 'ip=ibft'
> > >> instead of rd.neednet. This should instruct dracut to only
> > >> enable the iBFT interfaces and leave the rest alone.
> > > 
> > > I think,
> > > 
> > > /sys/firmware/ibft is created for iBFT if detected.
> > > /sys/firmware/iscsi_bootX is created for hardware iSCSI if detected.
> > 
> > Nope.
> > 
> > ibft is created whenever an iBFT section (either in system ROM
> > or via EFI) is detected.
> > iscsi_boot is created for be2iscsi devices, which use an iBFT-like
> > interface.
> > 
> > Both provide the same attributes.
> 
> Yes, they have same attributes.

The same sysfs attributes?

> But IIRC iBFT is provided by ACPI or EFI and the other is provided by
> HBA's firmware. Right?

But this should not matter.
If the kernel differs both APIs and provides a unified sysfs interface,
not differing in userspace again would be the right thing to do.

     Thomas

PS: I continue to collect missing patches tomorrow and do a big resend...
