From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 11/33] 95iscsi: Autodetect iSCSI firmware
Date: Fri, 21 Nov 2014 07:51:54 +0100
Message-ID: <546EE10A.5010606@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de> <1416495428-36978-12-git-send-email-trenn@suse.de> <20141121054311.GD2591@dhcp-17-37.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141121054311.GD2591-2coKmSd1Zb7VyFQaPrqbSRcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Wieczorkiewicz <pwieczorkiewicz-IBi9RG/b67k@public.gmane.org>

On 11/21/2014 06:43 AM, WANG Chao wrote:
> Hi,
>=20
> On 11/20/14 at 03:56pm, Thomas Renninger wrote:
>> From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
>>
>> Some iSCSI initiator present firmware information in
>> /sys/firmware/ibft or /sys/firmware/iscsi_bootX
>>
>> Whenever we detect one of those directories we should assume
>> that the iSCSI devices should be activated.
>>
>> Also incorporates SUSE patches:
>> 0049:
>> 95iscsi: Use 'ip=3Dibft' for ibft autoconfiguration
>>
>> For iBFT autoconfiguration we should be setting 'ip=3Dibft'
>> instead of rd.neednet. This should instruct dracut to only
>> enable the iBFT interfaces and leave the rest alone.
>=20
> I think,
>=20
> /sys/firmware/ibft is created for iBFT if detected.
> /sys/firmware/iscsi_bootX is created for hardware iSCSI if detected.
>=20
Nope.

ibft is created whenever an iBFT section (either in system ROM
or via EFI) is detected.
iscsi_boot is created for be2iscsi devices, which use an iBFT-like
interface.

Both provide the same attributes.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 21284 (AG N=FCrnberg)
