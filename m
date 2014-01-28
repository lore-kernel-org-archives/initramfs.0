From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: [PATCH v2] crypt: Prevent asking for password multiple times
 if non-default crypt name is used.
Date: Tue, 28 Jan 2014 15:40:54 +0000
Message-ID: <52E7CF86.8020406@colin.guthr.ie>
References: <1388093183-19045-1-git-send-email-colin@mageia.org> <1388149248-23146-1-git-send-email-colin@mageia.org> <52E7C0FD.1030209@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52E7C0FD.1030209-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 28/01/14 14:38 did gyre and gimble:
> On 12/27/2013 02:00 PM, Colin Guthrie wrote:
>> If a non-default device mapper name is used for an encrypted partion is
>> used, (i.e. not luks-$UUID) due to parsing of /etc/crypttab, then the
>> short-circuits put in place to prevent asking the password twice do not
>> work.
>>
>> This would not normally be an issue as the settled job itself should be
>> removed after it has run and thus cannot be run again. Sadly, due to
>> the corresponding udev rule using ACTION="add|changed", and the fact
>> that trying to unlock the device (whether successful or not) seems to
>> trigger a changed event, it means the settled job is recreated with
>> each itteration thus causing the whole loop to run again.
>>
>> It is this situation that the short-circuit exits would normally come
>> into play but sadly do not work when non-standard names are used.
>>
>> By the time the /tmp/cryptroot-asked-$2 file is written near the end of
>> the script, the value of $2 has already been lost due to the argument
>> parsing code's use of 'shift'. So while on systems where the default
>> name is used are protected by checking /dev/mapper/xxxx, the
>> /tmp/cryptroot-asked-$2 file didn't help on systems where this was not
>> used due to this bug.
>>
>> So this commit shuffles things around somewhat such that:
>>
>>  1. The /dev/mapper/xxxx device is checked *after* resolving $2 (which
>>     contains the default name) to whatever /etc/crypttab specifies.
>>  2. The cryptroot-asked-xxxx file also uses the translated name both
>>     for the initial check and to flag when it's written.
>>
>> As a separate fix, it might make sense to change the udev rule to only
>> act on add events rather than add|change events, but I'm not sure of the
>> ramifications of such a change and there may be cases where the add
>> event is missed and thus the change event needs to be included.
>> ---
>>
>>  v2: Fix issue where getargbool was not defined due to deferred loading
>>      of dracut-crypt-lib.sh
>>
>>  modules.d/90crypt/cryptroot-ask.sh | 36 +++++++++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 17 deletions(-)
>>
> 
> Thanks! Pushed.

Excellent, thanks. Your timing is good. I was going to pester you about
this on Thursday. I can chalk this one of my list now :p

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
