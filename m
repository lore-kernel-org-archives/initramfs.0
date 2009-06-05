From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 05 Jun 2009 18:46:36 +0200
Message-ID: <4A294BEC.2010107@redhat.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com> <E0B0F7E0-7880-4219-AE91-B7305665424D@gmail.com> <20090605163828.GA7041@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090605163828.GA7041-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 06:38 PM, Bill Nottingham wrote:
> Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said:
>>> Are we really at a place where we're that worried about 100k? I'd
>>> rather not have to implement all of coreutils in shell where needed.
>> People have this crazy fetish with booting fast.
>
> And implementing grep in shell makes it faster? It may be, but
> that's certainly not a given. Moreover, I wouldn't be surprised
> if eventually the udev rules or the initramfs will need something
> that's not practical to do with 'while read foo'.
>
> Bill


Please stop the discussion, this patch was not making things _that_ unreadable 
and is not _that_ bad.

Sure, if we have to do things in shell which really look ugly and we have a tool 
for it, better copy over the tool.

Now back to real work and real problems :)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
