From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [Linux-ima-user] [systemd-devel] [PATCH 2/2] main: added
 support for loading IMA custom policies
Date: Thu, 16 Feb 2012 08:19:37 -0500
Message-ID: <1329398378.4791.57.camel@falcor>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
	 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
	 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
	 <4F3BDCAA.7040001@polito.it>
	 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
	 <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <4F3C8C6F.4010708@gmail.com>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Cassaniti <m.cassaniti@gmail.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, mzerqung@0pointer.de, harald@redhat.com, ramunno@polito.it

On Thu, 2012-02-16 at 15:56 +1100, Michael Cassaniti wrote:
> On 16/02/2012 04:12, Roberto Sassu wrote:
> > On 02/15/2012 05:55 PM, Gustavo Sverzut Barbieri wrote:
> >> On Wed, Feb 15, 2012 at 2:26 PM, Roberto Sassu<roberto.sassu@polito.it>   wrote:
> >>> On 02/15/2012 03:30 PM, Gustavo Sverzut Barbieri wrote:
> >>>> On Wed, Feb 15, 2012 at 11:23 AM, Roberto Sassu<roberto.sassu@polito.it>     wrote:
> >>>>> The new function ima_setup() loads an IMA custom policy from a file in the
> >>>>> default location '/etc/sysconfig/ima-policy', if present, and writes it to
> >>>>
> >>>> isn't /etc/sysconfig too specific to Fedora?
> >>>>
> >>> Hi Gustavo
> >>>
> >>> probably yes. I see the code in 'src/locale-setup.c' where the
> >>> the configuration directory depends on the target distribution.
> >>> I can implement something like that in my patch.
> >> Can't IMA be changed? Lennart seems to be pushing for distribution
> >> independent location files. If you can get IMA people to agree on
> >> something, just use this one instead.
> >>
> >> People that use IMA with systemd must use this location. Eventually
> >> this will happen with every configuration file we support.
> >>
> > The location of the policy file is not IMA dependent. I chose that
> > because it seemed to me the right place where to put this file.
> > So, i can easily modify the location to be distribution independent
> > but i don't known which directory would be appropriate.
> > Any proposal?
> >
> > Regards
> >
> > Roberto Sassu
> >
> >
> >>>> Also, I certainly have no such things in my system and see no point in
> >>>> calling ima_setup() on it. Or even compiling the source file in such
> >>>> case.
> >>>>
> >>> Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
> >>> statement, as it happens for SELinux. However an issue is that there is no a specific package for IMA that can be checked to set the HAVE_IMA
> >>> definition to yes. Instead, the code can be enabled for example by
> >>> adding the parameter '--enable_ima' in the configure script.
> >> okay.
> >>
> >> --
> >> Gustavo Sverzut Barbieri
> >> http://profusion.mobi embedded systems
> >> --------------------------------------
> >> MSN: barbieri@gmail.com
> >> Skype: gsbarbieri
> >> Mobile: +55 (19) 9225-2202

> I'm under the impression this function belongs to a userspace tool. If 
> not then I just don't see a good reason that this patch is required. I 
> do understand that the IMA policy should be loaded as early as possible, 
> but I believe that early userspace scripts should be doing that work. If 
> it is a userspace function, then whatever makes you happy, other 
> distro's will roll their own.

The default 'ima_tcb' measurement policy measures all files executed,
all files mmapped, and all files read by root.  Not all of these files
need to be measured, but until the LSM policy is loaded, there is no
means of identifying files in order to constrain the policy.

Secondly, the 'security.ima' xattr, for files included in the IMA
appraisal policy, is updated on __fput() to reflect changes.  Depending
on when the policy is updated, this could cause the file's real value
and the xattr stored value to be out of sync, resulting in integrity
verification failures.

As the IMA policy definition can be based on LSM obj/subj labels, the
policy needs to be loaded as early as possible, but only after the LSM
policy has been loaded.

thanks,

Mimi

