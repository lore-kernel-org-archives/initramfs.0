From: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Wed, 15 Feb 2012 14:55:40 -0200
Message-ID: <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
	<1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
	<CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
	<4F3BDCAA.7040001@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F3BDCAA.7040001-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mzerqung-uLTowLwuiw4b1SvskN2V4Q@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, Feb 15, 2012 at 2:26 PM, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org=
> wrote:
>
> On 02/15/2012 03:30 PM, Gustavo Sverzut Barbieri wrote:
>>
>> On Wed, Feb 15, 2012 at 11:23 AM, Roberto Sassu<roberto.sassu@polito=
=2Eit> =C2=A0wrote:
>>>
>>> The new function ima_setup() loads an IMA custom policy from a file=
 in the
>>> default location '/etc/sysconfig/ima-policy', if present, and write=
s it to
>>
>>
>> isn't /etc/sysconfig too specific to Fedora?
>>
>
> Hi Gustavo
>
> probably yes. I see the code in 'src/locale-setup.c' where the
> the configuration directory depends on the target distribution.
> I can implement something like that in my patch.

Can't IMA be changed? Lennart seems to be pushing for distribution
independent location files. If you can get IMA people to agree on
something, just use this one instead.

People that use IMA with systemd must use this location. Eventually
this will happen with every configuration file we support.


>> Also, I certainly have no such things in my system and see no point =
in
>> calling ima_setup() on it. Or even compiling the source file in such
>> case.
>>
>
> Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
> statement, as it happens for SELinux. However an issue is that there =
is no a specific package for IMA that can be checked to set the HAVE_IM=
A
> definition to yes. Instead, the code can be enabled for example by
> adding the parameter '--enable_ima' in the configure script.

okay.

--
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
