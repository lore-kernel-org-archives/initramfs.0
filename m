From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: dracut
Date: Fri, 22 Oct 2010 12:35:47 +0100
Message-ID: <4CC17713.4030504@googlemail.com>
References: <4CBDA328.40401@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=768xxlMeOQF1KV+5eT/8XM4avIvF+DX6oNpH3bevwj8=;
        b=Fj/+fC1eaOLUrlAZnX83mqxZxGRZRxl267Rehx6H7JYTXwl0FB2TSKv9XaaedxbLjP
         uEo50YqoPDbM13aMlvWd4fPYbMJwwvyiv5YNIiaXFl2hKq3S0LT4cOOcWOmMyqQXeQuq
         t8ZVYnzL7mabBBICLNrI17066OC2Bgnb7oQS8=
In-Reply-To: <4CBDA328.40401-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Is it possible to build dracut for system/architecture which is 
different from the host on which dracut is run?

I have been looking through the various functions dracut provides 
(inst_binary in particular) and it seems that dracut picks-up 
dependencies/libraries/kernel modules and files on the host machine when 
building the initrd image, which to me indicates that the resulting 
initrd image is tied to the current kernel/architecture on which the 
host is run and cross-building won't be possible.
