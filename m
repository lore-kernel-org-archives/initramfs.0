From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 5 Jun 2009 11:58:32 -0400
Message-ID: <20090605155832.GH5107@nostromo.devel.redhat.com>
References: <4A2907E7.1080008@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A2907E7.1080008-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said: 
> cat and grep just bloat the initrd, this patch removes dependencies on them.

Are we really at a place where we're that worried about 100k? I'd
rather not have to implement all of coreutils in shell where needed.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
