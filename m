From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Dracut -- Cross distribution initramfs infrastructure
Date: Thu, 18 Dec 2008 08:36:07 +0100
Message-ID: <4949FD67.6040906__17943.0117983886$1232286222$gmane$org@suse.de>
References: <1229540094.28858.150.camel@aglarond.local>
	 <20081217190700.GA15377@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
In-Reply-To: <20081217190700.GA15377-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, cjwatson-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org, Bernhard Walle <bwalle-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>

Christoph Hellwig wrote:
> On Wed, Dec 17, 2008 at 01:54:54PM -0500, Jeremy Katz wrote:
>> As davej started talking about a few months ago at Kernel Summit and
>> LPC, there's a lot of duplication between distros on the tools used to
>> generate the initramfs as well as the contents and how the initramfs
>> works.  Ultimately, there's little reason for this not to be something
>> that is shared and worked on by everyone.  Added to this is the fact
>> that everyone's infrastructures for this have grown up over a long-ish
>> period of time without significant amounts of reworking for the way that
>> the kernel and early boot works these days.
>>
>> Therefore I've started on a new project, dracut, to try to be a new
>> initramfs tool that can be used across various distributions.  From the
>> README...
>=20
> It looks like Hannes has also been working on a new, modular initramfs
> for a while:
>=20
> 	http://git.kernel.org/?p=3Dlinux/kernel/git/hare/mkinitrd.git;a=3Dsummary
>=20
> I hope you guys can get together and agree on one implementation..

Thanks hch for pointing this out.

We definitely should get together to hammer our one implementation.
Having different scripts for every distributions is a PITA.

I'm not saying my implementation is the greatest on earth, so
if anyone has any better suggestions I'm all ears.

If anyone is interested I can give a short overview of it.
As per normal, proper documentation is about to be written RSN.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
