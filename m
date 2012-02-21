From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Tue, 21 Feb 2012 10:17:56 +0100
Message-ID: <4F436144.1010504@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it> <1329312229-11856-2-git-send-email-roberto.sassu@polito.it> <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com> <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <20120220171446.GD26356@tango.0pointer.de> <4F4292A4.2030402@polito.it> <20120220190720.GC360@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Rpyjqkqa34HROTy+76qW30EBQogp9we6xtAsoQBCajg=;
        b=wvEyDwxfWTwpaPAa3D8mNkpgUkAA7NadRFZYSMTgJrRHbODmbtlkPrIJUHPo2yeIJq
         gNnqcNLhhjbJLzXsKAbxR3mxhHwgsN8Jy81Ao2e+8Nqf6v/WbuPstZm/btsuG4qCoKH2
         VBXta/iAb8pOjUHFOdGhPYL6Pz4kTdhWJeXK0=
In-Reply-To: <20120220190720.GC360@tango.0pointer.de>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 02/20/2012 08:07 PM, Lennart Poettering wrote:
> On Mon, 20.02.12 19:36, Roberto Sassu (roberto.sassu@polito.it) wrote:
>
>>
>> On 02/20/2012 06:14 PM, Lennart Poettering wrote:
>>> On Wed, 15.02.12 18:12, Roberto Sassu (roberto.sassu@polito.it) wrote:
>>>
>>>> The location of the policy file is not IMA dependent. I chose that
>>>> because it seemed to me the right place where to put this file.
>>>> So, i can easily modify the location to be distribution independent
>>>> but i don't known which directory would be appropriate.
>>>> Any proposal?
>>>
>>> /etc/ima.conf or /etc/ima/ima.conf sound like obvious candidates.
>>>
>>
>> I prefer the first one, because the second pathname raises the problem
>> of creating a new subdirectory. However, i think we should keep the
>> word 'policy' in the file name to avoid users believe that is a
>> configuration file.
>
> Creating a subdir is a problem? How so?
>

The problem i see is who creates the subdirectory. In the Systemd case,
i think this should be accomplished in the Makefile or in the RPM
script. Other boot solutions should implement something like that
and they need to create the subdirectory as well. This because, as
said above, there is no an IMA userspace package to perform the
operation. However, if the creation is made by the boot software
i think this should not be a problem.


> You should use a subdir /etc/ima/ if there's the chance that sooner or
> later you might have to add another config file of some sorts to IMA. If
> you are really sure that never happens, then you don't need the dir, but
> if you are in doubt, better use one. (But this is the policy file,
> right? so i figure you might end up with adding a conf file with options
> like selinux' enforcing/permissive later on, so i think you should
> better add a dir)
>

Ok, probably is better to add a new subdirectory to support additional
IMA configuration files. Maybe Mimi Zohar knows if there are plans
to introduce new files.


> (Oh, and in contrast to what i suggested, if this is the policy file,
> and not a configuration file, the .conf suffix of course makes little sense)
>

So, finally i think we can agree to use '/etc/ima/ima-policy' as
pathname for the IMA custom policy.

Thanks

Roberto Sassu


> Lennart
>

