From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 12:38:28 -0400
Message-ID: <20090605163828.GA7041@nostromo.devel.redhat.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com> <E0B0F7E0-7880-4219-AE91-B7305665424D@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E0B0F7E0-7880-4219-AE91-B7305665424D-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
>> Are we really at a place where we're that worried about 100k? I'd
>> rather not have to implement all of coreutils in shell where needed.
>
> People have this crazy fetish with booting fast.

And implementing grep in shell makes it faster? It may be, but
that's certainly not a given. Moreover, I wouldn't be surprised
if eventually the udev rules or the initramfs will need something
that's not practical to do with 'while read foo'.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
