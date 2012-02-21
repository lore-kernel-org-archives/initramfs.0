From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 11:05:46 +0100
Message-ID: <4F436C7A.9020206@polito.it>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it> <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com> <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com> <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it> <20120220191804.GD360@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0eWnUGF6oLvL8xwC2FtF9VNaX4LSJGEl5IbxHdIzhpM=;
        b=UQY1DAVyhOByh/NNxSLZIGat0mVtlIN+miSIH7Ak+NqhVzAcuvRUFmc0dJCjS+3VIf
         DJf0p5xEToiyjLnBEV5L39UNIw5gKGoR7JcOpNZ429IolV+Gm7xeLYqt3MdA4a8pnUYm
         QqH1d8fI6MBgv/tKSdaJahheUTnQMErqmIxGY=
In-Reply-To: <20120220191804.GD360-kS5D54t9nk0aINubkmmoJbNAH6kLmebB@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Cc: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Michael Cassaniti <m.cassaniti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On 02/20/2012 08:18 PM, Lennart Poettering wrote:
> On Mon, 20.02.12 20:06, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:
>
>>> We moved SELinux loading out of the initrd into systemd, in order to
>>> support fully featured initrd-less boots. I don't think we should reopen
>>> this problem set by having IMA in the initrd. I believe IMA should be
>>> treated pretty much exactly like SELinux here: the policy should be
>>> loaded from PID1 and it needs to be a compile time option, and it needs
>>> a kernel cmdline option to disable it (i.e. like selinux=0).
>>>
>>
>> If the SELinux module in dracut is to be considered definitively broken
>> probably also the IMA module should be removed, because it will not be
>> possible to load policies with LSM rules. But i don't know how this
>> feature can be supported by distributions without Systemd installed.
>
> Well, if the rumours I keep hearing are true Ubuntu might join the
> systemd camp too after their LTS release. Maybe the supporting
> non-systemd systems issues solves itself by that for you?
>

The code for loading IMA custom policies was placed in the initial
ramdisk with the purpose to avoid distribution specific dependencies.
However, since the SELinux initialization has been moved to Systemd
and Systemd itself will be used by the major distributions, i think
placing the IMA code here is the best solution, even if it is not the
most general.


>> Regarding the kernel option, actually there is no a specific parameter
>> to disable IMA. However, it can be introduced in the patches proposed
>> by Mimi Zohar about the 'ima-appraisal' feature. This can allow to
>> disable IMA or to put it in permissive/enforce mode as it happens for
>> example in SELinux.
>
> Whether there is a kernel option to enable/disable IMA will not stop
> these patches from getting into systemd. But I am quite sure they will
> stop IMA from getting any wider coverage in the mainstream distributions
> (if you care for that).
>

Actually, IMA doesn't take any action if the policy is not provided
nor it consumes additional system resources. Further, in the current
implementation, even if IMA measures files it does not return any error
to the system call being executed.


> Oh, and one more thing: it matters to me that this doesn't break my
> build. So it needs to allow me booting when enabled in configure, but
> without any IMA policy around.
>

Ok. this should be not a problem because all errors (IMA support not
included in the kernel, policy file access denied, ...) are ignored
except for the mmap() failure.

Thanks

Roberto Sassu


> Lennart
>
