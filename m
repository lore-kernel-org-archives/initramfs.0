From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: crypt-cleanup.sh question
Date: Tue, 26 Oct 2010 15:37:53 +0100
Message-ID: <4CC6E7C1.1050703@googlemail.com>
References: <4CC6C571.8010406@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nfaprQysj7vkQP33PkmlGG7bVhO+E6e+Id4fETxl6eY=;
        b=SKBZummMBUutaaNYg+dLIcQI9o1NeL/UK+Sd94JizMBGZouf1DTgWA/9w9noZC2k08
         LJwzviR6P+QHrnw1bQs4U4vakEi/xup4cjC+ez/rvfh48sF0LaxlJQPzlTXC/cjeBsKl
         ZcqoijncW/WbKUmIhjCc1bIn2rOwUOHW94/Lo=
In-Reply-To: <4CC6C571.8010406-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


> What is the rationale behind closing all /dev/mapper/luks-* devices 
> which are not 'busy' in this shell script? Why would they have to be 
> 'busy' (I presume already mapped) to be left open?
>
> I am asking this because when the smartcard module opens a LUKS drive 
> (not root - '/') - this drive later to be mapped from the actual root 
> /etc/fstab file as '/dev/mapper/luks-XXX /some/directory' - this 
> operation does not succeed and I presume crypt-cleanup.sh closes it up 
> before the actual root can get it and therefore it cannot be mapped.
Further to the above, I was able to verify that the above script is 
indeed to blame for closing LUKS partitions. The only 'busy' partition 
at the time crypt-cleanup.sh runs is the root (/sysroot) so I don't see 
how a LUKS partition (other than root) specified at the kernel command 
line could be opened, unless I am missing something obvious...
