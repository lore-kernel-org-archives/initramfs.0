From: Wim Muskee <wimmuskee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: NFS mount problem since 017
Date: Tue, 27 Mar 2012 19:43:44 +0200
Message-ID: <CAKzfqkd2gKs6fE593jTpQBFwbs-PTwR3oZ=aJh5DyoESd8C=0g@mail.gmail.com>
References: <CAKzfqkd3hGyqhVvfdSFg7=R595cEjy0gNpnwmBcHQnUXOxbkOA@mail.gmail.com>
	<20120319082324.GA29521@x2.net.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Qw4c7yFk5U+jxI92hMMDpbZbZgP+1dEd570bxmGBuSs=;
        b=DNNaMPANs2xDCW5pM4vYv8PC8crL1t2Pt1NsSl+VSgGrF5wCKv7kSESBfNsF2nXKxa
         3UGRu7LlQzrAMIsS2OXSvCnhTKI9uZ4qytjoud26MDTTjO1qVBUzm2p5tfzOG5ZrJent
         h7BYS/vEQ24rM82TxkLFxgKTATypVl4D5o5fbrrPCzepLDjBnuOvSPZasEG1EtQi8jHB
         LZOU1EvPFM9ksouUDIZPlifPdTpZ0bYv12cNHt12Dy+GktiXrz7SaLHX+RFFajflLDK8
         u1HuNCgE6LtJhL3Ea1WljxrwwP2nJOC69w1CNW33hOV70HwbAV7EsnxXonCPs0c94lud
         2Xkg==
In-Reply-To: <20120319082324.GA29521-s5vVilr7EKH/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> =A0is it the new mount from =A0util-linux 2.21? Please, cut & past mo=
unt
> =A0-V, it would be also nice to have the mount command line with all
> =A0arguments.
>
Nope, using util-linux-2.20.1-r2 on Gentoo
$ mount -V
mount from util-linux 2.20.1 (with libblkid support)

The full mount command is:
mount -t nfs -oro,nolock 192.168.0.1:/opt/ltsp-dev/i686 /sysroot
