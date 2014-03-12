From: glphvgacs <darwinskernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: cap on rootfs
Date: Wed, 12 Mar 2014 13:03:54 -0400
Message-ID: <20140312170354.GB609@034-mcl085.campus.mcgill.ca>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=zDljpBGbGMSlG1c5lGrnISg4yvELM70NoiIvRlxbYd0=;
        b=Ge2I84tytiMeQIjTlWpMz7tfPlxxNm/7TUJUHfQP7bvJLyc6rEtY5K7mvEhyyC7mMw
         CxMYnFX40JEd0JFC/zQ2NtQzMMTgHvvcRlT9/pn8ttWNBx4n+7EulbDlLLUA2w2Ucan4
         1oe2yOSz5tTfa3k5Fcl5tWgf8uEbiDH/fk1K2VMG+dR0l2K5Ewo2NhIycPImXq0oGDLq
         4luz3wxA7/bDZMBB49QjcZ8ZegELGQ5o1QOBv0mg1R84e6oxHaX2v1bChDKw8kyxqDCN
         5K+xEAfrBWZOHyJpl61GRQiTKXMWUEp4j6F0fIVU0xerqFVDINS91jVNNuESBpbjsiMB
         HvVQ==
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


one fstab "solution"?
tmpfs / tmpfs defaults,remount,noatime,size=90% 0 0
