From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 19:25:10 +0100
Message-ID: <4F43E186.1020108@polito.it>
References: <4F3BDCAA.7040001@polito.it>  <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>  <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>  <4F3D06D1.7000404@polito.it>  <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>  <4F3D144D.3060102@polito.it>  <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>  <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it>  <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>  <ji08e6$8kc$1@dough.gmane.org>  <CAPXgP13c1B80u14E4FrhZEJ89NDvDP--ciWikz0j+m4En6zPRQ@mail.gmail.com> <1329840852.2186.39.camel@falcor>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <1329840852.2186.39.camel@falcor>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-security-module@vger.kernel.org
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, systemd-devel@lists.freedesktop.org

On 02/21/2012 05:14 PM, Mimi Zohar wrote:
> On Tue, 2012-02-21 at 15:32 +0100, Kay Sievers wrote:
>> On Tue, Feb 21, 2012 at 15:07, Colin Guthrie<gmane@colin.guthr.ie>  wrote:
>>
>>>> The code for loading IMA custom policies was placed in the initial
>>>> ramdisk with the purpose to avoid distribution specific dependencies.
>
> In a trusted-grub, or equivalent environment, the kernel, initramfs, and
> kernel boot options are measured.  The main reason for loading the IMA
> policy in the initramfs was that the policy would be included in the
> initramfs measurement.
>

Unfortunately not, the policy file is placed in the root filesystem.
However, since trusted-grub supports the measurement of an user-defined
list of files, it is possible to preserve the chain of trust by
measuring the policy file and the Systemd main executable.

Roberto Sassu


> Mimi
>
>>>> However, since the SELinux initialization has been moved to Systemd
>>>> and Systemd itself will be used by the major distributions, i think
>>>> placing the IMA code here is the best solution, even if it is not the
>>>> most general.
>>>
>>> Just for reference, not all distros use the same initrd generator
>>> anyway. We're trying to move to dracut, but it's certainly not universal
>>> at the moment. I think Suse use something else (maybe they plan to move
>>> to dracut too?) and I've no idea about Ubuntu but I doubt they use dracut.
>>>
>>> So I'd suggest that at the moment, systemd will actually get you wider
>>> coverage... although that's just a slightly ill-informed and hand-wave
>>> analysis on my part. Either way, I think it's better in systemd :D
>>
>> Sounds right. The initramfs is definitely less generic than systemd
>> is. Almost every distro has still its own here. The situation today
>> with initramfs generators can probably not get more distro-specific;
>> it is still almost at its maximum. :)
>>
>> So the thinking of moving anything to the initramfs to avoid the Linux
>> distro balcanization problem will usually not work out.
>>
>> Kay
>
>


