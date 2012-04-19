From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Debian multiarch support
Date: Thu, 19 Apr 2012 12:15:23 +0200
Message-ID: <4F8FE5BB.6060705@redhat.com>
References: <CAGEveXprJz33cnna8PDQE7eyNUw1S-RDYtyZY405STOH7FfswA@mail.gmail.com> <CAGEveXr7G+5_rcuHUWBrg-rAQ1y6wU2ozVy2yBbQuo3PYdx3Mw@mail.gmail.com> <CAGEveXqScm9T-cto8jRYh2_dM6Md+grqppXs0nWTjB_Vo69zMA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGEveXqScm9T-cto8jRYh2_dM6Md+grqppXs0nWTjB_Vo69zMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jon Ander Hernandez <jonan.h-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 16.04.2012 11:34, schrieb Jon Ander Hernandez:
> Hello,
> 
> Before considering my patch I should note that it has a bug, it should be:
> 
>  # Detect lib paths
>  [[ $libdir ]] || for libdir in /lib64 /lib; do
> -    [[ -d $libdir ]] && break
> +    [[ -d $libdir ]] && libdirs+=" $libdir" && break
>  done || {
>     dfatal 'No lib directory?!!!'
>     exit 1
>  }
> 
>  [[ $usrlibdir ]] || for usrlibdir in /usr/lib64 /usr/lib; do
> -    [[ -d $usrlibdir ]] && break
> +    [[ -d $usrlibdir ]] && libdirs+=" $usrlibdir" && break
>  done || dwarn 'No usr/lib directory!'
> 
> Now there is a space before $libdir and $usrlibdir, which avoids
> suffixing the libdirs value defined on a *.conf file with $libdir. I'm
> sorry.
> 
> Regards,
> 
> JonAn.

pushed
