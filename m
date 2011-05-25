From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] new module - 98evm
Date: Wed, 25 May 2011 15:28:56 -0400
Message-ID: <1306351736.3184.54.camel@localhost.localdomain>
References: <1306243102.3231.14.camel@localhost.localdomain>
	 <201105251755.09520.roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201105251755.09520.roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Wed, 2011-05-25 at 17:55 +0200, Roberto Sassu wrote:
> Hi all
> 
> i think we should have two separate dracut modules: one for
> the loading of a trusted or an user key and another for the
> initialization of EVM, so that other modules which need to load
> an encrypted key will depend only on the former.
> 
> Roberto Sassu

Thanks, Roberto, for pointing this out.  There should also be another
module for removing the trusted key from the keyring, before pivoting
root.

thanks,

Mimi
