From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] 95fstab-sys: use det_fs and wrap_fsck
Date: Wed, 25 May 2011 15:16:46 +0200
Message-ID: <4DDD013E.9000207@gmail.com>
References: <1305904167-14199-1-git-send-email-soltys@ziu.info> <1305904167-14199-4-git-send-email-soltys@ziu.info> <20110523230507.GC2659@nb.net.home> <4DDC1A05.9030400@ziu.info> <20110524223936.GG2659@nb.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GDRKBUrXL4J8dWguAbg30sbmMdXcTWCHldRQMKyZYYE=;
        b=rytr2/4UM5ktRT7+gwgTyOxNWqV0OgKNE+fKMENPHaFJVKOc9bt4sXxlDd58/YjTs0
         EiTK5h0466kQV80IY6UeErfaWfy6Fk+fPhOAC8TkSDmqPH/T+qJndSljSCTxjXHnnAVo
         RRcQaHf1quKGynGem1C9ulKRrTFcvw7gWGmPw=
In-Reply-To: <20110524223936.GG2659-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 25.05.2011 00:39, schrieb Karel Zak:
>   Unfortunately mount(8) does not allow to read info about mountpoints
>   from alternative fstab file and it does not support --target-prefix
>   now.  I'll add this to my TODO list.
>
>      Karel
>

That would be really cool! Thank you!
