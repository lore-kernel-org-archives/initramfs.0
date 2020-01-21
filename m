From: Michael Stapelberg <michael+lkml-Ocq5V1Lzw0iVILNE37Xk8A@public.gmane.org>
Subject: distri: 20x faster initramfs (initrd) from scratch
Date: Tue, 21 Jan 2020 18:07:32 +0100
Message-ID: <CANnVG6nFsnvva+qoQHJF+YY6Y3q46-C6tA742fMAkZFB3QFubg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=UtoQfGRA0AGdny9h0SJNaWPDAj0+toUbAcHlKQRrk90=;
        b=tWsBMZY2KRAA0w9KCT5aWZEg+Jnse9KFp1eRQIvW7DsunpSAP8X6NiGnUGC41eU+qr
         SGDEwCaZx0uVInluQeA3aLL2t7+/LJdE2SbfIKlxPHydLz15o/jff1C9WKN1ZKHKJr6g
         93w+va/i8AvJeIS+oX5Y5aeb0epmxwcIlvZNkkgyVOAxQokHSiKaezVzv+OnlC/jjxJq
         C/flbmU1RzhV0abZbEROesPnb/f/WWiputtQYEVL4uRGOcebaCS0V/+kI08PMvEEDRgD
         42hM/Tgx1+3HDjggU0CzJNDxXYx/vFRnJN1XqPUdKhV8prAtd86Uon/Wqi391WvKjPya
         Ibew==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hey,

I just published a blog post about a custom proof-of-concept initramfs
generator (minitrd):

https://michael.stapelberg.ch/posts/2020-01-21-initramfs-from-scratch-golang/

This demonstrates that there is still a whole bunch of optimization
potential in existing initramfs generators such as dracut :)

Thanks,
Best regards,
Michael
