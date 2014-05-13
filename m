From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: check_finished() syntax weirdness
Date: Tue, 13 May 2014 12:39:01 +0200
Message-ID: <5371F645.3080309@redhat.com>
References: <5371E992.1080802@suse.de> <5371EA56.3000203@redhat.com> <5371EC2E.4020209@suse.de> <5371F250.9040708@redhat.com> <5371F448.5030208@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5371F448.5030208-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 13.05.2014 12:30, Hannes Reinecke wrote:
> On 05/13/2014 12:22 PM, Harald Hoyer wrote:
>> On 13.05.2014 11:55, Hannes Reinecke wrote:
> [ .. ]
>>>
>>> Ah. So fcoe never worked?
>>> (As it doesn't supply an 'finished' script)
>>>
>>> Cheers,
>>>
>>> Hannes
>>
>> What do you mean? Normally there are "finished" scripts installed, which wait
>> for the root device to appear. So the loop continues until the fcoe device
>> appears.
>>
> Not in my case.
> Which module should install them?
> 
> Cheers,
> 
> Hannes

for systemd:
  modules.d/98systemd/rootfs-generator.sh:
[ "${root%%:*}" = "block" ] && generator_wait_for_dev "${root#block:}"

for non-systemd:
 modules.d/95rootfs-block/parse-block.sh:
[ "${root%%:*}" = "block" ] && wait_for_dev "${root#block:}"


What is your kernel command line?
