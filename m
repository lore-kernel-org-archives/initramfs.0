From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: wiki, README and TODO update
Date: Thu, 14 May 2009 20:32:25 -0500
Message-ID: <1242351147.29452.2.camel@sentry-no.us.dell.com>
References: <4A098CB5.2070006@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=zYYhdqFFt/SeroZFWeEy87fVwOdynQ6hsBVgFRZ5lCs=;
        b=DKKg07dtlI9Mwn4RismO4CxGupGJ3eMFxlUw6PF1JSyNQQ5P0hwaFqYsPo851xYiZb
         OZMxTNPSKz1n0wOxCyvJcnzCQtQfyfIpDv0NbToegQSH1J/BEhE94Wg3lzVledJUq4bm
         DBEIzQAkhzSYgJ7F4cmCoS/BqX+LngNQ14/II=
In-Reply-To: <4A098CB5.2070006-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, 2009-05-12 at 16:50 +0200, Harald Hoyer wrote:
> Today I updated http://apps.sourceforge.net/trac/dracut/ and the package README and TODO files.
> The next days, I will add iSCSI support and test various network setups.

Cool.  I ahve been working on some test suite improvements (lvm on
cryptroot on software raid5), and am working on making dracut actually
work in that configuration.  I will post patches to the mailing list
once it works without manual hackery.

Next stop, all that over iscsi.  Should be fun.

-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
