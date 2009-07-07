From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC ONLY 4/5] netroot: move dracut syntax validation to root
 handlers
Date: Tue, 07 Jul 2009 10:57:28 -0400
Message-ID: <1246978648.22613.18.camel@obelisk.thedillows.org>
References: <cover.1246656269.git.dave@thedillows.org>
	 <d1aed501ae771d769efcd370f47184f12b9800d6.1246656269.git.dave@thedillows.org>
	 <4A52FD93.3000406@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A52FD93.3000406-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-07-07 at 09:47 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > This reduces the argument parsers in the cmdline hook to giving warnings
> > about usage and translating legacy syntaxes to dracut's syntax. The root
> > handlers themselves become responsible for validating the dracut syntax.
> > This simplifies the cmdline parsers and centralizes the syntax parsers,
> > which keeps them from multiplying as new functionality is added.
> 
> I don't think that centralizing code is that important. Dracut is
> module based after all and the central point to find code is the module
> directory. 

I'd rather centralize code into a single file as long as it doesn't get
too big -- and our scripts are no where close to that limit. When making
changes -- or just trying to understand how things work -- it is really
annoying to have to have umpteen different files open just to trace the
flow.

> But there's a two things about this approach that bug me:
> - The netroot handlers become some sort of multi-call utilities, doing
>   possibly entirely different things depending on arguments. From a
>   functional point of view netroot handlers should only care about
>   the actual mount/login.

I'm OK with the multicall handler, obviously. :) I like that all of the
knowledge about a protocol (modulo legacies) is in one file, and the
code to mount/login is usually a small portion of it -- the bulk is the
parsing.

> - Arguments are constantly reparsed. This is unnecessary but applies to
>   the current implementation as well

This doesn't bug me very much, as we're talking milliseconds. And the
alternative is yet more files.

> Suggestion: We don't use the netroot argument inside netroot. Instead, the
> different parsers should write out /tmp/netroot.info in a similar format
> to net.ethX.override or dhclient.ethX.dhcpopts. Netroot modules would
> have to provide three files: Legacy cmdline parser (optional),
> dracut-syntax parser (for netroot= and dhcp root-path), mount/login handler.
> 
> This would work like this:
> cmdline step 1: All legacy parsers run first, validating if necessary
>                 and/or reformat arguments into netroot= if possible
> cmdline step 2: call proto-validate.sh which parses and validates
>                 dracut-syntax
> ==> After this step, if all parameters are correct and root!=dhcp,
>     /tmp/netroot.info should be available.

Minor nit: Unless you're doing NFS and getting info from root-path, or
any netroot handler that supports defaulting the server the DHCP
server-id.

> netroot step 1: If root=dhcp do the same as cmdline step 2
> ==> After this step and if all parameters are correct /tmp/netroot.info
>     should be available.

Minor nit: you have to re-run it for the same reasons above.

> netroot step 2: Source /tmp/netroot.info and use "$server" for STP arping.
>                 If it's empty, issue a warning, use dhcp server and rewrite
>                 the file with the new server=.

Minor nit: you have to fall back to the default gateway if server isn't
available.

> netroot step 3: Just call the mount/login handler without any arguments.
>                 Everything it needs is in /tmp/netroot.info
> 
> What do you think?

It would work, but it isn't my preferred method due to spreading the
knowledge of a protocol over multiple files. I like the idea of making
the cmdline parsers only do legacy rather than the legacy + warnings and
invoke the netroot handler, but there may be some gothcas there that
make things uglier. I'd have to think about that.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
