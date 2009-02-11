From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Dracut and other distributions - an experiment
Date: Wed, 11 Feb 2009 10:27:06 -0500
Message-ID: <20090211152705.GF15535@nostromo.devel.redhat.com>
References: <82ecf08e0902110439i1835b946p8491e809d17703fa@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <82ecf08e0902110439i1835b946p8491e809d17703fa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thiago Galesi (thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
> - Some distros use switch_root, others pivot_root (and this has to be
> copied from somewhere when generating, unless dracut comes with its
> own set of tools)
> 
> I guess the best solution would be to import a switch_root.c to dracut
> and bundle that (like it was suggested somewhere else)

The plan is for this to be part of util-linux in the future.

> - Tools that are copied from the fs, like $exe, $debugexe, the problem
> there is libraries... Ok, some distros offer
> /usr/lib/klibc/bin/sh.shared, a bash that doesn't depend on any
> libraries, but running bash per se (and other things like ls) in the
> emergency console was not possible for the time being

The intent is that dependent libraries are copied - there's already
code to do this. Apparently it's not working in your case?

(Fixing this would fix most of your later concerns.)

> - udev rules are located in /etc/udev/rules.d/
> 
> Maybe detect its location and copy everything / copy files from
> dracut.conf ?? (more of that later)

System udev rules go in /lib/udev/rules.d as of udev-125.

> - The tiny shell I used (sh.shared) barfed on  "label=${l//\//\\x2f}"
> where it checks LABEL= for root

Yes, that's a bash-ism.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
