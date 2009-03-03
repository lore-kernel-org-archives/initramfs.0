From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Porting dracut to Debian, some notes
Date: Tue, 3 Mar 2009 11:15:31 -0600
Message-ID: <16BBE534-59B2-4BEA-B453-F69720867486@gmail.com>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date;
        bh=F3+6RLmq/OP1Wm9ueSCeLldEUurAcUioNmQ8FliyNs4=;
        b=oxOoGJEfSMQl/hHUBQPuyHfC5dE/pziiWEJXY1N9+0mjplNtVzNhhXKFUALwSdp1Em
         dXMO90sFnUezve+9AJUwjsmuSBVvldWsAWDfhrjnXVwnFfPB3U7fz4bU4J9X3qzO+9SF
         KtXft/rqyzLw6jtOSF6Y5fyC49cMSTSDctJpE=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Debian does not base it's udev rules off of the "standard" ones in the  
udev package. We could handle this by coding debian-specific routines  
for grabbing udev rules, by importing rules from the udev project, or  
by hand-rolling our own rules. I am inclined towards the second option  
-- the less distro specific stuff we have to code, the better.

Depmod on debian does not create some files we need for instmods. We  
need to no longer rely on that redhat specific behaviour without  
making things too evil. I will post a patch that does this later on.


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
