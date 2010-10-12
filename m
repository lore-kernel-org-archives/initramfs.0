From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] 90crypt: rem. key-media - support for labels and
 normal dev names
Date: Tue, 12 Oct 2010 18:37:52 +0200
Message-ID: <4CB48EE0.8050101@redhat.com>
References: <1286145886-16322-1-git-send-email-aidecoe@aidecoe.name> <1286145886-16322-2-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286145886-16322-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/04/2010 12:44 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> 90crypt: scan for devices several times instead of just once

+        while [ $i -lt 3 ]; do
+            sleep $i

I would make that more dynamic.. we have udev..

/sbin/cryptroot-ask could install itsself again in the initqueue like=20
parse-crypt.sh does, if the rd_LUKS_KEYDEV is not there yet.

What do you think?
