From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] Add some predefined break points.
Date: Fri, 27 Feb 2009 11:15:43 -0600
Message-ID: <1235754943.6445.3.camel@sentry-no.fnordovax.org>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com>
	 <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther@gmail.com>
	 <Pine.LNX.4.64.0902261501070.2766@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=sgg/PxsGGJWI2appkt7RMpJjDQDqYsCY83GGH6kw3fM=;
        b=OBG5d84dmdVe8dl6zA8Td05475qUEQ6d+nX7cKr3xf3254U9/XRpgqyjkarQEMGPQ3
         AqWMy55U2F5idqSwdGa+nGAvu0L0MXk1oilYI2IS2WlYwS1ik0z8VKo4jK/lhmurr9DC
         FCJ3tnLlXq5lNpwnaenlLMqdJT55e0fTY/JrM=
In-Reply-To: <Pine.LNX.4.64.0902261501070.2766-qcrbbFV08EMdmw7VdWMmteH3J2bgQ+4lG9Ur7JDdleE@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-02-26 at 15:04 +0100, Bogdan Costescu wrote:
> On Wed, 25 Feb 2009, Victor Lowther wrote:
> 
> > +getarg 'break=pre-udev' && emergency_shell
> 
> I would like to suggest doing something different: look for the value 
> of the 'break' parameter at the very beginning and save it in a 
> variable such that it would be possible to modify it in the shell run 
> for the breakpoint to point to a later breakpoint - this way one can 
> do a gradual checking of the initramfs progress by going from one 
> breakpoint to the next.

Not a bad idea.  I will code something up for this.

> 
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
