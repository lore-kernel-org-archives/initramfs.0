From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: Netboot test suite: PXE instead of qemu -kernel?
Date: Wed, 24 Jun 2009 00:50:18 -0400
Message-ID: <1245819018.18861.3.camel@obelisk.thedillows.org>
References: <4A410CA4.8030506@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A410CA4.8030506-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-06-23 at 13:11 -0400, Warren Togami wrote:
> Why are we using -kernel and -initrd on the client-side qemu?  Wouldn't 
> testing PXE with the dhcp + tftp server on the server-side be more 
> realistic?

Yes, but I don't know that it buys us much other than giving us BOOTIF,
which we can test by adding it to the test command line. It slows down
the boot process, and means you have to have more software installed to
run the test suite -- a minor point, but something to consider.

> Additionally we could use -net tap* instead of -net socket, which would 
> allow brctl setfd of a large value like 20 seconds to simulate the link 
> delay in the test suite.

There is merit here, but I think we probably need to have a separate
test suite to check the ip= option parsing. I haven't thought much how
it should be done, other than it seems like we could use a pre-mount
hook to check the configuration without needing to actually mount a real
root.

If we have that test suite, then doing PXE boot or emulating BOOTIF=
seems like a good idea. And I'd rather add a 20+ second delay to one or
two tests here rather than every network root test we do.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
