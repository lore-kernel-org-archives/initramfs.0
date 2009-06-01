From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 01 Jun 2009 09:50:03 -0400
Message-ID: <1243864203.3844.136.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org>
	 <1243848391.647.13.camel@sentry-no.fnordovax.org>
	 <1243853668.3844.117.camel@obelisk.thedillows.org>
	 <20090601125908.GB4160@newmaster.mivlgu.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090601125908.GB4160-TEYkr/UGJhVKdHEj4xO92LjjLBE8jN/0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 16:59 +0400, Sergey Vlasov wrote:
> On Mon, Jun 01, 2009 at 06:54:28AM -0400, David Dillow wrote:
> > vim on F10 has different rules for sh and bash -- things like $() and
> > ${t%%:*} are lit in red for sh, but they are valid; they don't highlight
> > that way if vim sees #!/bin/bash
> 
> Add "let g:is_posix = 1" to your .vimrc (see :help ft-sh-syntax for
> other possible settings).

Thanks for the tip, that works nicely.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
