From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] add fake root support
Date: Wed, 10 Nov 2010 15:21:36 +0100
Message-ID: <4CDAAA70.1070302@redhat.com>
References: <4CBDB007.4090802@hoster-ok.com> <4CCECBB0.3030609@hoster-ok.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CCECBB0.3030609-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/01/2010 03:16 PM, Vladislav Bogdanov wrote:
> 19.10.2010 17:49, Vladislav Bogdanov wrote:
>> Attached is a patch for "fake" root functionality,
>> I'm (mostly) duplicating issue's description from my previous e-mail
>> (for commit message if this is to be pushed):
>>
>
> Sorry for being annoying, but... Any comments?
>
> Best,
> Vladislav
>

I like it, but I don't like the parameters...

Maybe we can express it like this:

netroot=fake:xxx.yyy.zzz.www:/mnt root=live:blablabla

and find another name for "fake".. maybe "container"?

netroot=container:nfs:xxx.yyy.zzz.www:/mnt root=live:blablabla

Which reminds me, that we should probably have the possibility to concatenate 
several stages.

root=nfs:xxx.yyy.zzz.www:/mnt|loop:test.img|live:blablabla

comments?
