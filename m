From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: HELP needed: dracut 049: initqueue/online hook never triggered?
Date: Mon, 30 Mar 2020 15:32:13 +0200
Message-ID: <45382e5d-0dbe-9761-2f99-ebb221b59a47@gmail.com>
References: <D54C3CCB-D8A5-414E-876C-0FCE6AFCFFE4@cea.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Lm9zQt0/6tbS3DKeYMEFGwT/dzoeXNf99QnzleVfWJQ=;
        b=kKoNGi1rhxFDgD9Srt3VqQOLC79KX1eXSHcZN7gdtmFhzanha4WjVC4cMz8YaQyvIh
         bWaOJbvYERdO8jY6yEsyBDQHAXxm5AzjePJrhfok1AEN2nzclLo8cllJiVhrbjD/zcLM
         MWgTtcleRyVjH+L160ocKdVjTALLKPpvuMQz3NflnXZP2X7H81Zy6VfiiM5IpYthS5IF
         SRD8W7p5Xt+JsrNC/AFnHvV4VrHCRS3AQPcgMc+sTkM/CPnnudjcCR0Zg5vK1w0UnHgv
         mQ62PsPb2S3Gu94NTNyOMQ+w9559lP4mfjB3+sSLMujDkTmLVE0nHH+5uWpXm4Xej7Im
         6cJA==
In-Reply-To: <D54C3CCB-D8A5-414E-876C-0FCE6AFCFFE4-KCE40YydGKI@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: LAHAYE Olivier <olivier.lahaye-KCE40YydGKI@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Am 09.03.20 um 14:02 schrieb LAHAYE Olivier:
> Hi,
>  
> My module requires initqueue/online queue to be run. It works fine on CentOS-7, but fails on CentOS-8.1 (dracut-049-27.git20190906.el8_1.1.x86_64)
> In fact it fails on all dracut version that have the 40network module split with 35network-legacy and 35network-manager.
>  
> On CentOS-8.1, by default, 40network uses 35network-manager which is fine, but then, I see no code that would run the initqueue/online hook in either 40network or 35network-manager (nor in 98systemd). Am I missing something?
>  
> My systemimager dracut module supports dracut from CentOS-6 (where I use udev to simulate online hook) to CentOS-8.0 which still run the online hook.
>  
> I’d like to avoid requiring 35network-legacy for multiple reasons:
> • I don’t know how to require it only on CentOS-8.1 (make it optional)
> • I don’t know how to finish boot using networkmanager if I start with legacy mode
> • This legacy option won’t last forever…
> I’d also like to avoid doing the same trick as I do on CentOS-6, playing with udev rules.
>  
> How do I have dracut do the following when using 45network-manager? (need initqueue is there and module module depends on network of course)
> • source_hook initqueue/online $netif
>  
> I did look into 80anaconda module, that uses /tmp/net.*.did-setup in online_netdevs, but I wonder how this file can exists when 35network-manager is used? (when timeout occurs and drops me to a shell,  I see /tmp as almost empty while my network is up…)
>  
> My module source: https://github.com/finley/SystemImager/tree/SystemImager-NG/lib/dracut/modules.d/51systemimager
>  
> Many thanks for help on that as I’m stuck for now :-/
>  
> --
> Olivier LAHAYE
> SystemImager developper.
> 
> 

This might be fixed with commit 3dcaa97ca4dcfa8092252a22df62c60941e59ce3

You might want to try dracut-050-26.* from Fedora 31 or 32 or rawhide.
