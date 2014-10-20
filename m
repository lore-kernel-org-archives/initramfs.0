From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: qestions about mdraid module
Date: Mon, 20 Oct 2014 13:02:55 +0200
Message-ID: <5444EBDF.7090004@redhat.com>
References: <5426D606.6020300@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5426D606.6020300-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Francis Moreau <francis.moro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 27.09.2014 17:21, Francis Moreau wrote:
> Hello,
> 
> I'm looking at the module 'mdraid' of dracut (0.38) and was wondering
> the purpose of rd.md.uuid= parameter.
> 
> I understand it can be used to selectively activate the array matching
> the UUID passed through the parameter but I'm wondering in which cases
> it can be useful...
> 
> Also I don't really understand why dracut try to do its own mechanism to
> achieve that (by providing its own udev rules which are modified at boot
> time) whereas mdadm already provide the infrastructure (through
> mdadm.conf) in a cleaner way (IMHO).


If mdadm.conf is not included in the initramfs, you want to have a way to
prevent automatic assembly of all raids found. With big machines, lots of disk,
you only want to assemble those, which you really need.

> 
> Another question, hopefully you don't mind: dracut provide an udev set
> of rules in a file named 59-persistent-storage-md.rules. I still don't
> really see the point since most of the stuff in it seems to already be
> done by the rule fileudev-md-raid-arrays.rules, shipped by mdadm (3.3.2).

That wasn't always the case in all distributions. Nowadays can probably be removed.

> 
> Ah my last question not related to mdraid: why dracut uses stderr to
> print out all its messages: info, debug, error. Stderr is usually used
> for error/warning messages only.
> 
> Thanks !

Hmm, not true.

    warn() {
        echo "Warning: $*" >&2
    }

    info() {
        echo "$*"
    }


see.. warn() goes to error, info() to stdout.

This is in the initramfs, though.
Or do you mean dracut the tool?
