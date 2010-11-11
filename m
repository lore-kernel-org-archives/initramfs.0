From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Thu, 11 Nov 2010 21:30:31 +0100
Message-ID: <20101111203031.GB3336@stro.at>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>
 <4CD9102B.7030702@bfh.ch>
 <AANLkTi=EkL7ivKKj6ck3w6RuOOq++cGwtP_pX0HHhVWu@mail.gmail.com>
 <20101109125820.GO19612@vostochny.stro.at>
 <AANLkTimfYTDFkUgk3x0ry6Z1Q_COYyij5CKMs_50t9MK@mail.gmail.com>
 <AANLkTikGCZofdYvX78vw+Rj_XmKyY1FmVcp_NT=_B_fF@mail.gmail.com>
 <20101110195826.GA8486@vostochny.stro.at>
 <AANLkTi=MCfaK5K-ZV3gvrFCzezJdjAMf-WY_VgM64dHA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=MCfaK5K-ZV3gvrFCzezJdjAMf-WY_VgM64dHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 10 Nov 2010, Jon Ander Hernandez wrote:

> 2010/11/10 maximilian attems <max-U9r9yeDMy7A@public.gmane.org>:
>=20
> > yes, but didn't understand your reply and short of time..
> > this seems like a chicken and egg trouble, please rephrase more coh=
erently.
>=20
> I'm sorry, I need to improve my English. :-)
>=20
> I meant that if we ship Dracut with the kernel postinst script
> (/etc/kernel/postinst), then the next time a linux image is installed=
,
> that script will be fired and a Dracut based initramfs will be create=
d
> for that new kernel.
>=20
> But when we install Dracut for the first time, there is not any Dracu=
t
> based initramfs installed on the system, and Dracut package's postins=
t
> calls actually only call "dracut-update-initramfs -u" which only
> updates the initramfs images present in the system (in this case no
> one). So after installing Dracut you won't get a Dracut based image
> for the kernel you are using, which is not very consistent with the
> behaviour of creating the initramfs for any new kernel installed
> afterwards.

no, no this wrong logic.
first of all the linux image depends on the a linux initramfs creator
tool and thus this is installed *before* linux-2.6.

> I understand that is the linux kernel package's mission to call the
> kernel postinst scripts under /etc/kernel/postinst, but... I think we
> should do something. Maybe make the current linux kernel package call
> the /etc/kernel/postinst scripts, or maybe call
> dracut-update-initramfs, which was what I was doing in my original
> patch... =BFWhat could be the best solution?

the proposed create seems really wrong, I would nack any postinst
in debian or escalate as serious bug.

if you want hostile takeover that is up to the local admin
and only one command away
update-intramfs-dracut -t -u -k all
=20
--=20
maks
