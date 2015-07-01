From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: initramfs / cryptsetup decryption
Date: Wed, 1 Jul 2015 18:25:26 +0300
Message-ID: <20150701182526.07332f58@laptop.puleglot.ru>
References: <1435762088.18436.4.camel@gnat.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=lE4etV7wNO75sFJ3bMPmWI7YhMKwvy43FwUH7V+2aBU=;
	b=oHm4f9n20lQvsk5/2PIo9B06N3sFidL75gwdf6Uh2S9A7UB5y3tyaTRKRVmvjjduvv3Q/0chxsv9n/YYPfVYgiafHpSKUOxqgj17sCrPvPO+oE9ibi6BRLYl5XssEbwckQ6Qg3OF5rNpMr09czfpiAdZ3UvtqSR9XenseTbXJbA=;
In-Reply-To: <1435762088.18436.4.camel-sGhsi8tFlmY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Nathanael D. Noblet" <nathanael-sGhsi8tFlmY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=D0=92 Wed, 01 Jul 2015 08:48:08 -0600
"Nathanael D. Noblet" <nathanael-sGhsi8tFlmY@public.gmane.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:

> Hello,
>=20
>   So I've been trying to figure out how to have remote systems with
> encrypted partitions (including / ) be encrypted but be able to reboo=
t
> them remotely.
>=20

There is an attempt to integrate crypt-ssh module in dracut:
https://github.com/haraldh/dracut/pull/43

--=20
Alexander Tsoy
