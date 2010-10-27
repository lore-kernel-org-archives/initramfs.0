From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: crypt-cleanup.sh question
Date: Wed, 27 Oct 2010 15:37:15 +0200
Message-ID: <4CC82B0B.30208@redhat.com>
References: <4CC6C571.8010406@googlemail.com> <4CC6E7C1.1050703@googlemail.com> <4CC7F15C.7090600@redhat.com> <4CC815E4.4060705@googlemail.com> <4CC82448.80403@redhat.com> <4CC82652.3090500@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC82652.3090500-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/27/2010 03:17 PM, Mr Dash Four wrote:
>
>> Hmm, maybe this could do it:
>>
>>
>> diff --git a/modules.d/90crypt/crypt-cleanup.sh
>> b/modules.d/90crypt/crypt-cleanup.sh
>> index e9fc6ba..4722425 100755
>> --- a/modules.d/90crypt/crypt-cleanup.sh
>> +++ b/modules.d/90crypt/crypt-cleanup.sh
>> @@ -4,6 +4,11 @@
>> # close everything which is not busy
>> rm -f /etc/udev/rules.d/70-luks.rules >/dev/null 2>&1
>>
>> +if getargs rd_LUKS_UUID || getarg rd_NO_LUKS; then
>> + # do not clean up, if we did not autoassemble
>> + exit 0
>> +fi
>> +
>> while true; do
>> local do_break="y"
>> for i in /dev/mapper/luks-*; do
> That is good, but I have a better idea (currently implementing it - will post
> the patch later today) - keep open only the partitions specified via
> rd_LUKS_UUID and close everything else. Close everything if rd_NO_LUKS is used
> (there shouldn't be any LUKS partitions open if that parameter was used, but you
> can't be too careful!). How's that?
>
> On a side note: I thought rd_LUKS_UUID, rd_LUKS_KEYPATH, rd_LUKS_KEYDEV and
> rd_NO_LUKS are sort of 'deprecated' in favour of the new rd.luks.* format - is
> that not the case?

yes, they will be.

> Another query - is there any particular reason why all rd_LUKS_UUID need to be
> mapped to luks-UUID? I'd rather be able to choose a more meaningful name than
> the 'standard' luks-UUID - just a thought.

hmm, yes/no... I like meaningful symlinks :)
