From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: Dracut and other distributions - an experiment
Date: Wed, 11 Feb 2009 16:33:06 +0100
Message-ID: <20090211153306.GB1927@baikonur.stro.at>
References: <82ecf08e0902110439i1835b946p8491e809d17703fa@mail.gmail.com> <20090211152705.GF15535@nostromo.devel.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090211152705.GF15535-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 11, 2009 at 10:27:06AM -0500, Bill Nottingham wrote:
> Thiago Galesi (thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
> > - Some distros use switch_root, others pivot_root (and this has to be
> > copied from somewhere when generating, unless dracut comes with its
> > own set of tools)
> > 
> > I guess the best solution would be to import a switch_root.c to dracut
> > and bundle that (like it was suggested somewhere else)
> 
> The plan is for this to be part of util-linux in the future.
 

run-init.c from klibc-utils does the job.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
