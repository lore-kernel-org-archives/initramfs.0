From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Adds bittorrent support to 45url-lib for live images
Date: Fri, 15 Aug 2014 12:34:23 +0200
Message-ID: <53EDE22F.3090501@redhat.com>
References: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Antony Messerli <antony-M9eEzXzj57sUjmZRR9AIpQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 14.08.2014 22:31, Antony Messerli wrote:
> This patch adds bittorrent support to 45url-lib for those that might want to
> retrive the same live image for multiple systems at once without
> saturating the network.
> This patch requires ctorrent to be installed into initramfs.
> 
> Torrent kernel command line format:
> root=live:torrent://image_location/image.torrent
> 
> Start a tracker:
> bttrack --bind <tracker_ip> --port 6969 --dfile dstate --reannounce_interval 60
> 
> Create the torrent:
> ctorrent -t live_image -u http://<tracker_ip>:6969/announce -s
> live_image.torrent
> 
> Seed the initial torrent:
> ctorrent live_image.torrent
> 
> Boot the live image.
> ---

Can you add

inst_multiple -o ctorrent

to module-setup.sh ?
