From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] Avoid generating udev rules for vlan interface
Date: Tue, 22 May 2012 09:43:37 +0800
Message-ID: <4FBAEF49.60108@gmail.com>
References: <1337591686-31875-1-git-send-email-amwang@redhat.com> <1337591686-31875-3-git-send-email-amwang@redhat.com> <4FBA09F7.4030003@redhat.com> <4FBA0B8D.1070708@gmail.com> <4FBA0E7E.1070004@redhat.com> <4FBA1698.3090006@gmail.com> <4FBA26A1.6010109@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hNsylEhcjNtdzd3xpGs6v6dQvgdX5ht9a46Lo9cC6Rc=;
        b=iZ3grtFY8McZzTb0J53JVyxNoyrPT4S0T2S6Gg2e2KqLufUxmnhXbQ7o8y648RlzWy
         /YKcyLdY9Z3tk2x97OczpUltxVLZl8TEsdjsds8QU6fnWA8iuiPivnbwITwHzWAKrgRh
         7KWmd6cfJNprx4WBEIhhDRgdZlmw5BztW5vQKqBCIdC0Qc6ktnFIdvDgo6Z3aWCBtaPW
         r9LZAJ4ogZG46Ktqylyk48gwt2H1TW1pip2cZggIDJjZxPAkp2pXgGTKI8mSDitzo8xn
         QZTdn6fpadeHB058d4KdtZY04oxf4xa52fvRbqA4MSOcgNwDLW1X33+cKWhA6nkUBjUA
         8YTA==
In-Reply-To: <4FBA26A1.6010109-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Cong Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 05/21/2012 07:27 PM, Harald Hoyer wrote:!
>
> it would skip eth0.2, because its DEVPATH contains "virtual" and the rule is
> never matched

When eth0.2 comes up, yes.

When eth0 comes up, no, both lines will be applied to eth0 and the final 
result is that eth0 will be renamed to eth0.2.

And eth0 comes up before eth0.2, so...
