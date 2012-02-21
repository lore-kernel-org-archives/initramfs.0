From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 19:07:05 +0100
Message-ID: <4F43DD49.2040202@polito.it>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it> <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com> <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com> <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it> <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it> <1329829311.2186.6.camel@falcor> <4F43A2F9.2030901@polito.it> <1329840934.2186.40.camel@falcor> <4F43D532.7070006@polito.it> <CAPXgP10zCVgj4gDTzkJ1+XqKSHhjrCHwkUazJ8caaeMF2j+mMg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VHR82oT+ytNABbCYYigUWFxlUvmNJvPxAdPPHYQOhCI=;
        b=O/M6NjSQarE5BbQskFXypBsRbrTooJyzMw/OsMAbqE2XR/I/nmlhT26e8E5AmvH8nA
         ZJWFAvlJOux+vcDhEzq64U8TZXglqJZrFe8MAWR/U6H7Jgw2GugL4H5mfIUqB4ZPntNu
         c1SgFywX3Wn75INokynJMF+GmF2p/K7lvrCa8=
In-Reply-To: <CAPXgP10zCVgj4gDTzkJ1+XqKSHhjrCHwkUazJ8caaeMF2j+mMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>

On 02/21/2012 06:56 PM, Kay Sievers wrote:
> On Tue, Feb 21, 2012 at 18:32, Roberto Sassu<roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>  wrote:
>
>>   I meant we can create a new package called for example 'ima-utils'
>> that can be used by Systemd to determine, at compile time, whether
>> the IMA support for loading custom policies should be enabled or not.
>
> That's not needed. There is no problem enabling ima support
> conditionally in ./configure.
>
> Build systems are unlikely to install ima in the buildroot anyway,
> when there is no library or anything to link against, so
> auto-detection is not really useful.
>
> A default to off and requiring an explicit enable sounds sufficient here.
>

Hi Kay

ok, that was because Systemd also checks for the presence of libselinux
in order to enable the SELinux support. I will introduce in the next
version of the patches only the new configure parameter '--enable_ima'
without additional checks.

Thanks

Roberto Sassu


> Kay
