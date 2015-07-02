From: "Christoph Pleger" <Christoph.Pleger-ogaGWlaKng3jEoi5djuKH7NAH6kLmebB@public.gmane.org>
Subject: Re: IP configuration with dhcp
Date: Thu, 2 Jul 2015 15:48:16 +0200
Message-ID: <b95770cbd97294ca65de25c9732df7ad.squirrel@postweb.cs.tu-dortmund.de>
References: <a82892e788a77d505b9b4bedd690e480.squirrel@postweb.cs.tu-dortmund.de>
    <55953BDF.9090503@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55953BDF.9090503-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

>> So, does dracut only support automatic IP configuration by DHCP if
>> "root=dhcp" is set, or is there something I can change in the kernel
>> parameters to make automatic IP configuration work when booting from
>> DVD?

> try "ip=dhcp rd.neednet=1"

Thank you very much, it's working now.

Regards
  Christoph
