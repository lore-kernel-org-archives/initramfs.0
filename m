From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: module deps / location
Date: Wed, 10 Jun 2009 21:00:22 +0100
Message-ID: <4A3010D6.6060300@tuffmail.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=oXAOgFGfcARCJFBNYDZqP5PzXTcOG//I3BJs4ByQ/Ds=;
        b=mDmP0+88xxw392VgeqmiV3ZvV9G9JUGPZ5cfBpffFN25hm365iToiF65ioKU9DB9Xu
         GTxVWPasRwVhp0yDymt88abFXa1F9vJoxTSpfzwEbfHSW5ugd53SqM/0PWFcuUhJatoV
         i0PUu3ibabarqgf5ZDlWvHYSrbZIX8PZa2TSA=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I have some comments on locatemodule() and resdeps() in dracut-functions.

resdeps() shouldn't need to loop to find all the module dependencies. 
"modprobe --show-depends" will show all the dependencies of a module,
both direct and indirect.

And in locatemodule(), I can't understand why it tries to continue if
the full path from "modprobe --showdepends" does not exist.  I would
expect it to just give up (and perhaps suggest re-running depmod),
rather than searching for the module in other locations.  Can anyone
give me a hint?

Thanks
Alan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
