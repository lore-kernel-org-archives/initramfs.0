From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Mon, 28 Oct 2013 16:41:22 +0000
Message-ID: <526E93B2.9030408@colin.guthr.ie>
References: <5253DD0C.7050506@redhat.com>	<l4dk8e$fv8$1@ger.gmane.org>	<526A7412.8030804@redhat.com> <20131028134216.049c6a01@work.puleglot> <l4lvht$4jh$1@ger.gmane.org> <526E8E99.2020702@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526E8E99.2020702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

'Twas brillig, and Harald Hoyer at 28/10/13 16:19 did gyre and gimble:
> On 10/28/2013 04:23 PM, Colin Guthrie wrote:
> 
>> That being the case, I would propose that the usrmount module be
>> automatically included when /usr is a mount point regardless of on which
>> partition init lives?
> 
> Might be the safest option to include it in all non-systemd setups.

Yeah I didn't actually read Alexander's second email which enumerates
the possibilities better:

> Same applies to systemd installed in "/". I think there are only 2
> cases when usrmount module can be omitted:
> 1. systemd module is included
> 2. hostonly + non-separate /usr

But I guess for 2. it doesn't do much harm including it anyway - it's
just a bit of a no-op.

(sorry for not included the original CC's but GMane messes up the email
addresses - would be nice if someone could ping them to turn the
obfuscation off)

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
