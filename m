From: Steffen Maier <maier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: Failed to use read-only NFS as the root filesystem
Date: Mon, 05 Jul 2010 11:23:20 +0200
Message-ID: <4C31A488.2030608@linux.vnet.ibm.com>
References: <AANLkTimW2-WTf1oqheGOQgfIHcUVpFOEakpnAO8aiQGf@mail.gmail.com> <1278263760.4311.59.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278263760.4311.59.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: "Min Jun,Xi" <xi.minjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 07/04/2010 07:16 PM, David Dillow wrote:
> On Mon, 2010-07-05 at 00:48 +0800, Min Jun,Xi wrote:
>> Hi All,
>> there's one problem here.
>> I tried to set one read-only NFS directory as the root filesystem, b=
ut
>> there're several problems, and lead to one situation that the root
>> filesystem is remounted using read-write option.
>=20
>> Is there any option or flag which can be used to disable it? I think
>> the developers from redhat should know about it.
>=20
> Search /etc/rc.d/rc.sysinit for /etc/sysconfig/readonly-root. I don't
> know if it is well documented or not. You can also use "readonlyroot"=
 on
> the command line I think, but using the file lets you set more option=
s.
> Expect more issues related to this, the last time I looked at it, it
> took some tweaking to make work well.

Even thought it focuses on a specific use case on s390x, the following
document for readonly root-fs on RHEL 5.3 might help you with some more
background information:
http://www.linuxvm.org/Present/misc/ro-root-RH5.pdf

Steffen

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
