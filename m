From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] unquote nbd port
Date: Thu, 06 Sep 2012 10:51:28 +0200
Message-ID: <50486410.4030202@redhat.com>
References: <CAKzfqkepaa87Q8aU5WsNi9TFCpka02eKOfCOaOZg80eOGa=ywA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfqkepaa87Q8aU5WsNi9TFCpka02eKOfCOaOZg80eOGa=ywA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 25.08.2012 13:42, schrieb Wim Muskee:
> Name based connects fail because of the quotes around the $nbdport.
> For name based connects, the -N option also gets included. For
> instance nbd-client 192.168.0.1 '-N ltsp' /dev/nbd0.
> I believe the quotes are not necessary for actual port numbers.
> 
> --- modules.d/95nbd/nbdroot.sh.orig     2012-08-25 13:38:00.817059355 +0200
> +++ modules.d/95nbd/nbdroot.sh  2012-08-25 13:38:21.532204861 +0200
> @@ -95,7 +95,7 @@
>      i=$(( $i + 1))
>  done
> 
> -nbd-client $preopts "$nbdserver" "$nbdport" /dev/nbd0 $opts || exit 1
> +nbd-client $preopts "$nbdserver" $nbdport /dev/nbd0 $opts || exit 1
> 
>  # If we didn't get a root= on the command line, then we need to
>  # add the udev rules for mounting the nbd0 device

applied, thanks!
