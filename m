From: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Thu, 16 Feb 2012 12:30:31 -0200
Message-ID: <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
	<1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
	<CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
	<4F3BDCAA.7040001@polito.it>
	<CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	<4F3BE763.9060704@polito.it>
	<4F3C8C6F.4010708@gmail.com>
	<4F3D06D1.7000404@polito.it>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <4F3D06D1.7000404@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: Michael Cassaniti <m.cassaniti@gmail.com>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, mzerqung@0pointer.de, harald@redhat.com, ramunno@polito.it

On Thu, Feb 16, 2012 at 11:38 AM, Roberto Sassu <roberto.sassu@polito.it> wrote:
> On 02/16/2012 05:56 AM, Michael Cassaniti wrote:
>>
>> On 16/02/2012 04:12, Roberto Sassu wrote:
>>>
>>> On 02/15/2012 05:55 PM, Gustavo Sverzut Barbieri wrote:
>>>>
>>>> On Wed, Feb 15, 2012 at 2:26 PM, Roberto
>>>> Sassu<roberto.sassu@polito.it> wrote:
>>>>>
>>>>> On 02/15/2012 03:30 PM, Gustavo Sverzut Barbieri wrote:
>>>>>>
>>>>>> On Wed, Feb 15, 2012 at 11:23 AM, Roberto
>>>>>> Sassu<roberto.sassu@polito.it> wrote:
>>>>>>>
>>>>>>> The new function ima_setup() loads an IMA custom policy from a
>>>>>>> file in the
>>>>>>> default location '/etc/sysconfig/ima-policy', if present, and
>>>>>>> writes it to
>>>>>>
>>>>>>
>>>>>> isn't /etc/sysconfig too specific to Fedora?
>>>>>>
>>>>> Hi Gustavo
>>>>>
>>>>> probably yes. I see the code in 'src/locale-setup.c' where the
>>>>> the configuration directory depends on the target distribution.
>>>>> I can implement something like that in my patch.
>>>>
>>>> Can't IMA be changed? Lennart seems to be pushing for distribution
>>>> independent location files. If you can get IMA people to agree on
>>>> something, just use this one instead.
>>>>
>>>> People that use IMA with systemd must use this location. Eventually
>>>> this will happen with every configuration file we support.
>>>>
>>> The location of the policy file is not IMA dependent. I chose that
>>> because it seemed to me the right place where to put this file.
>>> So, i can easily modify the location to be distribution independent
>>> but i don't known which directory would be appropriate.
>>> Any proposal?
>>>
>>> Regards
>>>
>>> Roberto Sassu
>>>
>>>
>>>>>> Also, I certainly have no such things in my system and see no point in
>>>>>> calling ima_setup() on it. Or even compiling the source file in such
>>>>>> case.
>>>>>>
>>>>> Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
>>>>> statement, as it happens for SELinux. However an issue is that there
>>>>> is no a specific package for IMA that can be checked to set the
>>>>> HAVE_IMA
>>>>> definition to yes. Instead, the code can be enabled for example by
>>>>> adding the parameter '--enable_ima' in the configure script.
>>>>
>>>> okay.
>>>>
>>>> --
>>>> Gustavo Sverzut Barbieri
>>>> http://profusion.mobi embedded systems
>>>> --------------------------------------
>>>> MSN: barbieri@gmail.com
>>>> Skype: gsbarbieri
>>>> Mobile: +55 (19) 9225-2202
>>
>> I'm under the impression this function belongs to a userspace tool. If
>> not then I just don't see a good reason that this patch is required. I
>> do understand that the IMA policy should be loaded as early as possible,
>> but I believe that early userspace scripts should be doing that work. If
>> it is a userspace function, then whatever makes you happy, other
>> distro's will roll their own.
>
>
> Thanks Mimi for your contribution. I just want to add some
> considerations.
>
>
>
> Hi Michael
>
> the reason for which the loading of IMA policies has been placed in
> the main Systemd executable is that the measurement process performed
> by IMA should start as early as possible. Otherwise, in order to build
> the 'chain of trust' during the boot process from the BIOS to software
> applications, it is required to measure those components loaded before
> IMA is initialized with other means (for example from the boot loader).
>
> The more the IMA initialization is postponed, greater is the number of
> components that must be measured using the second way. For instance,
> if the policy loading is done in a userspace script you have to measure
> the interpreter and the configuration files read by the latter.
>
> Since the policy loading can be implemented in different ways depending
> on the init system (systemd, upstart, ...), an user must identify the
> components to be measured for each case. Instead, if the IMA policy is
> loaded in the main Systemd executable, only this file must be measured
> by the boot loader.

Then I wonder: why not make an ima-init binary that:
  - does ima_setup()
  - exec systemd || upstart || ...

this way you only have to audit this very small file and not systemd
itself, it's very early and so on.

-- 
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri@gmail.com
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
