From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 6/9] 40network: install dhclient, brctl and ifenslave
 optionally
Date: Mon, 28 Mar 2011 11:51:59 +0200
Message-ID: <4D905A3F.6040908@bfh.ch>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name> <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name> <4D8CB520.60504@bfh.ch> <1301305103-sup-5234@ittemni>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301305103-sup-5234@ittemni>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 03/28/2011 11:40 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Excerpts from Seewer Philippe's message of Fri Mar 25 16:30:40 +0100 =
2011:
>> I'll have to object to this, sorry. The current network implementati=
on
>> does not check if these binaries are there and throws errors if ip=3D=
dhcp
>> is provided and no dhclient is available.
>
> dhclient was optional before. You suggest it should be made required,
> yes?

Ok, I see the point. The dwarning in module-setup was/is misleading. I=20
guess I missed that, sorry.

Since there's currently no code that makes any network functionality=20
optional (See modules.d/40network/ifup for example) question is should=20
there be or should all required binaries actually be *required*?

Regards,
Philippe
