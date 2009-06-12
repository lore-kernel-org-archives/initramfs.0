From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] Multiple interfaces support and lots of cmdline
 parsing
Date: Fri, 12 Jun 2009 16:35:19 -0400
Message-ID: <4A32BC07.2040704@redhat.com>
References: <4A327030.1000803@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A327030.1000803-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

When you post this as a git repo, could you please include more 
descriptive changelogs on each commit?

dracut_install $(ls {/usr,}$LIBDIR/libnfsidmap*.so* 2>/dev/null )
dracut_install $(ls {/usr,}$LIBDIR/libnss*.so 2>/dev/null)
-dracut_install grep

instmods nfs sunrpc ipv6

some commits like [3/5] contain unrelated changes that turn out to be 
good, but they are not explained in the changelog.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
