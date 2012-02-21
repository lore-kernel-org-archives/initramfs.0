From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 14:58:17 +0100
Message-ID: <4F43A2F9.2030901@polito.it>
References: <4F3BDCAA.7040001@polito.it>  <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>  <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>  <4F3D06D1.7000404@polito.it>  <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>  <4F3D144D.3060102@polito.it>  <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>  <20120220172418.GG26356@tango.0pointer.de>	<4F4299C2.5040205@polito.it>  <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it> <1329829311.2186.6.camel@falcor>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=m+T2tu4ybCLda3fXa2Iy3TDzmD2+41MqwARZdJO9TpA=;
        b=pnDyU18xKxFq5Dh7M0Ku/B3ExM903yqcX3RL1cjCupps6BD18EGADbPGFi81gIpggn
         CrQEeGll6owFuFn7UqZVXly5bb+yxS2Lqw0aMPkOJ1o2OlkOLZ9MaQ7Nw1cNRTMBX36Z
         3JxEvAr5ypDujH6+USwjMvEDmFium/eILXffs=
In-Reply-To: <1329829311.2186.6.camel@falcor>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Lennart Poettering <lennart@poettering.net>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, harald@redhat.com, ramunno@polito.it

On 02/21/2012 02:01 PM, Mimi Zohar wrote:
> On Tue, 2012-02-21 at 11:05 +0100, Roberto Sassu wrote:
>
>> Ok. this should be not a problem because all errors (IMA support not
>> included in the kernel, policy file access denied, ...) are ignored
>> except for the mmap() failure.
>
> Hi Roberto, IMA should never return an error, only IMA-appraisal should
> enforce file integrity.  Can you please show me or send a patch?
>

Hi Mimi

do you intend a patch to reintroduce the 'ima=' kernel parameter for
enabling/disabling IMA? If so, i have not actually thought about this
but it should be not difficult to implement. Probably we can support
these modes:

- disabled: IMA returns immediately to the system call;
- measure_only: IMA performs only measurements and does not return any
   error to the system call;
- appraise_permissive: IMA stores measurements in the files extended
   attribute and in the measurements list but does not return any error
   to the system call even if the integrity check fails;
- appraise_enforce: IMA does the same as the previous mode but returns
   an error to the system call if the integrity check fails.

Further, we can have a simple user-space package which will contain the
documentation about how to write a policy (so that it will be more
easy to find in respect to the whole kernel documentation) and a tool
that will fix/verify the measurements stored in the files extended
attribute.

Having a separate user-space package will simplify the interaction for
users with the IMA kernel-space portion and will allow to determine
whether the IMA support should be enabled in Systemd.

Thanks

Roberto Sassu


> thanks,
>
> Mimi
>

