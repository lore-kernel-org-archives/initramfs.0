From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH] crypt: Fix device detection.
Date: Wed, 13 Feb 2013 22:25:59 +0000
Message-ID: <511C12F7.5020902@colin.guthr.ie>
References: <1360715138-19755-1-git-send-email-colin@mageia.org> <511B708A.60106@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <511B708A.60106-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 13/02/13 10:52 did gyre and gimble:
> Am 13.02.2013 01:25, schrieb Colin Guthrie:
>> The host device/fs rework led to a regression in crypt detection.
>> It was only checking the host filesystems, not it's slaves and thus
>> never detected if crypt support was needed.
>>
>> Code now mirrors the lvm module's check
>>
>> https://bugs.mageia.org/show_bug.cgi?id=9040
>> ---
> 
> Does this commit fix the issue instead?
> 
> http://git.kernel.org/?p=boot/dracut/dracut.git;a=commitdiff;h=19bab59c48ba6edbdf9d6d9f339baef250bdd4a6

ACK, that commit also fixes the issue on my test system.

Thanks :)

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
