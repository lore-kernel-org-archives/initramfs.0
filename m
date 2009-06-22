From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: NFS why root=nfs and root=nfs4?
Date: Mon, 22 Jun 2009 18:41:15 -0400
Message-ID: <1245710475.13352.31.camel@obelisk.thedillows.org>
References: <4A3FF836.6080208@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3FF836.6080208-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-22 at 17:31 -0400, Warren Togami wrote:
> I just realized that the following are yet another NFS syntax variation.
> 
>      client_test "NFSv3 root=nfs DHCP path only" 52:54:00:12:34:00 \
>          "root=nfs" 192.168.50.1 -wsize=4096 || return 1
[snip]
> When is it ever necessary to use explicitly root=nfs or root=nfs4 
> instead of root=dhcp?  It seems functionally equivalent while 
> unnecessarily limiting since DHCP should tell you the protocol.

Sigh. Let's have this conversation again.

The kernel nfsroot support allows root=/dev/nfs to get the root path
information from DHCP instead of nfsroot. We support that legacy syntax.

root=nfs was a shortcut to root=/dev/nfs
root=nfs4 was a shortcut to root=/dev/nfs4, which is something I made up
when adding nfsroot support to dracut, as it seemed to have a certain
symmetry with the kernel's support for NFSv3.

You were planning on removing root=nfs, root=nfs4, and root=/dev/nfs4,
leaving only root=/dev/nfs for compatibility with the kernel, so the
root=nfs tests would need to be converted to root=/dev/nfs and the rest
would go away in that case.

> Benefits of de-supporting these variations:
> * Simplify the documentation further, fewer possible ways to configure 
> it to confuse people.

Have a standard syntax section that only mentions the way we want to
have people use the software, and have a Legacy (and possibly Expert)
section that gives other ways that work, with a note that these are not
the suggested/preferred ways.

Am I missing something that makes this so hard? Or do I just have a
kinder opinion of users than others around here?


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
