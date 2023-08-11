From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 02/30] x86/microcode: Hide the config knob
Date: Fri, 11 Aug 2023 13:22:36 +0200
Message-ID: <20230811112236.GFZNYZ/Ndw1/Us+X2e@fat_crate.local>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.081212701@linutronix.de>
 <ZNVLh38eq8TWHFra@araj-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691752966; bh=h/v55CWAwzTy+KrxdcUWkvzhq3Ar1s60l7WUk5aCdxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ngm2EUFx70cJ1VJpTqYKAbdQ27g25CIXKcjK0kYaxbWZLruz79Eedfj1ireUU9ykY
         NBgdYWeXnSQmgMch7n3MzmG47tAYmRwLLxujOdtc5wi9pJH6ziJQiX/eDmE2BB1j2U
         EXWUi16cH3YCC8TO+4PMD9J2P1XJVtdaE5g56DJqG/aNbFl1cMWPmehW8Aj4/h0vzs
         4y8+rArAcns7Lf9/VM2Y1RN4empcmb/sAgLMH6sP8lBOO6I6E4J5t+KHhks5FPqjAO
         KqqdjTGIpTu1tpN2g31sD6uWRB32SyEXSxvRISjPE8wtLFPk855/862ijBZX57PGQs
         L/fSn7wY9x+hDsW/aOJtFzrJDrvpU4JgaX/ZaXUbnoG7fD2QbH7xGWy+iAjqWJb4lJ
         sbQpoLXESRAUxPu8URYysjsb53iuwjeqgj5qdx1UXNl7fiHgeRGYz1RM4nx2lue2je
         9u+TSVhgJNmOmuuGUU8igCoS0WQf109cjRqZLPYNZ2v153iD60X6qIHJG83XgluaN2
         /oYmE36Dto0zLjyZzjUra62s9y7sCLHIdCtBrVFTEtaJtbAadEnck7uUwWHyjRjxpW
Content-Disposition: inline
In-Reply-To: <ZNVLh38eq8TWHFra@araj-mobl.amr.corp.intel.com>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ashok Raj <ashok.raj@intel.com>, initramfs@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Arjan van de Ven <arjan@linux.intel.com>

+ dracut ML (I hope this is the right one).

Dracut folks, you can drop this check soon - microcode loader will be
unconditionally built in.

On Thu, Aug 10, 2023 at 01:41:43PM -0700, Ashok Raj wrote:
> On Thu, Aug 10, 2023 at 08:37:29PM +0200, Thomas Gleixner wrote:
> > In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
> > Intel or AMD support is enabled. Accomodate to reality.
> > 
> > Requested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/Kconfig                       |   38 ---------------------------------
> >  arch/x86/include/asm/microcode.h       |    6 ++---
> >  arch/x86/include/asm/microcode_amd.h   |    2 -
> >  arch/x86/include/asm/microcode_intel.h |    2 -
> >  arch/x86/kernel/cpu/microcode/Makefile |    4 +--
> >  5 files changed, 8 insertions(+), 44 deletions(-)
> > 
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
> >  	  Say N otherwise.
> >  
> >  config MICROCODE
> > -	bool "CPU microcode loading support"
> > -	default y
> > +	def_bool y
> >  	depends on CPU_SUP_AMD || CPU_SUP_INTEL
> 
> Seems like there is a dracut dependency that checks for either of these to
> be present.
> 
> dracut: Generating /boot/initrd.img-6.5.0-rc3-ucode-minrev+
> dracut: Disabling early microcode, because kernel does not support it. CONFIG_MICROCODE_[AMD|INTEL]!=y
> 
> Just a tool fix. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
