From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 23:07:12 +0100
Message-ID: <20090211220712.GC21052@nb.net.home>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Feb 11, 2009 at 03:46:38AM -0800, Victor Lowther wrote:
> +# parsing the output of ls is Bad, but until there is a better way...
> +read x x x x maj min x < <(ls -lH "$resume")

  read maj min < <(stat --format="%t %T" "$resume")

> +echo "${maj/,/}:$min"> /sys/power/resume

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
