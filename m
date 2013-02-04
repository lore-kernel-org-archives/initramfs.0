From: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dracut fails to install libraries on Debian / Ubuntu systems
Date: Mon, 4 Feb 2013 13:48:35 +0100
Message-ID: <CAGEveXp94E6HAQjcC+ETp1ipR5BKC+V-46Nv6yr68U5PkvwPow@mail.gmail.com>
References: <loom.20130204T110507-984@post.gmane.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lqqCjUO93EKB6GlD5BPNAfufx9vUTaloDuusBWBvBM8=;
        b=MpUAONSxJJF3ruNR5OcjrjN2QPgdZviwbOE7nEYbbwn87Z0XPJzQyqY4kc83yHUu0S
         k4aiyUNdwcCAyAv1dGiknfBSQzph6vgpxoe/rshEnjB6Yjnka1urm6z3wQ0pdeW4QsPT
         Y2H/EaEhUtCb43OXs3VVaWBcwjeirSlvRtUAo+OKkjlPhqmvuYxhh7ldUc2yYS5G1/j2
         rMB2MVBNFgZLrhYfd7ilX87lA0RUU15eAxAqXlesx6saRC7q+om+DcwfrBRuRjf50Yj4
         lLTVoqPlwQOe0CCUsvR6kEX/MJ3nsj1ppNqFxY0jY2YxjlchSfm266vN2Fs02norncv+
         i0ZA==
In-Reply-To: <loom.20130204T110507-984-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

2013/2/4 Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Due to the multiarch approach of debian [1] some libraries such as
> libnss_files* are not located in /lib64 but instead in
> /lib/x86_64-linux-gnu . As the dracut function inst_libdir_file() only
> searches in the /lib and /lib64 folders without checking their
> subfolders, some required libraries are not included on Debian / Ubuntu
> systems. There is an unsolved bug report on Ubuntu launchpad from 2011
> with more details [2].
>
> I would like to propose two different solutions and be glad to create a
> patch for one of them, as soon as I could get some feedback what
> approach would be best:
> 1) Include /lib/x86_64-linux-gnu when detecting the libdirs in
> dracut-functions.sh
> 2) Change inst_libdir_file() to recursively search the lib folders for
> the required libraries e.g. by using the find utility
>
> I would be glad if we could solve this issue, as it blocks using dracut
> with NFSv3 on Debian / Ubuntu systems.

http://git.kernel.org/?p=boot/dracut/dracut.git;a=commit;h=c9143a63fef0d6f2dfd7cc37b09fc68d744d900f

Regards,

JonAn.
