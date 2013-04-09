From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] ifup.sh: Add support for bridge over a vlan tagged interface
Date: Tue, 09 Apr 2013 14:40:43 +0200
Message-ID: <51640C4B.7000103@redhat.com>
References: <1365505000-4831-1-git-send-email-chaowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365505000-4831-1-git-send-email-chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 09.04.2013 12:56, schrieb WANG Chao:
> This patch add support for bridge a vlan tagged interface, like
> br0 -> bond0.7 -> bond0 -> eth0
> 
> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> Hi, Harald
> 
> I tested it in F19 with br0->bond0.7->bond0->eth0 and network is expected in
> 2nd kernel.
> 
> Thanks

applied
