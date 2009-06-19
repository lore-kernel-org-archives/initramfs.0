From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: OOM panics in the test suite
Date: Fri, 19 Jun 2009 16:53:08 -0400
Message-ID: <1245444788.19114.2.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Commit 3af5866 "use 128M for the test virtual machines instead of 512M"
now causes all of the test suites to panic with the OOM killer when run
under F10 -- 256M seems to work better.

Does it work for anyone under F11 or Debian?

Is there an objection to moving it to 256M instead?
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
