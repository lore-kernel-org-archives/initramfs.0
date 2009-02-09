From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/31] Some dracut cleanups and bashification.
Date: Mon, 9 Feb 2009 12:15:21 -0500
Message-ID: <20090209171521.GA3646@redhat.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Feb 08, 2009 at 04:34:41PM -0800, Victor Lowther wrote:
 > Hi, I enjoy hacking on system infrastructure and am a bash programming 
 > aficionado. With that in mind, I present this patch series against current
 > master -- it simplifies several bits of code and shaves about 200 lines out
 > of the codebase.  The final result has been tested on a Fedora 10 box that
 > uses lvm on top of dm-crypt, and it works fine.  I have not tested all
 > intermediate steps -- life is too short.

The introduction of additional bashisms is something I'm not sold on.
Others have already expressed concern over what we have already,
so I think making it unnecessarily harder to switch to an alternative
shell may not be the best plan, especially when the benefits aren't
really that great.

Thanks for taking the time to get involved though, it's good to see
people actually playing with the code.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
