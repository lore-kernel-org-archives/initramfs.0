From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Adds bittorrent support to 45url-lib for live images
Date: Fri, 15 Aug 2014 17:37:19 +0200
Message-ID: <53EE292F.2080809@redhat.com>
References: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg@mail.gmail.com>	<53EDE22F.3090501@redhat.com> <CAGgovyEGqP6cbeOOZZYV0LQsbZirjo=Jihyxod_3RrkCMrF7VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGgovyEGqP6cbeOOZZYV0LQsbZirjo=Jihyxod_3RrkCMrF7VQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Antony Messerli <antony-M9eEzXzj57sUjmZRR9AIpQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Thanks! Pushed along with a check for the ctorrent binary before adding it to
the url handler.
commit e84af01462b8b7c4b0efa2fd27bd28a01a8ef19a


On 15.08.2014 17:28, Antony Messerli wrote:
> I've gone ahead and created a pull request with a few more changes here:
> 
> https://github.com/haraldh/dracut/pull/26
> 
> On Fri, Aug 15, 2014 at 5:34 AM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On 14.08.2014 22:31, Antony Messerli wrote:
>>> This patch adds bittorrent support to 45url-lib for those that might want to
>>> retrive the same live image for multiple systems at once without
>>> saturating the network.
>>> This patch requires ctorrent to be installed into initramfs.
>>>
>>> Torrent kernel command line format:
>>> root=live:torrent://image_location/image.torrent
>>>
>>> Start a tracker:
>>> bttrack --bind <tracker_ip> --port 6969 --dfile dstate --reannounce_interval 60
>>>
>>> Create the torrent:
>>> ctorrent -t live_image -u http://<tracker_ip>:6969/announce -s
>>> live_image.torrent
>>>
>>> Seed the initial torrent:
>>> ctorrent live_image.torrent
>>>
>>> Boot the live image.
>>> ---
>>
>> Can you add
>>
>> inst_multiple -o ctorrent
>>
>> to module-setup.sh ?
>>
