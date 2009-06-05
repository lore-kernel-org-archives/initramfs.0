From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 05 Jun 2009 12:03:25 -0400
Message-ID: <4A2941CD.1070709@redhat.com>
References: <4A2907E7.1080008@bfh.ch> <20090605155832.GH5107@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090605155832.GH5107-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 11:58 AM, Bill Nottingham wrote:
> Seewer Philippe (philippe.seewer-omB+W0Dpw2o@public.gmane.org) said:
>> cat and grep just bloat the initrd, this patch removes dependencies on them.
>
> Are we really at a place where we're that worried about 100k? I'd
> rather not have to implement all of coreutils in shell where needed.
>

I'm not too happy about this, additionally because it made the code less 
readable.  But he already pushed it to git.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
