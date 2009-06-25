From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFT PATCH] Delay netroot mounting by 1 second
Date: Wed, 24 Jun 2009 23:30:38 -0400
Message-ID: <1245900638.22064.24.camel@obelisk.thedillows.org>
References: <4A3B968C.5070600@bfh.ch>
	 <20090619144705.GD2514@nostromo.devel.redhat.com> <4A3BA5EA.3020202@bfh.ch>
	 <84DF1DC6-5F06-4D6D-91A4-56D996D229B1@gmail.com>
	 <1245428342.32104.3.camel@lap75545.ornl.gov> <4A3F37B8.7050902@suse.de>
	 <1245683450.3544.6.camel@obelisk.thedillows.org> <4A3FAE9E.5000201@bfh.ch>
	 <1245691069.3875.11.camel@lap75545.ornl.gov> <4A3FD1C5.30006@bfh.ch>
	 <1245704521.3875.31.camel@lap75545.ornl.gov> <4A4084D3.3060705@bfh.ch>
	 <1245773764.11486.21.camel@lap75545.ornl.gov>  <4A41CE20.5000809@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A41CE20.5000809-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, 2009-06-24 at 08:56 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> [snip]
> > I've been thinking about this a bit, and I'd like to split the duties up
> > a bit, as I'd like to know the server IPs needed for other reasons. My
> > proposed split is that legacy handling -- ie nfsroot=blah to
> > netroot=nfs:blah conversion -- is done as it is now, and have the root
> > handler do syntax validation and stop, spit out the server IP(s), and do
> > the mount, depending on options handed to it (--validate, --servers, and
> > no options, respectively).
> 
> Hmmm... just so that I understand you correctly. Are you proposing to 
> move the cmdline-parsers back into the root handlers and add arguments? 
> If not maybe you could a more detailed example of your idea?

Yes, something like that.

parse-nfsroot.sh, parse-nbdroot.sh, and parse-iscsiroot.sh would only
exist to convert legacy command line arguments to the
netroot={nfs,nbd,iscsi}: format. They would not validate the netroot=
format.

As part of the command line parsing, the appropriate handler would be
called for netroot to check its validity, such as:

/cmdline/98-check-netroot.sh:

if [ -n "$netroot" ]; then
    [ -e /sbin/${netroot%%:*}-root ] || die "No root handler for protocol ${netroot%%:*}"
    /sbin/${netroot%%:*}-root --validate "$netroot"
    case $? in
	0) rootok=1 ;; # All's good
	1) DHCPORSERVER=1 ;; # No server specified
	*) die "Invalid argument to root handler ${netroot%%:*}" ;;
    esac
fi

Checking the validity of the DHCP root-option becomes (modulo NFS legacy
support):

[ -e /sbin/${rootpath%%:*}-root ] || die "No root handler for protocol ${rootpath%%:*}"
/sbin/${rootpath%%:*}-root --validate "$rootpath" ||
	die "Invalid DHCP root-option for ${rootpath%%:*}"


Later, we can decide which IP to arping:

server=$(/sbin/${netroot%%:*}-root --server "$netroot")
destip=$gateway
is_ip_local $server $myip $netmask && destip=$server

while ! arping ... $server; do
    # count here to break out, etc.
    sleep 1
done


The variable names will likely change a bit, and the messages will need
to be massaged, but we have a need to decode the netroot= arguments
three times -- once for validation, once for extracting the server, and
once for the actual mounting. It makes sense to have the same parser for
all three uses. I think it would also clean things up to separate the
legacy handling from the supported mechanisms.

I haven't started coding this up; I wanted to try to get some consensus
first. NFSv4 would get its own handler, which I think makes sense --
I'll probably break it out into it's own module anyway.

> > The sourced scripts could just call into their handler to do the final
> > validation, and netroot would get rid of its loop as it can call the
> > handler directly since it has the protocol field.
> 
> Uhhh... which loop are you talking about?

/sbin/netroot:
# Source netroot hooks before we start the handler
source_all netroot

That would become the validity check above.

> > The only issue is handling the legacy NFS root-path options, everything
> > else is expected to have nfs:/nfs4:/nbd:/iscsi: or what not. I don't
> > think it would be the end of the world if the that handling lived in
> > netroot itself, as it will be the only root-path legacy handler we have.
> 
> If possible, netroot should remain as generic as possible. You never 
> know what the future holds.

As a general design principle, I tend to agree with you. However, the
only root-path we support that doesn't match the form protocol:arguments
is the [serverip:]/path syntax of NFS. I think it makes sense to either
pull that into netroot.

Of course, I just thought of an alternative solution -- maybe we could
pass both netroot and root-path in to the root handler, and it can do
the right thing. The initial cmdline parse would pass in "" for
root-path, or perhaps find another way to indicate we don't have the
root-path yet.

It's a wart, but I think we can get it cleaned up.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
