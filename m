From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] rootfs-block: Support lilo style device numbers.
Date: Thu, 24 Jan 2013 12:30:08 +0000
Message-ID: <51012950.1060507@mageia.org>
References: <1358972106-2395-1-git-send-email-colin@mageia.org> <1358972106-2395-5-git-send-email-colin@mageia.org> <51011D9C.4080901@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51011D9C.4080901-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Harald Hoyer at 24/01/13 11:40 did gyre and gimble:
> Am 23.01.2013 21:15, schrieb Colin Guthrie:
>> Lilo supplies root=900 rather than root=/dev/md0. Similarly it would say root=801 rather
>> than root=/dev/sda1.
>>
>> This patch simply interprets that number and creates appropriate udev rules
>> to create the /dev/root symlink as needed.
>> ---
>>  modules.d/95rootfs-block/block-genrules.sh | 11 ++++++++++-
>>  modules.d/95rootfs-block/parse-block.sh    |  4 ++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/modules.d/95rootfs-block/block-genrules.sh b/modules.d/95rootfs-block/block-genrules.sh
>> index 7f894ee..161183e 100755
>> --- a/modules.d/95rootfs-block/block-genrules.sh
>> +++ b/modules.d/95rootfs-block/block-genrules.sh
>> @@ -2,7 +2,16 @@
>>  # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
>>  # ex: ts=8 sw=4 sts=4 et filetype=sh
>>  
>> -if [ "${root%%:*}" = "block" ]; then
>> +if [ -n "$rootdevnum" ]; then
>> +    major=$(( 0x$rootdevnum / 256 ))
>> +    minor=$(( 0x$rootdevnum - ( $major * 256 ) ))
>> +    {
>> +        printf 'ACTION=="add|change", ENV{MAJOR}=="%d", ENV{MINOR}=="%d", SYMLINK+="root"\n' \
>> +            $major $minor
>> +    } >> /etc/udev/rules.d/99-root.rules
>> +
>> +    wait_for_dev /dev/root
>> +elif [ "${root%%:*}" = "block" ]; then
>>      {
>>          printf 'KERNEL=="%s", SYMLINK+="root"\n' \
>>              ${root#block:/dev/}
>> diff --git a/modules.d/95rootfs-block/parse-block.sh b/modules.d/95rootfs-block/parse-block.sh
>> index 3745352..9efc51f 100755
>> --- a/modules.d/95rootfs-block/parse-block.sh
>> +++ b/modules.d/95rootfs-block/parse-block.sh
>> @@ -19,4 +19,8 @@ case "$root" in
>>      /dev/*)
>>          root="block:${root}"
>>          rootok=1 ;;
>> +    [1-9][0-9][0-9])
>> +        rootdevnum=$root
>> +        root=block:/dev/root
> 
> I would do just:
> 
> major=$(( 0x$root / 256 ))
> minor=$(( 0x$root - ( $major * 256 ) ))
> root=/dev/block/$major:$minor

Hmm, indeed, that does seem simpler :)

Of course this whole scheme is generally stupid anyway (majors have not
been limited to 256 for years), but meh.

Col
-- 

Colin Guthrie
colin(at)mageia.org
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
