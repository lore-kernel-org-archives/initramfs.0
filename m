From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 13:24:45 +0100
Message-ID: <49A3E70D.9050006@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>	 <49A301FF.2090303@redhat.com>  <49A3A924.9000003@bfh.ch> <1235474964.28090.53.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235474964.28090.53.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Victor Lowther wrote:
[snip]
>> Maybe even leave nfsroot-mounting to the kernel as long as that features 
>> remains in the tree.
> 
> That is impossible when using an initramfs.  Once the kernel notices an
> initramfs, finds /init on it and execs it, it is up to the initramfs to
> handle everything else.
Ah well, stupid me forgot that. sorry.

> 
>> I guess nbd and iscsi could go the same way like root=/dev/iscsi ...
> 
> It is as easy to handle it one way or the other in userspace.  I happen
> to think that overloading root= is easier to read, and prevents having
> to remember yet another *root parameter when someone invents an even
> more convoluted and crazy way to store a filesystem. :) 

hmmm... 'convoluted and crazy' ok you got me.

Question: Do you we want to agree on a specific scheme for setting root 
options? I'm thinking (for example) about having one initramfs for both 
nfsroot and nbdroot.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
