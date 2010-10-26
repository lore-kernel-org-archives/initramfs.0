From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: udev question
Date: Tue, 26 Oct 2010 13:24:01 +0200
Message-ID: <4CC6BA51.5030906@redhat.com>
References: <4CC5C26B.9060002@googlemail.com> <4CC6B5BD.2020603@redhat.com> <4CC6B993.1040808@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC6B993.1040808-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/26/2010 01:20 PM, Mr Dash Four wrote:
>
>>>
>>> Am I missing something fundamental here?
>>
>> udev runs a second time in the real root, just because of this limitation of
>> the initramfs.
> Yeah, I sort of figured it out yesterday after running a 'probe' version of the
> '90crypt; module. I have another udev-related query though - if multiple rules
> register for the same udev triggers (like ENV{ID_FS_TYPE}=='crypto_LUKS') how
> are they executed and can the order of execution be controlled?
>
> The reason I am asking this is because, as it turns out, I may need to design a
> separate module for smartcard tokens to be used with LUKS and the way I see this
> is when LUKS partition gets matched by udev the smartcard module needs to get
> the first go (for all smartcard-specified LUKS partitions) then 90crypt (with
> key file login, possibly falling back on password authentication if the key file
> data is not successful - though this, as far as I can see, is not yet
> implemented!).
>
> Unfortunately, my udev knowledge is not that much to know is that possible,
> hence the my query.

place it in a udev rules file with a lower number... first come, first serve.
