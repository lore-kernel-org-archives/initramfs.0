From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: ntpd to set clock prior to mount
Date: Fri, 15 Nov 2013 14:28:19 +0100
Message-ID: <l657h9$b13$1@ger.gmane.org>
References: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAF-o458j3=kA8FWMLzg9VSg-Pg5SrOjzPY4sN64U9kZv0i-j7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Rex Vaughn at 15/11/13 00:23 did gyre and gimble:
> I have a set of machines that don't have battery backups for the real
> time clock. when the power is cycled on these machines, the real time
> clock resets to the BIOS epoch time which is usually a year or two in
> the past.  Each time I boot, I get fsck failure because the superblock
> time is in the future.  I am aware of the e2fsck configuration file
> that I can put into /etc with the broken_clock option, however I
> still get log files that have the time set in the past.  Having
> invalid times in the log files can make debugging boot problems very
> problematic.

While I appreciate you don't have a question as such, I should really
point out that for e2fsck to complain like this is totally broken. It
should be fixed upstream so the config file is just a hack at best.
Relying on system clocks for any kind of mount check is just
fundamentally broken.

Anyway, back to the case in point, if debugging is your main problem
then systemd-journal is likely the best course of action. It will allow
you to present your logs in such a way that the timestamp is monotonic
from the boot time and thus has no relation to wall-clock time in any
shape or form.

This is much better for ordering or messages and such like.

Requiring ntp and thus working network links etc. seems vastly overkill
here if all you need is to sort out the time.

But if it works for you, then great! :)

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
