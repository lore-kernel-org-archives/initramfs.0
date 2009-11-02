From: Yanko Kaneti <yaneti-jUE9FD3ILm5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Basic root filesystem maintenance module
Date: Mon, 02 Nov 2009 18:02:22 +0200
Message-ID: <1257177742.5298.24.camel@d2>
References: <1257175061.5298.8.camel@d2>  <4AEEFAC8.4010202@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AEEFAC8.4010202-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-11-02 at 16:29 +0100, Seewer Philippe wrote:
> Yanko Kaneti wrote:
> > Just the other day I rebooted with rdbreak with the idea to shrink
> the
> > root fs a little, only to find that none of the fack/resize/tune
> tools
> > for ext3 were actually in the initramfs. Here is a first attempt at
> a
> > basic dracut module that includes those. Worked in brief testing.
> 
> Not a bad idea! Just a thought: Why not just add these to the debug
> module?

As far as I understand its off by default which would have also foiled
my initial uninformed attempt at resizing. I kinda expected a generic
initrd to have some basic fs maintenance tools. 



> 
> > 
> > Not really attached to the patch itself, but I would like to have a
> way
> > to include those basic tools one way or the other.
> > 
> > Cheers
> > Yanko
> > 
> > ---
> >  dracut.spec               |   11 +++++++++++
> >  modules.d/60maint/check   |    2 ++
> >  modules.d/60maint/install |    2 ++
> >  3 files changed, 15 insertions(+), 0 deletions(-)
> >  create mode 100755 modules.d/60maint/check
> >  create mode 100755 modules.d/60maint/install
> > 
> > diff --git a/dracut.spec b/dracut.spec
> > index 01d58e1..2ac8d52 100644
> > --- a/dracut.spec
> > +++ b/dracut.spec
> > @@ -82,6 +82,13 @@ Requires: %{name}-network = %{version}-%{release}
> >  This package requires everything which is needed to build a generic
> >  all purpose initramfs with dracut.
> >  
> > +%package maint
> > +Summary: dracut module for basic root filesystem maintenance
> > +Requires: e2fsprogs, util-linux-ng
> > +
> > +%description maint
> > +This package requires everything needed for basic root filesystem
> maintenance
> > +from within the initramfs (currently only ext234)
> >  
> >  %package kernel
> >  Summary: Metapackage to build generic initramfs with dracut with
> only kernel modules
> > @@ -183,6 +190,10 @@ rm -rf $RPM_BUILD_ROOT
> >  %defattr(-,root,root,0755)
> >  %doc README.generic
> >  
> > +%files maint
> > +%defattr(-,root,root,0755)
> > +%{_datadir}/dracut/modules.d/60maint
> > +
> >  %files tools 
> >  %defattr(-,root,root,0755)
> >  %doc COPYING NEWS
> > diff --git a/modules.d/60maint/check b/modules.d/60maint/check
> > new file mode 100755
> > index 0000000..fc59a03
> > --- /dev/null
> > +++ b/modules.d/60maint/check
> > @@ -0,0 +1,2 @@
> > +#!/bin/bash
> > +which fsck fsck.ext4 fsck.ext2 fsck.ext3 resize2fs tune2fs
> >/dev/null
> > diff --git a/modules.d/60maint/install b/modules.d/60maint/install
> > new file mode 100755
> > index 0000000..e7f2848
> > --- /dev/null
> > +++ b/modules.d/60maint/install
> > @@ -0,0 +1,2 @@
> > +#!/bin/bash
> > +dracut_install fsck fsck.ext4 fsck.ext2 fsck.ext3 resize2fs tune2fs
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

