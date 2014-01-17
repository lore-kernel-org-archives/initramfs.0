From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH v2] crypt: Prevent asking for password multiple times
 if non-default crypt name is used.
Date: Fri, 17 Jan 2014 10:32:16 +0000
Message-ID: <lbb0r4$rh7$1@ger.gmane.org>
References: <1388093183-19045-1-git-send-email-colin@mageia.org> <1388149248-23146-1-git-send-email-colin@mageia.org> <52D025F5.1050703@thestaticvoid.com> <52D40696.4080204@thestaticvoid.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D40696.4080204-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and James Lee at 13/01/14 15:30 did gyre and gimble:
> On 01/10/2014 11:55 AM, James Lee wrote:
>> I believe I've seen the situation this patch is trying to fix.  I will
>> test these patches with my fairly complex crypt setup [1] this weekend.
>>
>> James
>>
>> [1]
>> https://thestaticvoid.com/post/2013/10/26/how-i-do-encrypted-mirrored-zfs-root-on-linux/
> 
> Both patches (this one and the udev rule one) work great on all the
> systems I tried them on.  Solves the problem I was seeing with being
> asked for the passphrase multiple times.

Cool, thanks for testing!

Harald, care to commit at least one of them? I'm pretty sure the first
patch (v2) is safe on it's own. I'm not 100% sure about the udev bit as
although it solves the problem, it might have some unintended side effects.

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
