From: Alexander Perepelica <perepelica.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Using initqueue
Date: Tue, 5 Aug 2014 14:44:39 +0300
Message-ID: <CAAXZ8mfWJ4OgmsO4dS74sPiDbiUJgnVk9i8-MNsKC=KQNU751A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=L4Nryh8oaEL8sKk5SIj/2Yl7Fvgc8AdkFTzQekkNt7E=;
        b=Iksmvg9SyTfUNCvnN01DwecDLK/oZ8IE7WhexvEjcNzUizVtnsHykyQ0k/HODlqkr+
         Ss4WemIvjdj6bjlt4/FQCvbgWSf3emxnth/ifXno0CP/UFX3Jm9eadmOAsca4YYI6tgw
         2AtW2DXQNB7KHkGzjzdwqiJ//+QD+WPCzbiRDiNX9yOSg8sJ17yZXGAEXqixCJHsONXv
         EvntCGCl9FV0dDZvAfJHBYxgA8WrANAB1S76l1g5dBVtPxsNLaCF3DL8REYLx0oWdIml
         H7A6nqTsTUWsYSTM++e26x5ScaJbN+OjY+Ek020vzvUdgHNeMjY0Ejn1vwUEkZ8fYGDb
         ew1A==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi!
I try create my module for dracut and in module-genrules.sh call
  /sbin/initqueue --settled --onetime --unique /sbin/overlayfs-root
"{root@live:}"
But in log I don't see executing overlayfs-root.sh.
What do i wrong?
Regards,
Alex
