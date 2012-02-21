From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added
 support for loading IMA custom policies
Date: Tue, 21 Feb 2012 11:15:33 -0500
Message-ID: <1329840934.2186.40.camel@falcor>
References: <4F3BDCAA.7040001@polito.it>
	 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>
	 <4F3D06D1.7000404@polito.it>
	 <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com>
	 <4F3D144D.3060102@polito.it>
	 <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com>
	 <20120220172418.GG26356@tango.0pointer.de>	<4F4299C2.5040205@polito.it>
	 <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>
	 <1329829311.2186.6.camel@falcor> <4F43A2F9.2030901@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <4F43A2F9.2030901@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: Lennart Poettering <lennart@poettering.net>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, harald@redhat.com, ramunno@polito.it, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>

On Tue, 2012-02-21 at 14:58 +0100, Roberto Sassu wrote:
> Hi Mimi
> 
> do you intend a patch to reintroduce the 'ima=' kernel parameter for
> enabling/disabling IMA? If so, i have not actually thought about this
> but it should be not difficult to implement. Probably we can support
> these modes:

I'm not sure.  There was a lot of complaint way back when.  Before
re-introducing it, I'd prefer to hear from others how they feel.

> - disabled: IMA returns immediately to the system call;

Today this is done by booting with a null policy.

> - measure_only: IMA performs only measurements and does not return any
>    error to the system call;

Booting with a policy, will achieve this result.

> - appraise_permissive: IMA stores measurements in the files extended
>    attribute and in the measurements list but does not return any error
>    to the system call even if the integrity check fails;

IMA and IMA-appraisal are different features and should not be combined.
Currently, one can be enabled without the other.  For example, some may
only want the measurement list, while others may only want integrity
enforcement.

> - appraise_enforce: IMA does the same as the previous mode but returns
>    an error to the system call if the integrity check fails.

"ima_appraise= enabled | fix | off" are currently supported.

> Further, we can have a simple user-space package which will contain the
> documentation about how to write a policy (so that it will be more
> easy to find in respect to the whole kernel documentation) and a tool
> that will fix/verify the measurements stored in the files extended
> attribute.
> 
> Having a separate user-space package will simplify the interaction for
> users with the IMA kernel-space portion and will allow to determine
> whether the IMA support should be enabled in Systemd.

Having a Systemd config file wouldn't change the need for the existing
boot command line options.  None of them can or should go away, since
IMA must start measuring before any files are accessed, including the
config and policy files, otherwise the chain of trust would be lost. 

thanks,

Mimi

