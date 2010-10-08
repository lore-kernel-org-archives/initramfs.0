From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: dracut requires router
Date: Fri, 08 Oct 2010 16:19:25 +0100
Message-ID: <4CAF367D.7030707@draigBrady.com>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch> <4CAF23BA.4010605@draigBrady.com> <4CAF27EF.80301@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CAF27EF.80301-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 08/10/10 15:17, Seewer Philippe wrote:
> On 10/08/2010 03:59 PM, P=C3=A1draig Brady wrote:

>> Is it right to die if we can't contact the router?
> Usually yes. Either because the rootserver is behind the router or if
> you supplied routing information it's safe to assume that later you w=
ant
> it to work anyway.

Well in my case the router is just needed for browsing the net.
All other services are provided locally.

> But yes, usually. I would have preferred to somehow a subnet check on
> the rootserver to decide what or if to check. But alas, not all netro=
ot
> variants know the ip of their rootserver at that point.

Right, but no need to penalize the common case.
I.E. we can bypass all this if the rootserver is known,
and on the same subnet.

cheers,
P=C3=A1draig.
