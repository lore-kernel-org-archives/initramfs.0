From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [PATCH] mdraid/module-setup.sh: fixes for mdadm-3.2.6+
Date: Sat, 28 Sep 2013 21:14:36 +0400
Message-ID: <20130928211436.5b64bcb5@home.puleglot>
References: <1380371575.4054.1.camel@home.puleglot>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date; bh=vCeYvKYZLVS9tuwxsnUoEd0UCIImntND1GRJ1FhAeeM=;
	b=HC5p/3jZ3mCo0Me1dGY/mqs8/oBu6Ju+/Rp8WPFCSjfwIpFnFTbyEnttBfdfQk0FnwUVBQ/UUBcfnKRvcOUiUCTra3vtFHA33F3l4Hhw/Lv2Cy77fFJbsyJLUv+hHLdz+jiMHWkZ0XIa///ygqC0VoPOoLWRY9C97tuRAU37/3g=;
In-Reply-To: <1380371575.4054.1.camel-gl4+DzqHFJLpx9ONITL1FA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=F7 Sat, 28 Sep 2013 16:32:55 +0400
Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org> =D0=C9=DB=C5=D4:

> Fix the following issues:
> - mdadm-3.2.6: incremental assembly rule contain "--offroot" arg.
> Catch this variant.
> - mdadm-3.3: rules was splitted into two files:
> 63-md-raid-arrays.rules, 64-md-raid-assembly.rules. Install the
> former, omit the latter.

Actually I'm not sure that we need to omit 64-md-raid-assembly.rules.
It also contains rules for ACTION=3D=3D"remove", that may be necessary =
even
in the initramfs. So we can install it and edit with the same sed
command, that is used for 64-md-raid.rules. What do you think?

--=20
Alexander Tsoy
