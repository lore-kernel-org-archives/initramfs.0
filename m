From: Vasiliy Tolstov <v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] Adds bittorrent support to 45url-lib for live images
Date: Fri, 15 Aug 2014 10:48:48 +0400
Message-ID: <CACaajQsVwAcUMgjejvjC_nsLsgQ-j_4wZQQYC2MhSZsmQu4bMQ@mail.gmail.com>
References: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfip.ru; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=A2Nlm6uKzDx7nfgdgl8CgZMAfRQ5YjJ+aw5y51c6fAs=;
        b=GH9FWZ/k5QhJu93s3+Dk2eyRMZ0unhfiBXK42QsgBnu0rAG/zw8uToqRKSuNpMGE6K
         tHOLfHYFwG6OUsJReUNdOHxZuX3fN7fO46e0XHwpVkf+wxF99Et7tpAW7DRaQ9IOjYAC
         sliQN6tkJvyutMcNohqa4WVBOU1mRVVxyRfi4=
In-Reply-To: <CAGgovyGokHpfq8oVfQMi9XCKAhpDK4N1t11KbDdDr2pckc=bDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antony Messerli <antony-M9eEzXzj57sUjmZRR9AIpQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2014-08-15 0:31 GMT+04:00 Antony Messerli <antony-M9eEzXzj57sUjmZRR9AIpQ@public.gmane.org>:
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


Wow! Very nice. I want to do something some time ago, but this is
looks very good!
Question for all - i have a patch for overlayfs support, also github
have patch for aufs support.
As i see main difference of top layer. How the best rewrite my (may be
aufs) patch to have bottom layer agnostic support?

-- 
Vasiliy Tolstov,
e-mail: v.tolstov-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
jabber: vase-+9FY0jupvH6HXe+LvDLADg@public.gmane.org
