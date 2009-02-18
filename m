From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 12:56:08 -0300
Message-ID: <82ecf08e0902180756u2e007426vdd7116c03e72925e@mail.gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org>
	 <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r3TohC2wDWgp+P1ZiBrRb0FPuH5+W6mL4XcuHJv1kTw=;
        b=H8oG+i9SjgryYl4nCAwRsborQc5ZjnO4xEs2CTTVtFVmiyGQJswZjVL80531wx7gjf
         EoY2IfEwJmHqNQm00jRxvEjI8Beqr6qNSHimJLKqAyu+NR+rTLErrojPxII98F6b/bmD
         waVyC3/9cwnhVr4i9rS9noVd8el6vrVddjYHs=
In-Reply-To: <9594AD60-9303-4345-8FC6-B59FAA2C60EE-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

>
> You will also need to modify the dracut script to only source modules with
> the .sh extension, and make sure the $dracutmodules functionality still
> works as expected.

Well, the current match:

# source all our modules
for f in "$dsrc/modules"/*[^~]; do

Worked for reading the .sh files (but not only the .sh files, of course)

However, I'm not that familiar enough to bash to adapt this match to
only .sh files (I tried a couple of things)

-- 
-
Thiago Galesi
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
