From: Adam Spragg <adam-2iSS7ArDF14@public.gmane.org>
Subject: Re: Thoughts on mounting the rootfs from a udev rule
Date: Sun, 22 Mar 2009 19:46:10 +0000
Message-ID: <49C69582.3040004@spra.gg>
References: <1237496785.5070.28.camel@sentry-no.fnordovax.org>	 <49C35EC6.2050405@bfh.ch> <1237541365.5070.64.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237541365.5070.64.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Victor Lowther wrote:
> If you mount an ext3 filesystem it replays the journal whether or not
> you mount it read-only.

According to the documentation patch at:

http://patchwork.kernel.org/patch/940/

you can mount ext3 as ro,noload which will not replay the journal.

Although those emails are dated Jan 2009, I'm not sure how old that actual
feature is, or what kernels it might be in.

Adam

-- 
The fundamental cause of the trouble is that in the modern world the
stupid are cocksure while the intelligent are full of doubt.
    -- Bertrand Russell
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
