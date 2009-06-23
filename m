From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: NFS why root=nfs and root=nfs4?
Date: Mon, 22 Jun 2009 21:16:31 -0400
Message-ID: <4A402CEF.4030506@redhat.com>
References: <4A3FF836.6080208@redhat.com> <1245710475.13352.31.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245710475.13352.31.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/22/2009 06:41 PM, David Dillow wrote:
> On Mon, 2009-06-22 at 17:31 -0400, Warren Togami wrote:
>> I just realized that the following are yet another NFS syntax variation.
>>
>>       client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
>>           "root=nfs" 192.168.50.1 -wsize=4096 || return 1
> [snip]
>> When is it ever necessary to use explicitly root=nfs or root=nfs4
>> instead of root=dhcp?  It seems functionally equivalent while
>> unnecessarily limiting since DHCP should tell you the protocol.
>
> Sigh. Let's have this conversation again.
>
> The kernel nfsroot support allows root=/dev/nfs to get the root path
> information from DHCP instead of nfsroot. We support that legacy syntax.
>
> root=nfs was a shortcut to root=/dev/nfs
> root=nfs4 was a shortcut to root=/dev/nfs4, which is something I made up
> when adding nfsroot support to dracut, as it seemed to have a certain
> symmetry with the kernel's support for NFSv3.

With all due respect, I was hesitant to suggest strongly on this earlier 
because it was against your opinion and you have been an important 
contributor to this project.  It is of my opinion that having too many 
ways of configuring the same behavior has too many drawbacks.  For 
brevity I will not restate the many reasons why the Legacy nfsroot.txt 
syntax is deprecated and it makes even less sense to invent additional 
shortcuts that immediately become deprecated as well.

It is a different story if a syntax variation exists because it is 
impossible to do something without it.

If I had it my way, I would advocate dropping Legacy entirely including 
the nfsroot.txt syntax and all netboot syntaxes supported (poorly) by 
mkinitrd.  However it seems that a reasonable compromise is to tolerate 
this particular legacy syntax because it is supported well by Debian's 
initramfs-tools.

>
> You were planning on removing root=nfs, root=nfs4, and root=/dev/nfs4,
> leaving only root=/dev/nfs for compatibility with the kernel, so the
> root=nfs tests would need to be converted to root=/dev/nfs and the rest
> would go away in that case.

I was uncertain about removal of cases that did not explicitly involve 
"nfsroot=", if it remained fully feature-wise capable after that.  I 
guess it does now.

>
>> Benefits of de-supporting these variations:
>> * Simplify the documentation further, fewer possible ways to configure
>> it to confuse people.
>
> Have a standard syntax section that only mentions the way we want to
> have people use the software, and have a Legacy (and possibly Expert)
> section that gives other ways that work, with a note that these are not
> the suggested/preferred ways.
>
> Am I missing something that makes this so hard? Or do I just have a
> kinder opinion of users than others around here?

This is a difference in design philosophy.  We have a native syntax that 
seems fully feature capable.  Allowing redundancy and variation in this 
syntax can confuse people less technically savvy than us who follow 
documentation and examples.

A strong argument against this is only if it can be pointed out that a 
feature is not capable under the native syntax.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
