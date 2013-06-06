From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] base: setup correct system time and time zone in initrd
Date: Thu, 06 Jun 2013 13:40:14 +0200
Message-ID: <51B0751E.30503@redhat.com>
References: <20130606095611.GA29287@dhcp12-158.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130606095611.GA29287-UAAZkH0G2Ts1naxU1pY8ZxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/06/2013 11:56 AM, WANG Chao wrote:
> Currently in initrd, hardware clock is always considered to use UTC time
> format and system time zone is also UTC. Thus system time isn't correct
> if hw clock is localtime or we're using other time zone in real root.
> 
> To fix this, install /etc/adjtime and /etc/localtime to initrd. If not
> using systemd, install /usr/sbin/hwclock for dracut init to setup system
> time.
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 

Thanks! Pushed
