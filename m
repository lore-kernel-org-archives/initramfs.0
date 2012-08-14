From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: Getting "Cannot resume from device" (or something along these)
 lines with dracut and add_device+="LABEL=sf_unix_swap"
Date: Tue, 14 Aug 2012 23:05:01 +0100
Message-ID: <k0ei2d$g3h$1@dough.gmane.org>
References: <CAAsq1beH8qcf5CpyvBeG+1EFEyBKY9WKq79wjSsJT9MHkrD_4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAsq1beH8qcf5CpyvBeG+1EFEyBKY9WKq79wjSsJT9MHkrD_4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Shlomi Fish at 11/08/12 10:06 did gyre and gimble:
> Hi all,
> 
> I'm using Mageia Linux 3/Cauldron and have this in my dracut configuration:

The add_device stuff is a Mageia specific patch added rather late in the
development cycle. I did discuss the reasons for it (to act as a system
to enable LVM/RAID for swap partitions) with Harald and we came up with
a better suggestion but due to the timing I didn't have time to
implement it.

Anyway, this question isn't really relevant for upstream but I'll try
anyway.

> <<<
> [root@telaviv1 ~]# cat /etc/dracut.conf.d/51-mageia-resume.conf
> add_device+="LABEL=sf_unix_swap"
> [root@telaviv1 ~]#
>>>>
> 
> Now, at startup, I am getting (after waiting for several seconds) a
> message such as "Cannot resume from device" or
> "resume device not found" and then it boots normally.  My questions are:
> 
> 1. The label is valid. Can I use a label for the resume device?

It should work.

> 2. If not, can I use a UUID instead?

UUIDs should work also.

> 3. If I cannot use a label, then the man page of dracut should be
> fixed because -add-device does not mention anything  about not being
> able to use a LABEL (which is possible in e.g: /etc/fstab ).

Again, this is all a Mageia patch for now, which likely won't go
upstream (unless anyone else has a need for such behaviour?).

For reference the patch is here:
http://svnweb.mageia.org/packages/cauldron/dracut/current/SOURCES/0505-Add-a-new-add-device-option.patch?revision=278450&view=markup

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
