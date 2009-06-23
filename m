From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: NFS why root=nfs and root=nfs4?
Date: Tue, 23 Jun 2009 00:07:02 -0400
Message-ID: <4A4054E6.2090700@redhat.com>
References: <4A3FF836.6080208@redhat.com>	 <1245710475.13352.31.camel@obelisk.thedillows.org>	 <4A402CEF.4030506@redhat.com> <1245728880.13352.106.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245728880.13352.106.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/22/2009 11:48 PM, David Dillow wrote:
>> This is a difference in design philosophy.  We have a native syntax that
>> seems fully feature capable.  Allowing redundancy and variation in this
>> syntax can confuse people less technically savvy than us who follow
>> documentation and examples.
>
> The people that do "config by example" are going to find the old HOWTOs
> that discuss using nfsroot.txt syntax. A current search for "linux nfs
> root" returns the NFS-root mini-HOWTO (circa 1996) and
> Diskless-root-NFS-other-HOWTO (circa 2001) as the top two results. In
> fact 5 of the top 6 results refer to the nfsroot.txt syntax and the
> sixth one refers one to the NFS-root mini-HOWTO for the kernel command
> line setup.

Isn't arguing over this moot?  I already said this is a reasonable 
compromise because of the upstream kernel and initramfs-tools.

None of those other documents however will have root=nfs, root=nfs4 or 
root=/dev/nfs4 examples.  I object to more confusing variations like 
this redundant to the preferred, full featured native syntax.

> Or is this both of us arguing from our gut and we'll have to disagree
> until Harald lays down the law about syntactic support?
>

Harald was in favor of removing the three "shortcut" variations of 
Legacy nfsroot.txt.  He also said I could go ahead and eliminate the 
netroot= variations if I felt strongly about it.  I do hope he would 
make his own comments on this matter.

I will still push chopping either root= or netroot= NFS variations, but 
only after we see what Harald decides to do for DHCP root-path for 
remote block devices (his iscsi idea).

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
