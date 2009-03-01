From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: [PATCH 4/4] Add some predefined break points.
Date: Sun, 1 Mar 2009 16:07:33 +0100
Message-ID: <20090301150733.GA12608@stro.at>
References: <40b7db44cbcb49b1fb50445d786cd4851adba14a.1235615253.git.victor.lowther@gmail.com> <43ca8d3a8aed54367069b23fc43720cbf5517ec0.1235615253.git.victor.lowther@gmail.com> <Pine.LNX.4.64.0902261501070.2766@kenzo.iwr.uni-heidelberg.de> <1235754943.6445.3.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1235754943.6445.3.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 27 Feb 2009, Victor Lowther wrote:

> On Thu, 2009-02-26 at 15:04 +0100, Bogdan Costescu wrote:
> > On Wed, 25 Feb 2009, Victor Lowther wrote:
> > 
> > > +getarg 'break=pre-udev' && emergency_shell
> > 
> > I would like to suggest doing something different: look for the value 
> > of the 'break' parameter at the very beginning and save it in a 
> > variable such that it would be possible to modify it in the shell run 
> > for the breakpoint to point to a later breakpoint - this way one can 
> > do a gradual checking of the initramfs progress by going from one 
> > breakpoint to the next.
> 
> Not a bad idea.  I will code something up for this.

right as this is initramfs-tools inspired, we use a variable
and have those predefined breakpoints:
(top, modules, premount, mount, mountroot, bottom, init).

-- 
maks

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
