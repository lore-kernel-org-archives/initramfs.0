From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 1/3] Handle upper case MAC addresses in ifname option
Date: Thu, 29 Dec 2011 04:06:36 -0500
Message-ID: <1325149596.19896.15.camel@obelisk.thedillows.org>
References: <20111226220903.564739340@samba.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111226220903.564739340-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2011-12-27 at 09:08 +1100, Anton Blanchard wrote:
> --- dracut.orig/modules.d/40network/parse-ifname.sh	2011-12-27 09:01:08.000000000 +1100
> +++ dracut/modules.d/40network/parse-ifname.sh	2011-12-27 09:02:05.420745541 +1100
> @@ -25,7 +25,8 @@ parse_ifname_opts() {
>      case $# in
>          7)
>              ifname_if=$1
> -            ifname_mac=$2:$3:$4:$5:$6:$7
> +            # udev requires MAC addresses to be lower case
> +            ifname_mac=`echo $2:$3:$4:$5:$6:$7 | tr '[:upper:]' '[:lower:]'`

Admittedly, I've not checked the latest git version, but dracut doesn't
install 'tr' to the initramfs, at least not in RHEL 6.

Dave
