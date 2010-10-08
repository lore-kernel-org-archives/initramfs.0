From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: dracut requires router
Date: Fri, 08 Oct 2010 14:59:22 +0100
Message-ID: <4CAF23BA.4010605@draigBrady.com>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CAF1D02.6060701-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 08/10/10 14:30, Seewer Philippe wrote:
> On 10/08/2010 12:20 PM, P=C3=A1draig Brady wrote:
>> My terminals just failed to boot because the router
>> was (temporarily) unavailable. Seems this is on purpose?
>>
>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;a=
=3Dcommit;h=3D98f25e96
>>
>>
>> I don't know what the above is trying to do exactly.
>=20
> What this does ist simply try and give a possible router enough time =
to
> update its STP caches (See
> http://en.wikipedia.org/wiki/Spanning_tree_protocol) so that subseque=
nt
> mount attempts don't fail because the router isn't ready.
>=20
> So yes, it is on purpose if the available IP information contains rou=
ters.
>=20
> I Hope this helps

Thanks for the info, but.
Is it right to do this synchronously with such a long timeout?
Is it right to die if we can't contact the router?

cheers,
P=C3=A1draig.
