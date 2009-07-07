From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC ONLY 4/5] netroot: move dracut syntax validation to root
 handlers
Date: Tue, 7 Jul 2009 09:47:31 +0200
Message-ID: <4A52FD93.3000406@bfh.ch>
References: <cover.1246656269.git.dave@thedillows.org> <d1aed501ae771d769efcd370f47184f12b9800d6.1246656269.git.dave@thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d1aed501ae771d769efcd370f47184f12b9800d6.1246656269.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> This reduces the argument parsers in the cmdline hook to giving warnings
> about usage and translating legacy syntaxes to dracut's syntax. The root
> handlers themselves become responsible for validating the dracut syntax.
> This simplifies the cmdline parsers and centralizes the syntax parsers,
> which keeps them from multiplying as new functionality is added.

I don't think that centralizing code is that important. Dracut is
module based after all and the central point to find code is the module
directory. But reducing complexiting and eliminating duplicate code is
always good. And I like the approach of separating legacy cmdline
parseing and parsing dracut-style syntax.

But there's a two things about this approach that bug me:
- The netroot handlers become some sort of multi-call utilities, doing
  possibly entirely different things depending on arguments. From a
  functional point of view netroot handlers should only care about
  the actual mount/login.
- Arguments are constantly reparsed. This is unnecessary but applies to
  the current implementation as well

We need to refactor the netroot handlers, that is clear. Because only 
the netroot modules can give us a server IP for STP arping. And
second, you are correct that we should get rid of duplicate code in
the current implementation.

What hit me only after really reviewing your code is that the main reason
for duplicate code is that we are using the netroot argument as container 
for all parameters a netroot module needs. Hence the constant reparsing 
and splitting of that argument. 

In an object oriented language, I'd probably define an abstract
superclass which would define methods for the external interface and
concrete Implementations would have to provide. How the actual parameters
are stored internally I couldn't care less. While this isn't really
possible with shell code, a similar approach might simplify things 
even more.

Suggestion: We don't use the netroot argument inside netroot. Instead, the
different parsers should write out /tmp/netroot.info in a similar format
to net.ethX.override or dhclient.ethX.dhcpopts. Netroot modules would
have to provide three files: Legacy cmdline parser (optional),
dracut-syntax parser (for netroot= and dhcp root-path), mount/login handler.

This would work like this:
cmdline step 1: All legacy parsers run first, validating if necessary
                and/or reformat arguments into netroot= if possible
cmdline step 2: call proto-validate.sh which parses and validates
                dracut-syntax
==> After this step, if all parameters are correct and root!=dhcp,
    /tmp/netroot.info should be available.

netroot step 1: If root=dhcp do the same as cmdline step 2
==> After this step and if all parameters are correct /tmp/netroot.info
    should be available.

netroot step 2: Source /tmp/netroot.info and use "$server" for STP arping.
                If it's empty, issue a warning, use dhcp server and rewrite
                the file with the new server=.
netroot step 3: Just call the mount/login handler without any arguments.
                Everything it needs is in /tmp/netroot.info

What do you think?

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
