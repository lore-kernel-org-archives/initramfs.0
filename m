From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 18:32:34 +0100
Message-ID: <4F43D532.7070006@polito.it>
References: <4F3BDCAA.7040001@polito.it>  <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>  <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>  <4F3D06D1.7000404@polito.it>  <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>  <4F3D144D.3060102@polito.it>  <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>  <20120220172418.GG26356@tango.0pointer.de>	<4F4299C2.5040205@polito.it>  <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>  <1329829311.2186.6.camel@falcor> <4F43A2F9.2030901@polito.it> <1329840934.2186.40.camel@falcor>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rlE+a1QxjD1Mcw7jQkKqYGgq1o4PYm8U6KlhGvbkkwQ=;
        b=j1MCDilFpH4sUFU0eSEke28h5lYsc8djxJM/8WzkN2elQfOBqQs9pCFutQqkqSkZIQ
         WuzmNIec0hNIfJ0eHBdJuYm3+9WiiLI434soCje9LvDkyDsATtzj7CNMXKA9+Pj5FU6D
         qdhjW2jYmdK9BDa8Uq1GGNqcxdymX1cQNGJWo=
In-Reply-To: <1329840934.2186.40.camel@falcor>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Lennart Poettering <lennart@poettering.net>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, harald@redhat.com, ramunno@polito.it, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>

On 02/21/2012 05:15 PM, Mimi Zohar wrote:
> On Tue, 2012-02-21 at 14:58 +0100, Roberto Sassu wrote:
>> Hi Mimi
>>
>> do you intend a patch to reintroduce the 'ima=' kernel parameter for
>> enabling/disabling IMA? If so, i have not actually thought about this
>> but it should be not difficult to implement. Probably we can support
>> these modes:
>
> I'm not sure.  There was a lot of complaint way back when.  Before
> re-introducing it, I'd prefer to hear from others how they feel.
>

Ok, it is better to wait until this point becomes clear.


>> - disabled: IMA returns immediately to the system call;
>
> Today this is done by booting with a null policy.
>

I think 'disabled' would mean that the hooks implementation should
consist only in a immediate return without the execution of any
specific code (in the IMA case, the function ima_must_measure()).
Probably it is a good idea to allow to completely disable IMA at
runtime.


>> - measure_only: IMA performs only measurements and does not return any
>>     error to the system call;
>
> Booting with a policy, will achieve this result.
>

The purpose of the 'ima=' kernel parameter can be also to select
the IMA features to be enabled at runtime. So, to avoid confusion,
we can use it to disable all features, to enable the measure or
appraise capabilities or both. Then, we can keep the existing
'ima_appraise=' parameter while defining the values 'permissive'
and 'enforcing'.


>> - appraise_permissive: IMA stores measurements in the files extended
>>     attribute and in the measurements list but does not return any error
>>     to the system call even if the integrity check fails;
>
> IMA and IMA-appraisal are different features and should not be combined.
> Currently, one can be enabled without the other.  For example, some may
> only want the measurement list, while others may only want integrity
> enforcement.
>

Maybe both can be useful. For example, the appraise feature allows
to detect if a file has been tampered with while the measurement
feature allows verifiers to determine if the value stored can be
considered good or not.


>> - appraise_enforce: IMA does the same as the previous mode but returns
>>     an error to the system call if the integrity check fails.
>
> "ima_appraise= enabled | fix | off" are currently supported.
>
>> Further, we can have a simple user-space package which will contain the
>> documentation about how to write a policy (so that it will be more
>> easy to find in respect to the whole kernel documentation) and a tool
>> that will fix/verify the measurements stored in the files extended
>> attribute.
>>
>> Having a separate user-space package will simplify the interaction for
>> users with the IMA kernel-space portion and will allow to determine
>> whether the IMA support should be enabled in Systemd.
>
> Having a Systemd config file wouldn't change the need for the existing
> boot command line options.  None of them can or should go away, since
> IMA must start measuring before any files are accessed, including the
> config and policy files, otherwise the chain of trust would be lost.
>

I meant we can create a new package called for example 'ima-utils'
that can be used by Systemd to determine, at compile time, whether
the IMA support for loading custom policies should be enabled or not.
At runtime, Systemd could inspect the kernel command line looking for 
IMA-related parameters (this solution is actually not available) or,
as implemented in my patch, it will only check for the presence of the 
policy file in the default location. This file will be measured by
the boot loader, together with the Systemd main executable, to preserve
the chain of trust.

Thanks

Roberto Sassu


> thanks,
>
> Mimi
>

