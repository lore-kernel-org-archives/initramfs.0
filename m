From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC PATCH 4/9] cmdline: cleanup handling and block: handler
Date: Mon, 01 Jun 2009 07:15:52 -0400
Message-ID: <1243854952.3844.134.camel@obelisk.thedillows.org>
References: <cover.1243833882.git.dave@thedillows.org>
	 <d15c7a1ab71af9ab4fccd51fa02915e949f39c86.1243833882.git.dave@thedillows.org>
	 <1243848391.647.13.camel@sentry-no.fnordovax.org>
	 <1243853668.3844.117.camel@obelisk.thedillows.org>
	 <1243854157.647.22.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243854157.647.22.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2009-06-01 at 06:02 -0500, Victor Lowther wrote:
> On Mon, 2009-06-01 at 06:54 -0400, David Dillow wrote:
> > On Mon, 2009-06-01 at 04:26 -0500, Victor Lowther wrote:
> > > Which editor are you using that highlights bash but not sh correctly?
> > 
> > vim on F10 has different rules for sh and bash -- things like $() and
> > ${t%%:*} are lit in red for sh, but they are valid; they don't highlight
> > that way if vim sees #!/bin/bash
> 
> Ah, that explains it. I am a fan of the OS with an editor tacked onto
> the side.

So, ditch the whole shebang at the top? No #!/bin/sh or #!/bin/bash?

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
