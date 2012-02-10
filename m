From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: dracut: ordering of modules
Date: Fri, 10 Feb 2012 16:31:12 +0100
Message-ID: <4F353840.8050505@polito.it>
References: <1328886121.2472.19.camel@falcor>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nHEODW14a1PoiVEqMgYm4dD3zyYT8h3tv2TJVTnrDqE=;
        b=HIJkUSmPEFu2c3c4UgkH3PzcYVS93ZERd7gR1Rfy/VQfBpvH+JjL0juHMDOdXqTqfO
         LZIuIs4BfpIH0BMZa7bgIO+9YkxJZh+yvrXvb1eyyawEeCVuscAKsZTbs1DTrQlUkdqQ
         wFx01AAz4V6TwyUESXijmdLE9onEbY27NwpcY=
In-Reply-To: <1328886121.2472.19.camel@falcor>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, selinux-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org

Hi Mimi

i'm CCing the systemd and Fedora SELinux mailing lists.

Unfortunately, the SELinux policy initialization (at least
in Fedora 16) has been moved to systemd, so, now, loading an
IMA policy cannot be done in the initial ramdisk.

Further, the SELinux policy loading code is not in a unit file
but embedded in the main binary, which means that the new code for
loading IMA policies must be added just after that point.

I already wrote a patch for this. I need some time to test it
and will post in the systemd mailing list at the beginning of
the next week.

Roberto Sassu


On 02/10/2012 04:01 PM, Mimi Zohar wrote:
> Hi Harald,
>
> Originally, 98integrity/ima-policy-load.sh didn't start executing before
> 98selinux/selinux-loadpolicy.sh finished, but unfortunately it now does.
>
> inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
> inst_hook pre-pivot 62 "$moddir/ima-policy-load.sh"
>
> As the IMA policy could be dependent on LSM runtime info, this is a
> problem.
>
> [   10.040574] type=1805 audit(1328865524.387:2): action="dont_measure" fsmagic="0x9fa0" res=0
> [   10.040663] type=1805 audit(1328865524.387:3): action="dont_appraise" fsmagic="0x9fa0" res=0
> [   10.040729] type=1805 audit(1328865524.387:4): action="dont_measure" fsmagic="0x62656572" res=0
> [   10.040792] type=1805 audit(1328865524.387:5): action="dont_appraise" fsmagic="0x62656572" res=0
> [   10.040857] type=1805 audit(1328865524.387:6): action="dont_measure" fsmagic="0x64626720" res=0
> [   10.040921] type=1805 audit(1328865524.387:7): action="dont_appraise" fsmagic="0x64626720" res=0
> [   10.040985] type=1805 audit(1328865524.387:8): action="dont_measure" fsmagic="0x01021994" res=0
> [   10.041047] type=1805 audit(1328865524.387:9): action="dont_appraise" fsmagic="0x01021994" res=0
> [   10.041113] type=1805 audit(1328865524.387:10): action="dont_measure" fsmagic="0x73636673" res=0
> [   10.041177] type=1805 audit(1328865524.387:11): action="dont_appraise" fsmagic="0x73636673" res=0
> [   11.898956] SELinux:  Completing initialization.
>
> I've tried adding a depend for selinux, but it doesn't seem to resolve
> the problem, nor does delaying 98integrity to later.  Any suggestions
> would be appreciated.
>
> thanks,
>
> Mimi
>
