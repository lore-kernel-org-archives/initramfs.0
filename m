From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Mon, 22 Jun 2009 18:29:17 -0400
Message-ID: <1245709757.13352.20.camel@obelisk.thedillows.org>
References: <4A39A9AF.6070009@redhat.com> <4A3A13A8.6050100@bfh.ch>
	 <4A3FEFE7.7080907@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3FEFE7.7080907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-22 at 16:56 -0400, Warren Togami wrote:
> On 06/18/2009 06:15 AM, Seewer Philippe wrote:
> >> 2) Harald and I think we should cut Group B. The netroot= syntax is
> >> necessary only for remote block device protocols like iscsci and nbd
> >> when you want to use LVM or crypto on those block devices. For NFS it
> >> is only redundant.
> >
> > Reduntant: Yes. But it keeps the argument scheme consistent. And dracut
> > is allowed to introduce new syntaxes if they make sense.
> 
> root= and netroot= redundant syntaxes with redundant tests make sense how?

The redundant tests could be removed yes, but they are currently
redundant solely because they try to not make any assumptions about the
implementation.

> * netroot= NFS variation adds to confusion understanding the 
> documentation and examples.

I don't see this, but perhaps I'm too close to it. To me it would make
more sense to say that netroot= is the proper way to get a NFS root or
network device for root, and root=dhcp/root=nfs/root=nbd/root=iscsi etc
are the legacy ways.

> * Complaints about the tests taking too long?  Remove all the redundant 
> tests that do identical root= and netroot=.

Sure, but you open up possibilities of missing unintended changes when
you make assumptions in the test code.

> * Separate netroot= only exists for remote block devices, useless for NFS.

Maybe, in your definition. But since all of the network root code
translates existing root sources requiring the network into a netroot=
argument, it would actually take more code to remove support for
netroot=nfs:... than it takes to support it.

> >> 3) I personally think we should cut the "nfs:" prefixed syntaxes from
> >> Group A, B and C because they have no precedent and we're better off
> >> with fewer variations. Others have disagreed though.
> 
> Alternatively, how do people feel about removing the NFS syntax that is 
> missing the nfs: prefix?  It was poorly supported (did not support 
> nfs-options) in mkinitrd, lacked DHCP support, and non-existent in 
> Debian's initramfs-tools.

> 3) Support it but print deprecation warnings like Legacy nfsroot.txt.

This would be my choice; the DHCP (BOOTP) root-path=[server:]/root-path
formats have been around for decades. I seem to recall network booting a
SunOS 4.1.2 box using that back in 1993, and I'll bet it wasn't a new
feature then.

Some changes I'm thinking about would benefit from dropping the non nfs:
formats, as they wouldn't have a clean home otherwise, but I don't think
that is a good reason to drop them -- they are too easy to support.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
