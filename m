From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: dracut requires router
Date: Fri, 8 Oct 2010 15:30:42 +0200
Message-ID: <4CAF1D02.6060701@bfh.ch>
References: <4CAEF060.8030701@draigBrady.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CAEF060.8030701-V8g9lnOeT5ydJdNcDFJN0w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/08/2010 12:20 PM, P=C3=A1draig Brady wrote:
> My terminals just failed to boot because the router
> was (temporarily) unavailable. Seems this is on purpose?
>
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=3Ddracut/dracut;a=3D=
commit;h=3D98f25e96
>
> I don't know what the above is trying to do exactly.

What this does ist simply try and give a possible router enough time to=
=20
update its STP caches (See=20
http://en.wikipedia.org/wiki/Spanning_tree_protocol) so that subsequent=
=20
mount attempts don't fail because the router isn't ready.

So yes, it is on purpose if the available IP information contains route=
rs.

I Hope this helps

Regards,
Philippe
