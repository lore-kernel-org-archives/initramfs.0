From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] network: don't die if gateway is down and root server
 is local
Date: Thu, 28 Oct 2010 17:14:27 +0200
Message-ID: <4CC99353.8040105@redhat.com>
References: <4CAEF060.8030701@draigBrady.com> <4CAF1D02.6060701@bfh.ch> <4CAF23BA.4010605@draigBrady.com> <4CAF27EF.80301@bfh.ch> <4CAF367D.7030707@draigBrady.com> <4CB84390.5060203@draigBrady.com> <4CB85A73.6010902@redhat.com> <4CB85F31.5010207@draigBrady.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CB85F31.5010207-V8g9lnOeT5ydJdNcDFJN0w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/15/2010 04:03 PM, P=C3=A1draig Brady wrote:
> On 15/10/10 14:43, Harald Hoyer wrote:
>>
>> please use [ -n "$var" ]
>>
>
> Done, and added a couple of comments.
>
> cheers,
> P=C3=A1draig.
>
>  From 3030d23e31f3975c0c44207b0faae0792d5cc9b0 Mon Sep 17 00:00:00 20=
01
> From: =3D?utf-8?q?P=3DC3=3DA1draig=3D20Brady?=3D<P@draigBrady.com>
> Date: Fri, 15 Oct 2010 12:58:31 +0100
> Subject: [PATCH] network: don't die if gateway is down and root serve=
r is local
>
> * modules.d/40network/netroot: Don't arping the gateway
> if we don't need to

pushed
