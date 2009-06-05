From: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Don't use absolute path for ip, does not always work
Date: Fri, 5 Jun 2009 13:27:27 -0400
Message-ID: <20090605172727.GB7539@nostromo.devel.redhat.com>
References: <4A292D53.9080603@bfh.ch> <20090605155900.GI5107@nostromo.devel.redhat.com> <3EFC8CBF-4F49-4713-9F04-D17977415107@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EFC8CBF-4F49-4713-9F04-D17977415107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Victor Lowther (victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) said: 
>> Why does it not always work, unless you're breaking your initramfs?
>
> What if your distro does not put ip in /sbin?

I was under the impression that the generation already put it in
a known place, in which case there's no reason to worry about it
being elsewhere. I checked again, and that's not the case.

Bill
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
