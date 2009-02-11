From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut and other distributions - an experiment
Date: Wed, 11 Feb 2009 13:36:15 -0200
Message-ID: <82ecf08e0902110736y5f75c6faod291e0368431ee33@mail.gmail.com>
References: <82ecf08e0902110439i1835b946p8491e809d17703fa@mail.gmail.com>
	 <20090211152705.GF15535@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3qJZ9h2faOr183AxyaLJE72uiHc0CS6bWrszwNS2Qf4=;
        b=BltvWYCfieE8Z7sm3pg59B10d5u/dbtvHkO4ZbmbEyA+By5bKWvpG0lPDu//ySLkAK
         6x/e1IB7zTSw59g0BvrxVbvV1xcg+xGJcJ4yWP2fO8mSvF7BRxkfsnZwu8FO7WSnMU3E
         ovFEX5ZldGCkaysIOu4PZKU7UjHtf/+PYfJPY=
In-Reply-To: <20090211152705.GF15535-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>
> The intent is that dependent libraries are copied - there's already
> code to do this. Apparently it's not working in your case?
>
> (Fixing this would fix most of your later concerns.)

I just found what's the problem: if there's no eu-readelf installed
there's no verbose error shown.

$ . ./dracut-functions
$ get_dso_deps $(which udevd)
$

Then, if it's installed...

$ get_dso_deps $(which udevd)
 /lib/libselinux.so.1 /lib/libc.so.6 /lib/libdl.so.2 /lib/ld-linux.so.2

-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
