From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 13 NFS syntax variations
Date: Mon, 22 Jun 2009 21:24:21 -0400
Message-ID: <4A402EC5.7000906@redhat.com>
References: <4A39A9AF.6070009@redhat.com> <4A3A13A8.6050100@bfh.ch>	 <4A3FEFE7.7080907@redhat.com> <1245709757.13352.20.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245709757.13352.20.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/22/2009 06:29 PM, David Dillow wrote:
>> * netroot= NFS variation adds to confusion understanding the
>> documentation and examples.
>
> I don't see this, but perhaps I'm too close to it. To me it would make
> more sense to say that netroot= is the proper way to get a NFS root or
> network device for root, and root=dhcp/root=nfs/root=nbd/root=iscsi etc
> are the legacy ways.

I'm willing to consider dropping root=* and supporting only netroot= for 
NFS.

OTOH, Harald was thinking about extending the iscsi root-path syntax 
specification to allow for specifying the root device (by partition 
name, LABEL, UUID, etc.) within the root-path itself.  This might 
eliminate the need for a separate root=.

There may however be value in allowing an optional separate root=.  This 
might allow a mechanism for a bootloader menu to select a different root 
device during netboot.

Harald have you put further thought into the iscsi root-path syntax 
extension?

>> 3) Support it but print deprecation warnings like Legacy nfsroot.txt.
>
> This would be my choice; the DHCP (BOOTP) root-path=[server:]/root-path
> formats have been around for decades. I seem to recall network booting a
> SunOS 4.1.2 box using that back in 1993, and I'll bet it wasn't a new
> feature then.
>
> Some changes I'm thinking about would benefit from dropping the non nfs:
> formats, as they wouldn't have a clean home otherwise, but I don't think
> that is a good reason to drop them -- they are too easy to support.

"Too easy to support" does not necessarily mean we should support.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
