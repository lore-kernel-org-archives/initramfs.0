From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut fails to install libraries on Debian / Ubuntu systems
Date: Mon, 4 Feb 2013 15:38:49 +0100
Message-ID: <CAGEveXqMjmHGfgYurFDrYdx5F4U9jZ0QZOofHtOuCvGjt7N=xQ@mail.gmail.com>
References: <loom.20130204T110507-984@post.gmane.org>
	<CAGEveXp94E6HAQjcC+ETp1ipR5BKC+V-46Nv6yr68U5PkvwPow@mail.gmail.com>
	<loom.20130204T140305-929@post.gmane.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=i/FMP+7Xr5nwroKWVZ52enwn6infPcDbeduxyDppwDo=;
        b=TC47OLQm6ce8cu7CX4QOZvhw2inzJ1qfwKy4yymtqQ/YdEhcy2wWzTNwK1+V+hWu2b
         0GiNQiNs9M3dsF9dDt6ndJyW7upLiTsX0R/etcvbHhkBFi26wWhPZ3WyEw4loTjp1o5z
         20vXFjpsFgGCGG8poHzW1HOExQPY8W5+kH+7R3eMWWhBJ6OglCeJEbS1J5awzHhy3aAX
         kPap11oryHI7wskssIkx0hP3RBNhH1E5Deui0RnLg6/b6gPoPHqn6i5MEjn4Xx03C0f/
         y0mH97ZNmqWbXV7PJ9x+jA0f+wrmePjqJfwgOX2TLXHdV41J/eEfddmUlbem+zqUDmcY
         5xdg==
In-Reply-To: <loom.20130204T140305-929-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> Thanks for the link. I wasn't aware of the paramter --libdirs, probably
> as it is not shown when calling dracut --help. Besides that, I expected
> that dracut would by default search all relevant lib locations for
> Debian.
>
> I will try to create a patch for updating the help and the
> documentation.

:-)

> Is there a reason why /lib/x86_64-linux-gnu is not
> included by default in the libdirs?

IMHO multiarch triplets are something only related to Debian and can
change or be extended in the future, so it is better to guess them

I see that Thomas didn't add a configuration file to add the multiarch
paths, as I did to my packages

/etc/dracut.conf.d/multiarch.conf
libdirs+="$(sed 's/#.*//' /etc/ld.so.conf.d/*-linux-gnu.conf 2>/dev/null)"

Regards,

JonAn.
