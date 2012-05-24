From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Thu, 24 May 2012 12:50:10 +0800
Message-ID: <CAM_iQpU_64ggdyveLWZqAQJzTumGTin7sTeUeo_58OwAVRXs0w@mail.gmail.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com>
	<1337591686-31875-3-git-send-email-amwang@redhat.com>
	<4FBA09F7.4030003@redhat.com>
	<4FBA0B8D.1070708@gmail.com>
	<4FBA0E7E.1070004@redhat.com>
	<4FBA1698.3090006@gmail.com>
	<4FBA26A1.6010109@redhat.com>
	<4FBAEF49.60108@gmail.com>
	<4FBB5D3D.2080101@redhat.com>
	<4FBB97E7.6060804@gmail.com>
	<4FBCB1AC.907@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/PjF5PqQb3D5mKbZAhODTdDYfoaknL9DK4vh5kHMEZw=;
        b=P74WcCPsdtJntaANThy3WuJn0H1o1REEtkzaLKISqzbAfDEF7H6vPZriyzkWCFteBr
         KNt2SENAeV26CubWXs6sWYhZluyVmNwjA/0NO4XZuiJuHmwQQ9jPJ7ZolaOayw4aPHif
         QG/559AQeerY4IO8a1GnQxXZdOGRgudTZhX27RyCkDSkKH/G2luRuMVE1m2+d8w3OfUI
         HNau4pVD599cz911YiMJrJJ+IcgeQLhP67+hJTzFHv+HU9tNgkAweXc5LViAn8tGuUnI
         JrfIxq052W+UlRa33+3Z2DAGA2gnubHWgPgUrSOYB1pRHvW2gYfQ1WjGeLPilYK3DvVA
         Dmew==
In-Reply-To: <4FBCB1AC.907-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Wed, May 23, 2012 at 5:45 PM, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Am 22.05.2012 15:43, schrieb Cong Wang:
>>
>> We use ip=eth0.2:dhcp to get IP for eth0.2 via DHCP, so ifname=eth0.2:XXX is
>> requried by ip=, no?
>
> no, you would need ifname=eth0:XXX
>

Yeah, only specifying ifname=eth0:XXX seems also work.

Actually I am confused by the doc of ifname=, which said:

    Note: If you use this option you _must_ specify an ifname= argument for all
    interfaces used in ip= or fcoe= arguments.

I think it is out-of-date? In my case, "ip=eth0.2:dhcp ifname=eth0:XXX", eth0.2
appears in ip= but does not have to be in ifname=, as you suggested.

What's more, how about bridge and bonding cases? Do we have to specify
the slave device in ifname= instead of the master device??

Thanks!
