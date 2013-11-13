From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 0/2] (dracut) hwdb needed in early boot
 for some keyboards
Date: Wed, 13 Nov 2013 23:55:53 +0600
Message-ID: <CAN_LGv08+8fmvqdz2afiuuET2cJLC9diGDMn6mtc904rdJGMog@mail.gmail.com>
References: <1384249140-20683-1-git-send-email-colin@mageia.org>
	<52830E31.30107@gmail.com>
	<CAN_LGv2h3jYopc4xBn+206MpdoeEzB6Hy3iBqPw4eqvcuOPQ-A@mail.gmail.com>
	<5283AEA4.9050209@colin.guthr.ie>
	<CAN_LGv2H3pDZ+Sp6LpxkN+Ay_4LbZbR4Av1_j0B2WLO=TcxvAw@mail.gmail.com>
	<5283B76B.8070902@colin.guthr.ie>
	<CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=/nFXjd88zeGQXI5gmjd9x2vm1hD05Se9NiRS8Vug210=;
	b=TFnaHL4GBL7VFiuTQd85F2M4jVC4eb+VfI9W5cyKhXk6jn/KsoIa1eo76HXI7hWwq4
	o4M9HU29JZnlbCRRGAvi2PZficaZotr+52U4b1hY38Gw2GeCSK9p38MFzenn0eBx4YHM
	fSWmWRnNJnrhaFQsrXdOassXYz3uK8FEssfH8VSvEvrQL18Q1owiIDzQBlAd9dY7+6Tl
	NncbqDeQlssnrrLwp2TwB4YHws4yc2QjbZarcKMCsrVm1ly44OoG/NzOwubuY9aBxE+J
	2O37G+U3HTJo3juUdyQne2B3yc9QxttsIFIvL28rEfdU2S+6L99jAsc5qZ1cbW3c6X0o
	npng==
In-Reply-To: <CAN_LGv0XtGtsweN1AmRY26rrXNo7BL3GEOc3xPZOq_qhzOJP5g@mail.gmail.com>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces@lists.freedesktop.org
Errors-To: systemd-devel-bounces@lists.freedesktop.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: initramfs@vger.kernel.org, systemd Mailing List <systemd-devel@lists.freedesktop.org>

2013/11/13 Alexander E. Patrakov <patrakov@gmail.com>:
> 2013/11/13 Colin Guthrie <gmane@colin.guthr.ie>:
>> What about if you generate it with the keyboard plugged in? It should
>> include the usbhid module then, but does it actually work?
>
> Will try a bit later, but I suspect this is the wrong direction of thought.

A host-only initramfs generated with the USB keyboard plugged in works.

-- 
Alexander E. Patrakov
