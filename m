From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 12:33:15 +0000
Message-ID: <jift6c$e4a$1@dough.gmane.org>
References: <2369135.eJzU9GBXlg@ernie> <4F4B5A00.2060400@redhat.com> <jifpfl$hof$1@dough.gmane.org> <4F4B7237.6070005@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F4B7237.6070005-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 27/02/12 12:08 did gyre and gimble:
> Am 27.02.2012 12:29, schrieb Colin Guthrie:
>> I'd just like to understand the issue :)
> 
> Have you replaced module-init-tools with kmod? If not, then this problem does
> not affect you.

Gah, it seems not. I had it in my head that we'd switched, but on closer
inspection it was just ldetect and few other bits and bobs that moved
over... not module-init-tools yet.

Sorry for the noise.

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
