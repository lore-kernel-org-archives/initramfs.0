From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added
 support for loading IMA custom policies
Date: Tue, 21 Feb 2012 08:01:50 -0500
Message-ID: <1329829311.2186.6.camel@falcor>
References: <4F3BDCAA.7040001@polito.it>
	 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>
	 <4F3D06D1.7000404@polito.it>
	 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
	 <4F3D144D.3060102@polito.it>
	 <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
	 <20120220172418.GG26356@tango.0pointer.de>	<4F4299C2.5040205@polito.it>
	 <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F436C7A.9020206-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Tue, 2012-02-21 at 11:05 +0100, Roberto Sassu wrote:

> Ok. this should be not a problem because all errors (IMA support not
> included in the kernel, policy file access denied, ...) are ignored
> except for the mmap() failure.

Hi Roberto, IMA should never return an error, only IMA-appraisal should
enforce file integrity.  Can you please show me or send a patch?

thanks,

Mimi
