From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Thu, 14 Nov 2013 08:10:13 +0000
Message-ID: <52848565.6020303@colin.guthr.ie>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>	<52830E31.30107@gmail.com>	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>	<5283AEA4.9050209@colin.guthr.ie>	<CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>	<5283B76B.8070902@colin.guthr.ie>	<CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>	<CAN_LGv08+8fmvqdz2afiuuET2cJLC9diGDMn6mtc904rdJGMog@mail.gmail.com>	<5283C886.10300@colin.guthr.ie> <CAN_LGv18zK37_35F23XG7SkhEMMat0VVOxv3yoNMXzG4nUCZNg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN_LGv18zK37_35F23XG7SkhEMMat0VVOxv3yoNMXzG4nUCZNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

'Twas brillig, and Alexander E. Patrakov at 13/11/13 19:02 did gyre and
gimble:
> 2013/11/14 Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>:
>> What kernel are you using out of interest?
> 
> This kernel is a git snapshot between 3.12.0-rc2 and -rc3. Compiled on Gentoo.

Thanks for that.

After trying harder, it seems my initial suspicion on the bug report was
correct after all and a missing host controller driver is the culprit.

For reference dracut is not including ohci-pci which I presume has been
split out recently and thus needs to be added explicitly.

Alexander's tests perhaps used a different type of USB host controller.

Will send a dracut patch shortly and sorry for the noise.

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
