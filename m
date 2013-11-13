From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 16:53:56 +0000
Message-ID: <5283AEA4.9050209@colin.guthr.ie>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>	<52830E31.30107@gmail.com> <CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

'Twas brillig, and Alexander E. Patrakov at 13/11/13 16:49 did gyre and
gimble:
> 2013/11/13 Alexander E. Patrakov <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Colin Guthrie wrote:
>>>
>>> Hi,
>>>
>>> In this bug report https://bugs.mageia.org/show_bug.cgi?id=11645 a user is
>>> unable to enter their encrypted root password via a wireless keyboard
>>> connected with a Logitech, Inc. Unifying Receiver.
>>
>>
>> Just in case, I do have the same model of wireless keyboard and will
>> validate the bug (for the LUKS-password case) later today on my laptop.
>>
>> The keyboard does work on my desktop, but there's no initramfs there.
> 
> I hereby confirm that the wireless Logitech keyboard works for
> entering the LUKS password on the laptop, if one does not create a
> host-only initramfs. This is with dracut-031.


thanks for that. If it's easy enough for you to test, does it also work
with a host-only initrd?

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
