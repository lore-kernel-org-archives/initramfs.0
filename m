From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 13 May 2014 12:22:08 +0200
Message-ID: <5371F250.9040708@redhat.com>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com> <5371EC2E.4020209@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5371EC2E.4020209-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 13.05.2014 11:55, Hannes Reinecke wrote:
> On 05/13/2014 11:48 AM, Harald Hoyer wrote:
>> On 13.05.2014 11:44, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> I'm trying to figure out why my initqueue scripts are never called.
>>> Eg 95fcoe is just installing an initqueue job, which should call
>>> 'fcoe-up' on the interface.
>>> However, this script is never called, irrespective of any 'fcoe=' parameters.
>>>
>>> Looking a dracut-initqueue.sh, we have this:
>>>
>>> while :; do
>>>
>>>      check_finished && break
>>>
>>>      udevadm settle --exit-if-exists=$hookdir/initqueue/work
>>>
>>>      check_finished && break
>>>
>>>      if [ -f $hookdir/initqueue/work ]; then
>>>          rm -f -- "$hookdir/initqueue/work"
>>>      fi
>>>
>>>      for job in $hookdir/initqueue/*.sh; do
>>>          [ -e "$job" ] || break
>>>          job=$job . $job
>>>          check_finished && break 2
>>>      done
>>>
>>>      udevadm settle --timeout=0 >/dev/null 2>&1 || continue
>>> ...
>>>
>>> and check_finished is:
>>>
>>> check_finished() {
>>>      local f
>>>      for f in $hookdir/initqueue/finished/*.sh; do
>>>          [ "$f" = "$hookdir/initqueue/finished/*.sh" ] && return 0
>>>          { [ -e "$f" ] && ( . "$f" ) ; } || return 1
>>>      done
>>>      return 0
>>> }
>>>
>>> IE if no scripts are present in the 'finished' queue, 'check_finished' will
>>> return '0', causing the main initqueue to short-circuit and the actual
>>> initqueue jobs will never be executed.
>>>
>>> Is this the intended outcome?
>>> IE are all jobs for the initqueue are _required_ to supply a 'finished' job?
>>>
>>> I would have thought it to be a bit more permissive, ie do a
>>> 'return 1' if no finish j0bs have been found ...
>>>
>>> Cheers,
>>>
>>> Hannes
>>
>> Yes, the finished queue defines when to end the main loop. If you want to hang
>> around in the main loop, you have to define the "break" condition, or in this
>> case the negative-continue condition.
> 
> Ah. So fcoe never worked?
> (As it doesn't supply an 'finished' script)
> 
> Cheers,
> 
> Hannes

What do you mean? Normally there are "finished" scripts installed, which wait
for the root device to appear. So the loop continues until the fcoe device appears.
