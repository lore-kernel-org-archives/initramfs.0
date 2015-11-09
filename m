From: Alex <mysqlstudent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Update FC23 - doesn't boot - ssh preboot not working anymore
Date: Mon, 9 Nov 2015 15:05:14 -0500
Message-ID: <CAB1R3sj5hJVtihk63GnPxV4pMMFMcmpuXinZMKEQEq8dM9qBbw@mail.gmail.com>
References: <5639297E.7050905@wiesinger.com>
	<5640B47C.1020101@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6of7SLx7lwlTEUUr2q8vyY/JV4BNIZe6vXERYcF3LVU=;
        b=XQ2NXQ2KJJG1vpdCm4a6gTZ4gI4wbq3GGliMhTUu1OPXhtRPKDcBKRuRqql9JVb6M1
         8/6NZ+CuZx7pF4ukdcdVv8aRGCvPzHducaqZUB8NqrmtFZEL5bZiVx6jsvSBowksqnr2
         ArX0+h0JhmVtTwkZQM+PU4TY5ApRZMaAbhrgPShqfnBHuzROFA7+qhUUszCrCUNCvjkq
         KhKVRuXD8WDzsBOChvQ9gFloAE4QDYFqoIn2B8GGeIIAsIJGV1m4eY54hMx9pa2iXGWI
         gbt+JvU2evNxikASFgbZi8ZxQH4qKMW6HruhtShSMmnl84Fbwkk9uLFcANGvl9gXSDRI
         PR2g==
In-Reply-To: <5640B47C.1020101-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Gerhard Wiesinger <lists-tcxHB8FAk+J54TAoqtyWWQ@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

>> After upgrading one machine it does't boot anymore. Booting the old FC22 kernel
>> works well.
>>
>> Reached target Basic System.
>> Found device /dev/mapper/luks-9fbecd95-508a-45ca-997a-42a613c4e5bf
>> Found device /dev/mapper/fedora_hostname-root
>>
>> Also integration of ssh preboot authentication is not available anymore.
...
>
>
> https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html#_troubleshooting
>
> please file a bugzilla on the fedora/redhat bugzilla and add rdsosreport.txt

Please follow up here with the bugzilla ID, as I had a similar problem.

My solution was to create a "BIOS Boot" partition where one previously
didn't exist then reinstall grub. I really don't know if all that I
did was necessary, or if there was something else in my process that
actually fixed it, but I've had to do it on a few machines now and
it's fixed it every time.
