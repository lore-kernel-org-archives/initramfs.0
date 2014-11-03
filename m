From: Orion Poplawski <orion-CVdf0l11yl+B+jHODAdFcQ@public.gmane.org>
Subject: Re: Question about netmask format
Date: Mon, 03 Nov 2014 12:08:02 -0700
Message-ID: <5457D292.806@cora.nwra.com>
References: <loom.20141014T001540-462@post.gmane.org> <5449FB04.9030803@redhat.com> <5453BEE5.3030908@cora.nwra.com> <545766EC.9020408@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cora.nwra.com;
	s=default; t=1415041683;
	bh=BqApcH2H6d66BUpu9Ske/txZLjIawGu1N7iHOTuHm1g=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=kzDATD+4mlFNk4QmShJIFBIgzDnph1sRU5L3KHPcMZMl390GdRu9A+yLcAK+GNBoG
	 PsbUzncN4T9oIZgtbMG/xXS4qdIDivxJB7+lJy7s+9n+yGrTc3mo3wjQDtV0AuP+/+
	 jLlSWR1F5GgBD1MMeOCRsFH7aA6fkPPF3loilyAY=
In-Reply-To: <545766EC.9020408-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/03/2014 04:28 AM, Harald Hoyer wrote:
> 
> add "rd.debug" to the kernel cmdline.
> 
> Then inspect /run/initramfs/rdsosreport.txt
> 

Turns out I had 255.255.225.224 instead of 255.255.255.224.  Finally started
at it enough to catch it.  Sorry for the noise.

-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion-CfuHcwXVrUc@public.gmane.org
Boulder, CO 80301                   http://www.nwra.com
