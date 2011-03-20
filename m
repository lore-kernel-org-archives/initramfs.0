From: =?utf-8?q?Amadeusz_=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: Re: dracut 008 luks key in external device - still broken
Date: Sun, 20 Mar 2011 01:07:33 +0100
Message-ID: <1300577445-sup-6446@ittemni>
References: <AANLkTi=w7BiyjDa2e5NJVr96q37kZPb2L=BxL1-He=PD@mail.gmail.com> <1300544966-sup-1505@ittemni> <AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1300579653-698720-29800-1774-18-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <AANLkTikifPgn4N1mF67o4Cm3TPBGDfS-TF7RgTXb7NfZ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: jaivuk <jaivuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--=-1300579653-698720-29800-1774-18-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from jaivuk's message of Sun Mar 20 00:14:56 +0100 2011:
> > It re queues cryptroot-ask for after udev queue is settled if key is
> > not available initially. If device is still not available at this
> > point, I am not sure what can be done sensibly.
> =

> I think it should ask for password. And if it does so it would be good
> if I could still connect the key during the password prompt as I
> explained...

First of all I haven't taken into consideration fact, that one can want
to use dracut for mounting something more than root. That's why there's
only key or only password. But it probably would be possible to
optionally ask for password, too. I will have to think of cases with
multiple devices to be decrypted and improve the module.


> > Please provide dmesg output after failed boot.
> I have dmesg output now. However I do not want to violate any rules of
> this list so can you please advise how can I send you dmesg? I can see
> 3 options:
> - attatch it direclty (it has 50k)
> - send link to some external page where I can store it - do you
> suggest any for this purpose?
> - open a Fedora bugzilla ticket and send you ticket number

Please paste it somewhere.


> Which of these 3 options is the best in this case?
> =

> 2011/3/19 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>:
> > UUID should be prefixed with UUID=3D, so it should be:
> >
> > =C2=A0rd.luks.key=3D/mykey:UUID=3Dabcd-1234
> =

> Thats a good advice - I tried that but no luck :(

What happens? Doesn't decrypt anything? Or just one of devices?


> > In Dracut 008 devices are probed for key file asynchronously with
> > udev rules. If device eventually appears, it's probed for key. If
> > key is found, it's added to the list of possibles keys to try.
>
> I like udev is used, however as I mentioned there is still some bug.

Please specify:
1) How did you build initramfs (which options) and please provide output
it has printed. (Append -v to options to get more verbose output.)
2) How did you specify kernel cmd line options.
3) What is expected to happend and what happens.
4) dmesg
5) Content of /tmp/ from initramfs time would be useful, too. (Content
of every file there.)


> > You suggest that for every luks device Dracut should stop and let
> > the user decide to choose between key or password?
>
> Isn't it the case now? What if I had different key for each luks
> partition?

It's applying keys specified at kernel cmd line. You can specify it
multiple times.


> If I udnerstand current dracut logic correctly then if key is found it
> is store in /tmp so it can be reused?

No. Paths (with devices) to keys are stored there.


> So in case an attempt to open another luks partition failes, then yes
> in my view it would be best if user can either enter key manually or
> insert the USB stick with the key (in case rd.luks.key was specified).

Hm, might be good idea.
-- =

Amadeusz =C5=BBo=C5=82nowski

PGP key fpr: C700 CEDE 0C18 212E 49DA  4653 F013 4531 E1DB FAB5

--=-1300579653-698720-29800-1774-18-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJNhUVFAAoJEPATRTHh2/q1VRAH/j70fVdBDDCwXyivAVX4EbNY
/gU+seT1eZEK9EcBIrrPiZIoFFwEVV9DHpd2IMJol5w98UuHrBftCuD4AqpLulhX
I9jCd/7cIHJkI+zXPmt3w/MB5HUC1evTjotRQIHJ8vZUdOYYs4BYhZbXQLbL1RK+
wgnKEWbDXbPFPOfmcgtNYSsKhoj3FtGV1YtdTajfwoHls+Shan1txSBsOYq4nSJg
lfALXS/zMw2/7Mgtn2wWJ2vr9qfolO/o7eb1D1KhU1iKyXW6ChciE/m8gIGJ3bAP
IHwIAg4e4ysJtLgcFRXRq2+gBILnjG9q+uchcHgoJYW0aHobbhdcWVKbYm90NXg=
=kGeb
-----END PGP SIGNATURE-----

--=-1300579653-698720-29800-1774-18-=--
