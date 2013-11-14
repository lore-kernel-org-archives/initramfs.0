From: Rex Vaughn <rvaughn-6nyMWi6rSIjR7s880joybQ@public.gmane.org>
Subject: ntpd to set clock prior to mount
Date: Thu, 14 Nov 2013 18:23:40 -0500
Message-ID: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=oGQMy0sCnMwjactna5sFmN932sVM/JC2F4+gLHABEDs=;
        b=rZDkyW9dYBTxj6xaOqWToN2J3L0z9IVGoY/oo9z7jvq4vkj/UsZnvv1CdY0LjH6qma
         PBfWKo59T1iPlebDwcczNnHmIY+1UrJ61AJZCdEmDbhjs7xeas01o5xfE6FxIwM9t5Hm
         JJl8Kv61YEsaszm9QQuiY8G19jrbdObYs+HGr5kHjG51Jg7MA2PzVe4lr8zNvAMUTVPP
         sfUwzNcuf4yb3XorJkbSRwUFCqJlUJXiSrcMYfNbY97BKwIZvfPfqmqAEUswk4IUXKIR
         RVQrTb14Ba8soaXMdPwOVY4TMrEgL6MxM6Ju487inTGqpow4kkDIRdYY+6kPyihHjLyz
         ai5w==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I have a set of machines that don't have battery backups for the real
time clock. when the power is cycled on these machines, the real time
clock resets to the BIOS epoch time which is usually a year or two in
the past.  Each time I boot, I get fsck failure because the superblock
time is in the future.  I am aware of the e2fsck configuration file
that I can put into /etc with the broken_clock option, however I
still get log files that have the time set in the past.  Having
invalid times in the log files can make debugging boot problems very
problematic.

I have hacked together a dracut ntpd module that will set the time but
it requires modifications to the network module to turn on the network
even when netroot is not set.

I guess I don't really have a question because what I have done seems
to work, but I was wondering what others think of this to see if it
might be a worthwhile addition to dracut or if I should just keep
going with my hacked version.
