From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Thu, 14 Nov 2013 01:02:48 +0600
Message-ID: <CAN_LGv18zK37_35F23XG7SkhEMMat0VVOxv3yoNMXzG4nUCZNg@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
	<52830E31.30107@gmail.com>
	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
	<5283AEA4.9050209@colin.guthr.ie>
	<CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>
	<5283B76B.8070902@colin.guthr.ie>
	<CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>
	<CAN_LGv08+8fmvqdz2afiuuET2cJLC9diGDMn6mtc904rdJGMog@mail.gmail.com>
	<5283C886.10300@colin.guthr.ie>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1X7MXze35mY5RzXrAW873pVxHMrnmRwBl94PATLkMMs=;
        b=ULE07ccRsZWWxohDlSvKPWMobsg8bzysOFm6uC+KLWbYHgEqvzufqKcLTiCymN0REC
         kxn2cw04kmuAapDGJ0kxdDLB6mbAhQrQHfWl846CBy/3vliklXL9r85ODZa/sxXPnNT/
         zlfwz7HLB76io4Cd8VmqnSUDvGLzVHPdQVQlEc5kwUkFFkvmI6pYtUANb+O1p8w5Ybct
         aBxHAHpns96vrGnTPAKbn7bJFBecgN3+W9/zmdvS1kN6fwexC97TdeKJyVOkdPDeut6K
         dFEONaNF1BOB579ERwSPVXMKLIVAWR2q9qgrXWnUc8lUZfOHynMc6w4WMvQEwnHDkgwO
         +YlA==
In-Reply-To: <5283C886.10300-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd Mailing List <systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

2013/11/14 Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>:
> What kernel are you using out of interest?

This kernel is a git snapshot between 3.12.0-rc2 and -rc3. Compiled on Gentoo.

-- 
Alexander E. Patrakov
