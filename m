From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] unquote nbd port
Date: Sat, 25 Aug 2012 13:42:12 +0200
Message-ID: <CAKzfqkepaa87Q8aU5WsNi9TFCpka02eKOfCOaOZg80eOGa=ywA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=RRFinBhy/0k9fA7FJsdsTo2RU0N9AQHt3tmKIOWL+PM=;
        b=G+KYd2chOeGNvj40YJPmZoJCJTV7vRSBHBSZvCrlOW8w8LVrTGVJaCncKc4uu+Z6+e
         DN+Xp2BNHzCv3kloIPv1m/kiJs1kPi+Iju7OIWYBB+LzJxXaZN5kWx3R2Y61VNlGYOuz
         P9zGxnhNrDUjyZXQyXxOzfF3TH5zYD05GnXV+0F/Qy+qrq3X17M4tHE/rTFFe/tdLWIy
         /Vj9vXrRDEsYvmqmqWrnm+IiLkSky0oFth8hEyfveRNPv0Xu4JWht8Z2oAaPBBsMaWR3
         F3PHZW4pWJq/0dz2l81AZe3X0USrkHuOpq7cmUlgV7JIouqR4MYHrO7C86sJ5gjgaXv+
         HB7g==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Name based connects fail because of the quotes around the $nbdport.
For name based connects, the -N option also gets included. For
instance nbd-client 192.168.0.1 '-N ltsp' /dev/nbd0.
I believe the quotes are not necessary for actual port numbers.

--- modules.d/95nbd/nbdroot.sh.orig     2012-08-25 13:38:00.817059355 +0200
+++ modules.d/95nbd/nbdroot.sh  2012-08-25 13:38:21.532204861 +0200
@@ -95,7 +95,7 @@
     i=$(( $i + 1))
 done

-nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
+nbd-client $preopts "$nbdserver" $nbdport /dev/nbd0 $opts || exit 1

 # If we didn't get a root= on the command line, then we need to
 # add the udev rules for mounting the nbd0 device
