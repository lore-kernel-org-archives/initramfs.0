From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Debian/Ubuntu patches
Date: Tue, 9 Nov 2010 13:07:12 +0100
Message-ID: <4CD93970.8060004@bfh.ch>
References: <AANLkTikEPsCQzMSJbhwuO95Br+7aYJPw9zbVRd4Y8vOC@mail.gmail.com>	<4CD9102B.7030702@bfh.ch> <AANLkTi=N9QZZ0tKzBab78kuZ=X7nOThC5DKpss40XBze@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=N9QZZ0tKzBab78kuZ=X7nOThC5DKpss40XBze-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On 11/09/2010 12:19 PM, Jon Ander Hernandez wrote:
[snip]
>> We need iputils-arping and not the standard arping. Mind checking if you are
>> using the correct package?
>
> $ dpkg -S `which arping `
> iputils-arping: /usr/bin/arping
>
> $ arping -V
> arping utility, iputils-sss20100418

Thanks for checking. Now i'm confused. Because arping's invocation (sudo 
arping -f -w 60 -I eth0 ...) on my 10.10 works flawless. Is dracut 
"throwing" an error when calling arping or is it the "Resolving $dest 
via ARP on $netif failed" message?

Regards,
Philippe
