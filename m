From: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Fri, 22 Oct 2010 20:34:57 +0200
Message-ID: <20101022183457.GB1730@nb.net.home>
References: <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com> <4CBE44D3.6070000@googlemail.com> <1287580805-sup-6517@etiriah> <4CBF004F.9070201@googlemail.com> <1287586242-sup-9146@etiriah> <20101021132916.GC22186@nb.net.home> <4CC0462E.20507@googlemail.com> <20101021151802.GD22186@nb.net.home> <4CC060B3.3050508@googlemail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CC060B3.3050508-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Oct 21, 2010 at 04:48:03PM +0100, Mr Dash Four wrote:
>>> I think specifying the target file system is important because by 
>>> just  executing 'mount' without indicating the target file system 
>>> when I have,  for example, HFS or HPFS mount just won't happen.
>>>     
>>
>> Why? My mount(8) is able to detect HFS or HPFS.
>>   
> I have no such luck when trying to mount my (Macbook Pro) laptop  
> partition, nor when I try to mount my OS/2 Warp (v3.01) server disk  
> drive, hence why I always specify the target file system - then it works  
> every time.

 Hmm.. I'd like to fix this problem. Please, send me 1MiB from the beginning
 of the device(s).

    # dd if=<dev> of=file.img bs=1MiB count=1

 Thanks.

    Karel

-- 
 Karel Zak  <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 http://karelzak.blogspot.com
