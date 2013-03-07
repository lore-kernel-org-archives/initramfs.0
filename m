From: Brian Mearns <bmearns-EkmVulN54Sk@public.gmane.org>
Subject: Install a directory from dracut module
Date: Wed, 6 Mar 2013 21:51:07 -0500
Message-ID: <CABPDx51n7k8xUd2NeCe2OD5cBDPiG78YKmrJSvUPgS5gGnOwLg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=S7Ft8oWSfT0xlG4FeCst+ox1vAFkEipc1mtc6PcC0XU=;
        b=uwvorO7diyjiKRNIh695pegKC0Iadth3demqrrhRUKqKkNA1M14jF9V7jAJmIpHeDn
         iWnwbSauAhVTJoJel4ITEoyvD9yTfWHv7cej51PB5SBK0TjeJT6kXyBrcrK0pawqK+Un
         2aCcC1JjynvEPgt4319oZb0vD4K/OnYnyDGMkyBTO1V14S/Ka3fErZSLX1KADlv9DN/Q
         djg/ILKzaHZzbrVw+bzi2twVWYLe2Bm0XEgszG/pUpzHlMypK0HLiFQIhhKvL2s6r1tI
         CnNzLAB4Ckr5buVOy9eHwsk8ASPhJUON9DeQ41KSklw3UM2rRnDiJVSwpvfEOSzzSZ4k
         dD9g==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I want to recursively install a directory in the install() function of
my module: is there an inst function for that, or can anyone suggest
some shell script that will do it?

Thanks,
-Brian
