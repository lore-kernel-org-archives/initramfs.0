From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut and multiple ISO's as loopback mounts
Date: Mon, 07 Oct 2013 10:35:45 +0200
Message-ID: <52527261.2030702@redhat.com>
References: <CALY6xnh8VJiR4KqUCpwm4D8xBCicJC6xM=13SvNOn72FBykDQw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALY6xnh8VJiR4KqUCpwm4D8xBCicJC6xM=13SvNOn72FBykDQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jon Stanley <jonstanley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/03/2013 03:51 PM, Jon Stanley wrote:
> I'm wanting to loopback mount MULTIPLE iso's that are embedded in the
> same initramfs - does dracut currently support this? The use case is
> that there is a base OS livecd that I'm embedding in an initramfs, and
> that works fine today.
> 
> However, on top of that, I want independently versioned additional
> content. For example, imagine shipping some ISV content on top of a
> generic LiveCD that you intend to PXE boot. The base OS need not
> change (and I don't want it to change or to rebuild it).


You would have to write such a dracut module on your own.

> 
> The commentary in the livecd-iso-to-pxeboot script (part of
> livecd-tools - https://git.fedorahosted.org/cgit/livecd/tree/tools/livecd-iso-to-pxeboot.sh)
> seems to indicate the kernel will DTRT with it - but will it still
> DTRT with multiple (3+) cpio archives?
> 

I think the kernel unpacks cpio archives as long as it finds one appended to the
last one.

> As a side question, how do you dissect a cpio archive like this? The
> standard cpio invocation seems to stop at the end of the first
> archive, which makes sense. How do you specify you want the nth
> archive out of a single file?

Yeah, someone has to write such a user tool. lsinitrd would benefit from it.
