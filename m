From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 05 Jun 2009 12:51:55 -0400
Message-ID: <1244220715.6963.11.camel@lap75545.ornl.gov>
References: <4A2907E7.1080008@bfh.ch>
 <20090605155832.GH5107@nostromo.devel.redhat.com>
 <E0B0F7E0-7880-4219-AE91-B7305665424D@gmail.com>
 <20090605163828.GA7041@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20090605163828.GA7041-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2009-06-05 at 12:38 -0400, Bill Nottingham wrote:
> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
> >> Are we really at a place where we're that worried about 100k? I'd
> >> rather not have to implement all of coreutils in shell where needed.
> >
> > People have this crazy fetish with booting fast.
> 
> And implementing grep in shell makes it faster? It may be, but
> that's certainly not a given. Moreover, I wouldn't be surprised
> if eventually the udev rules or the initramfs will need something
> that's not practical to do with 'while read foo'.

Implementing it in shell isn't a huge speed change either way I'll wager
-- well, maybe with fork + exec costs -- but when you have 200+ clients
boot and pull the initramfs at the same time, smaller is better.

Granted, 100k savings here isn't much, but small savings add up. The big
gains will be from fixing up all the extra modules we load into the
image...
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
