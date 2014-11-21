From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 11/33] 95iscsi: Autodetect iSCSI firmware
Date: Fri, 21 Nov 2014 15:32:55 +0800
Message-ID: <20141121073255.GE2591@dhcp-17-37.nay.redhat.com>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
 <1416495428-36978-12-git-send-email-trenn@suse.de>
 <20141121054311.GD2591@dhcp-17-37.nay.redhat.com>
 <546EE10A.5010606@suse.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546EE10A.5010606-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Wieczorkiewicz <pwieczorkiewicz-IBi9RG/b67k@public.gmane.org>

On 11/21/14 at 07:51am, Hannes Reinecke wrote:
> On 11/21/2014 06:43 AM, WANG Chao wrote:
> > Hi,
> > 
> > On 11/20/14 at 03:56pm, Thomas Renninger wrote:
> >> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
> >>
> >> Some iSCSI initiator present firmware information in
> >> /sys/firmware/ibft or /sys/firmware/iscsi_bootX
> >>
> >> Whenever we detect one of those directories we should assume
> >> that the iSCSI devices should be activated.
> >>
> >> Also incorporates SUSE patches:
> >> 0049:
> >> 95iscsi: Use 'ip=ibft' for ibft autoconfiguration
> >>
> >> For iBFT autoconfiguration we should be setting 'ip=ibft'
> >> instead of rd.neednet. This should instruct dracut to only
> >> enable the iBFT interfaces and leave the rest alone.
> > 
> > I think,
> > 
> > /sys/firmware/ibft is created for iBFT if detected.
> > /sys/firmware/iscsi_bootX is created for hardware iSCSI if detected.
> > 
> Nope.
> 
> ibft is created whenever an iBFT section (either in system ROM
> or via EFI) is detected.
> iscsi_boot is created for be2iscsi devices, which use an iBFT-like
> interface.
> 
> Both provide the same attributes.

Yes, they have same attributes.

But IIRC iBFT is provided by ACPI or EFI and the other is provided by
HBA's firmware. Right?

Thanks
WANG Chao
