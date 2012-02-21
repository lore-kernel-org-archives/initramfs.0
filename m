From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [systemd-devel] [Linux-ima-user] [PATCH 2/2] main: added support
 for loading IMA custom policies
Date: Tue, 21 Feb 2012 14:07:02 +0000
Message-ID: <ji08e6$8kc$1@dough.gmane.org>
References: <4F3BDCAA.7040001@polito.it> <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com> <4F3BE763.9060704@polito.it> <4F3C8C6F.4010708@gmail.com> <4F3D06D1.7000404@polito.it> <CAPdpN3AAwJ6s-fOgTCV4h4OCKCw3RhEav56LJaUXWVpuf4Jowg@mail.gmail.com> <4F3D144D.3060102@polito.it> <CAPdpN3Bj2u7YRYXEuyTX=1p9vcrnDdMOEO+VeHEHW2R_B4ar3g@mail.gmail.com> <20120220172418.GG26356@tango.0pointer.de> <4F4299C2.5040205@polito.it> <20120220191804.GD360@tango.0pointer.de> <4F436C7A.9020206@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F436C7A.9020206-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Roberto Sassu at 21/02/12 10:05 did gyre and gimble:
>> Well, if the rumours I keep hearing are true Ubuntu might join the
>> systemd camp too after their LTS release. Maybe the supporting
>> non-systemd systems issues solves itself by that for you?
>>
> 
> The code for loading IMA custom policies was placed in the initial
> ramdisk with the purpose to avoid distribution specific dependencies.
> However, since the SELinux initialization has been moved to Systemd
> and Systemd itself will be used by the major distributions, i think
> placing the IMA code here is the best solution, even if it is not the
> most general.

Just for reference, not all distros use the same initrd generator
anyway. We're trying to move to dracut, but it's certainly not universal
at the moment. I think Suse use something else (maybe they plan to move
to dracut too?) and I've no idea about Ubuntu but I doubt they use dracut.

So I'd suggest that at the moment, systemd will actually get you wider
coverage... although that's just a slightly ill-informed and hand-wave
analysis on my part. Either way, I think it's better in systemd :D

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
