From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 20:06:51 +0100
Message-ID: <CAPXgP11Org7cUph8geAAQmtafH5oz8BTmeMDbevbowaY+6CRXQ@mail.gmail.com>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it>
 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
 <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
 <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it>
 <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>
 <1329829311.2186.6.camel@falcor> <4F43A2F9.2030901@polito.it>
 <1329840934.2186.40.camel@falcor> <4F43D532.7070006@polito.it>
 <CAPXgP10zCVgj4gDTzkJ1+XqKSHhjrCHwkUazJ8caaeMF2j+mMg@mail.gmail.com> <4F43DD49.2040202@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrfy.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=joXnWVvCAN+OIQFd/NZWMnm3sxun8a1Yw+8qVGhsyMM=;
        b=ZTe9c+GJ33IeLXYE9olD4qjnGm3WeQgLCNPxVX6AYVQz9ca/Uj8Mc07apz7yWDtGDe
         2W3dd68WapHXyyLh+xOy791M8hCO2FVwdqJsJmTzP7qieQewA2W6R568c1jk/ySjAQen
         wCINAOSTuJ2TwX5sxkG6s1nzIytLWD6L+9EjQ=
In-Reply-To: <4F43DD49.2040202-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>

On Tue, Feb 21, 2012 at 19:07, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org> wrote:
> On 02/21/2012 06:56 PM, Kay Sievers wrote:

> ok, that was because Systemd also checks for the presence of libselinux
> in order to enable the SELinux support.

Yeah, systemd provides a shared lib which we need to link against,
hence the systemd is needed at build time, and needs to be in the
buildroot and we can do the auto-detect here. If ima will ever need a
shared lib or other files at build time, we can change that.

> I will introduce in the next
> version of the patches only the new configure parameter '--enable_ima'
> without additional checks.

Sounds good. Options are usually a ll dashes not underscores, you can
check the current ones with ./configure --help.

Thanks,
Kay
