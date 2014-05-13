From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 13 May 2014 11:55:58 +0200
Message-ID: <5371EC2E.4020209@suse.de>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5371EA56.3000203-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/13/2014 11:48 AM, Harald Hoyer wrote:
> On 13.05.2014 11:44, Hannes Reinecke wrote:
>> Hi all,
>>
>> I'm trying to figure out why my initqueue scripts are never called.
>> Eg 95fcoe is just installing an initqueue job, which should call
>> 'fcoe-up' on the interface.
>> However, this script is never called, irrespective of any 'fcoe=3D' =
parameters.
>>
>> Looking a dracut-initqueue.sh, we have this:
>>
>> while :; do
>>
>>      check_finished && break
>>
>>      udevadm settle --exit-if-exists=3D$hookdir/initqueue/work
>>
>>      check_finished && break
>>
>>      if [ -f $hookdir/initqueue/work ]; then
>>          rm -f -- "$hookdir/initqueue/work"
>>      fi
>>
>>      for job in $hookdir/initqueue/*.sh; do
>>          [ -e "$job" ] || break
>>          job=3D$job . $job
>>          check_finished && break 2
>>      done
>>
>>      udevadm settle --timeout=3D0 >/dev/null 2>&1 || continue
>> ...
>>
>> and check_finished is:
>>
>> check_finished() {
>>      local f
>>      for f in $hookdir/initqueue/finished/*.sh; do
>>          [ "$f" =3D "$hookdir/initqueue/finished/*.sh" ] && return 0
>>          { [ -e "$f" ] && ( . "$f" ) ; } || return 1
>>      done
>>      return 0
>> }
>>
>> IE if no scripts are present in the 'finished' queue, 'check_finishe=
d' will
>> return '0', causing the main initqueue to short-circuit and the actu=
al
>> initqueue jobs will never be executed.
>>
>> Is this the intended outcome?
>> IE are all jobs for the initqueue are _required_ to supply a 'finish=
ed' job?
>>
>> I would have thought it to be a bit more permissive, ie do a
>> 'return 1' if no finish j0bs have been found ...
>>
>> Cheers,
>>
>> Hannes
>
> Yes, the finished queue defines when to end the main loop. If you wan=
t to hang
> around in the main loop, you have to define the "break" condition, or=
 in this
> case the negative-continue condition.

Ah. So fcoe never worked?
(As it doesn't supply an 'finished' script)

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare-l3A5Bk7waGM@public.gmane.org			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
