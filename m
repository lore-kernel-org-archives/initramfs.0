From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] 90crypt: rem. key-media - support for labels and
 normal dev names
Date: Tue, 12 Oct 2010 19:02:25 +0200
Message-ID: <4CB494A1.7040003@redhat.com>
References: <1286145886-16322-1-git-send-email-aidecoe@aidecoe.name> <1286145886-16322-2-git-send-email-aidecoe@aidecoe.name> <4CB49443.8070407@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CB49443.8070407-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/12/2010 07:00 PM, Harald Hoyer wrote:
> On 10/04/2010 12:44 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
>> + foreach_dev_until "probe_keydev \$___ $keypaths" $keydevs&& \
>> + return 0
>
> $___ is a foreach_dev_until internal local var?

Ah, ok...

# To pass full UUID to
# your command use '$___' as a place holder.  Remember to escape '$'!

hmm, well.. ok..
