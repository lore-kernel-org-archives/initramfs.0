From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH 0/2] (dracut) hwdb needed in early boot for some keyboards
Date: Tue, 12 Nov 2013 11:42:29 +0100
Message-ID: <52820615.6060503@colin.guthr.ie>
References: <1384249140-20683-1-git-send-email-colin@mageia.org> <CAPXgP13EujKcEgsc_1N-_VbsYOdOw2jLZHHaxiRWQv1tL1ECcA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPXgP13EujKcEgsc_1N-_VbsYOdOw2jLZHHaxiRWQv1tL1ECcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kay Sievers <kay-tD+1rO4QERM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

'Twas brillig, and Kay Sievers at 12/11/13 11:28 did gyre and gimble:
> On Tue, Nov 12, 2013 at 10:38 AM, Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org> wrote:
>> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
>> unable to enter their encrypted root password via a wireless keyboard
>> connected with a Logitech, Inc. Unifying Receiver.
> 
> This sounds weird. Why exactly is this needed. The hwdb should be
> non-essential information only, and not be needed for basic operations
> or in the initrd.
> 
> If the basics of the keyboard aren't working properly, it might need a
> kernel fix.


Hmmm, OK I perhaps jumped the gun a bit on this one - lemme check with
the user first then to see if there is something else I'm missing.

Ultimately it seems that the usb hid module is not loaded in the initrd
but works fine later on. I initially presumed that host driver was not
included but it seems from feedback this is OK, but I'll probe deeper
before bugging you guys again :)

Cheers

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
