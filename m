From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Thu, 14 Nov 2013 10:08:20 +0100
Message-ID: <52849304.5000608@gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>	<52830E31.30107@gmail.com>	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>	<5283AEA4.9050209@colin.guthr.ie>	<CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>	<5283B76B.8070902@colin.guthr.ie>	<CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>	<CAN_LGv08+8fmvqdz2afiuuET2cJLC9diGDMn6mtc904rdJGMog@mail.gmail.com>	<5283C886.10300@colin.guthr.ie>	<CAN_LGv18zK37_35F23XG7SkhEMMat0VVOxv3yoNMXzG4nUCZNg@mail.gmail.com> <52848565.6020303@colin.guthr.ie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vdZpFJ0cNIll46r+b6CCVfPtCbClY4V0d77dqKvuIDQ=;
        b=dlrShhtOalG23Sh6xjUQgk9g+4MUcuvRz01ypz7Xyd286k4x3B05e77j2jB5eVVm5o
         MQGTlkRXPqibx73gR2Hx4h3KBXmIVmDqdJ4fk5yCb74ZbjFMuECHlTyK0Uj+BmYCKcFz
         XpjaX24j/vUZN1u3FmX1mRmrFcfeQykavPbBRcNEuUVy5yif484J3D76Lr1uquog/V/r
         3Bg0V9BGBUR9dUdMY1vUHqXF0ctGGu5+P+qVuvGdRBh469FkU/Eqe+iSnIIKXvsqJPXK
         dKQdE64vS3laAAixLCDRO6iDm7xt4nCfDQNhSLK6MTrWa4MCDAarThquwb+AoU+YqsQQ
         fxkQ==
In-Reply-To: <52848565.6020303-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>, "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

On 11/14/2013 09:10 AM, Colin Guthrie wrote:
> 'Twas brillig, and Alexander E. Patrakov at 13/11/13 19:02 did gyre and
> gimble:
>> 2013/11/14 Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>:
>>> What kernel are you using out of interest?
>>
>> This kernel is a git snapshot between 3.12.0-rc2 and -rc3. Compiled on Gentoo.
> 
> Thanks for that.
> 
> After trying harder, it seems my initial suspicion on the bug report was
> correct after all and a missing host controller driver is the culprit.
> 
> For reference dracut is not including ohci-pci which I presume has been
> split out recently and thus needs to be added explicitly.
> 
> Alexander's tests perhaps used a different type of USB host controller.
> 
> Will send a dracut patch shortly and sorry for the noise.
> 
> Col

http://git.kernel.org/cgit/boot/dracut/dracut.git/commit/?id=28609baf6e9581ea97c4550340e2a6031c1b6fbd
