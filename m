From: Andrey Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Firmware assisted dump support in dracut
Date: Tue, 4 Jun 2013 22:42:10 +0400
Message-ID: <20130604224210.45e7da7a@opensuse.site>
References: <20121128161234.GA8991@in.ibm.com>
	<50B73598.804@redhat.com>
	<50C03971.4050104@linux.vnet.ibm.com>
	<51A6E0E4.1000502@linux.vnet.ibm.com>
	<51A6F663.5030804@redhat.com>
	<51ADA6AB.5010503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=/+E1QtKrvcgjiC8a9b2DDWqJijcqoZAiFoCTCwiJhpc=;
        b=PmLms3ivrXisvBnW1pXY7JtdH+u3ZILkIQFm1SPb6NUBNExzwsyCY83IhKdSG1DLGB
         85mnYB/creFckbZaLFmttlXKYynJ37wo0nSmALvW6sfa/rtWbxUPi29MaqZQw/VL/HMm
         jZsFyL9qmeBSDTfg8Pze3j82Eeh1lURBBXg0/fpdEyPdzabcolpJoPyLqos6/SBVLnoc
         6XoYRj5M23NMmud47LEFBAyyBJQdzM9ZA8cbbx9UDiC5jVIjk1fvWQWUWou/xqOHvMdr
         HlGaq73Ha9u111Ldl5kRuZiMJnqUURZYs2fswBHQgBr1i1ijY6egI/fdNhuMZWbSYQRS
         iMSg==
In-Reply-To: <51ADA6AB.5010503-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Initramfs Dracut <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ananth Narayan <ananth-xthvdsQ13ZrQT0dZR+AlfA@public.gmane.org>, Steven F Best <sbest-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

=F7 Tue, 04 Jun 2013 14:04:51 +0530
Mahesh Jagannath Salgaonkar <mahesh-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> =D0=C9=DB=C5=D4=
:

> On 05/30/2013 12:19 PM, Harald Hoyer wrote:
> > On 05/30/2013 07:17 AM, Mahesh Jagannath Salgaonkar wrote:
> >> On 12/06/2012 11:51 AM, Mahesh Jagannath Salgaonkar wrote:
> >>> On 11/29/2012 03:44 PM, Harald Hoyer wrote:
> >>>> Am 28.11.2012 17:12, schrieb Mahesh J Salgaonkar:
> >>>>> Hi Harald,
> >>>>>
> >>>>> Last year I worked on adding Firmware assisted dump (fadump) su=
pport in
> >>>>> PowerLinux (ppc64). This feature is now accepted upstream Linux=
 kernel and the
> >>>>> documentation is available at http://lwn.net/Articles/488132/
> >>>>>
> >>>>> Like kdump, fadump also exports the memory dump through /proc/v=
mcore in ELF
> >>>>> format. This enables us to reuse the existing kdump infrastruct=
ure for dump
> >>>>> capture and filtering. However, unlike kdump, fadump does not u=
se kexec-based
> >>>>> approach, instead it depends on Power firmware to preserve the =
memory dump and
> >>>>> reboot into new kernel. This is what happens in fadump after cr=
ash:
> >>>>>
> >>>>> 1. At the crash, kernel informs power firmware that kernel has =
crashed.
> >>>>> 2. Firmware takes the control and reboots the entire system pre=
serving only the
> >>>>> memory (resets all other devices).
> >>>>> 3. The reboot follows the normal booting process (non-kexec).
> >>>>> 4. The boot loader loads the default kernel and initrd from /bo=
ot
> >>>>>
> >>>>> I am working on integrating fadump with existing kdump infrastr=
ucture. The
> >>>>> current kdump infrastructure builds a separate initrd (whenever=
 there is a
> >>>>> change detected in kdump config file /etc/kdump.conf) which the=
n gets loaded
> >>>>> into memory by kexec tool for use by kdump kernel. But, in the =
fadump approach,
> >>>>> the second kernel (after crash) always use the default (OS buil=
t) initramfs.
> >>>>> Hence, to support fadump, change is required to introduce dump =
capturing steps
> >>>>> in default initramfs itself. Hence the possible approaches I am=
 looking into
> >>>>> are:
> >>>>>
> >>>>> 1. Rebuild the default initramfs every time when there is a cha=
nge detected in
> >>>>> kdump config file (/etc/kdump.conf)
> >>>>>    This approach would modify existing initramfs in place. I di=
d work on this
> >>>>>    approach by enhancing mkdumprd (tool from kexec-tools packag=
e) to extract
> >>>>>    and rebuild default initramfs with dump capturing steps.  Af=
ter discussing
> >>>>>    with Vivek Goyal, he suggested that better approach to add c=
ode to dracut
> >>>>>    for rebuilding boot initramfs instead of enhancing mkdumprd.=
  This means
> >>>>>    introducing a new dracut module that will be responsible for=
 introducing
> >>>>>    dump capture steps inside the rebuilt initramfs by pulling r=
equired modules
> >>>>>    e.g. ssh, nfs etc. depending on /etc/kdump.conf
> >>>>>
> >>>>>    Now the question is whether it is possible for dracut to reb=
uild boot
> >>>>>    initramfs in place? if Yes, is there any issues in rebuildin=
g of boot
> >>>>>    initramfs everytime when there is a change in /etc/kdump.con=
f?
> >>>>
> >>>> dracut is called by /sbin/new-kernel-package. dracut is not a se=
rvice, which is
> >>>> run on every boot. So, no, dracut can't watch files and build an=
 initramfs on
> >>>> itsself.
> >>>>
> >>>
> >>> Normally user would restart kdump service after changing kdump co=
nfig
> >>> file. Idea is to invoke dracut through kdump service, as it alrea=
dy
> >>> watches and detect changes in kdump config files.
> >>>
> >>> I was wondering if dracut allow us to insert/install additional d=
racut
> >>> modules to already existing initramfs? OR does it rebuild initram=
fs all
> >>> over again?
> >>
> >> Sorry for restarting this discussion very late. I would like to kn=
ow how
> >> safe is to rebuild kernel's default (boot) initramfs for an alread=
y
> >> installed kernel ?
> >>
> >> Also, Does dracut provides any of following mechanism?
> >> a) Mechanism where dracut can detect what options were used during=
 first
> >> build for a given (exsisting) initramfs. (This mechanism may help =
one to
> >> regenerate similar initramfs with additional dracut modules.)
> >=20
> > currently dracut only stores which modules were used to generate th=
e image in
> > usr/lib/dracut/modules.txt
> >=20
> > But yes, you are right. Would be nice to save all the options and h=
ave a
> > mechanism to regenerate it with those.
> >=20
> >>
> >> OR
> >>
> >> b) Add additional modules to an existing initramfs instead of
> >> regenerating again. Is this possible at all?
> >=20
> > You can always generate a second cpio image with additional files a=
nd either
> > concatenate both images or specify those two images in the bootload=
er.
>=20
> Is it possible to specify two images to bootloader for a single kerne=
l
> entry? Does grub2 support it?
>=20


Yes, it does. You can use

initrd file1 file2 ...

And it will concatenate files. It aligns files on 4 bytes boundary, not
sure whether it can be a problem.

> >=20
> > OR
> >=20
> > unpack the initramfs, add the file, (maybe run depmod, if kernel dr=
iver added),
> > and repack.
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
