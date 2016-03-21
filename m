From: Ronit Halder <ronit.crj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: "kdumpbase" dracut module
Date: Mon, 21 Mar 2016 19:25:15 +0530
Message-ID: <CAAm8cU6EaVwQPV5wwy5PXeEShtEfscTz-vAOOxmZWP56YDgNSg@mail.gmail.com>
References: <CACeEjSL0jrqF9WtX3mZrO0036pGc4O4aPg+=JPMOB7QH47DLWA@mail.gmail.com>
	<20160321062655.GA9896@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=2qnekYQL/RFHFssOVIsAI9aI5HW0ev77lZ/OUg6N2zg=;
        b=kI6q6xwGvE3OO46eKTDPmh0vkW2Nmeyt+WuYDrrExbUg4ab7km3297lzm/sTF6t/a0
         IkxEplFg2BWHw37Bgff3TXOyERI017tuz5Fmx92SUlyc3CUHyOO1y5CNQv+3E3BgqwAN
         sLLALBLI5HpdXWxP6USjl3OQpm6+/o/Av9qLUsw2Q4BgtlD4/rPEapc+c9+Xrp3yUMAf
         zaDGFPuq7bdxCNfJN6ETTcfpLJghr6uB+xVZuq/C/SPwVCfiGz9Yj7I7wpQu6/FoM5ph
         u1fVBugV/JiW9oYnMw9AePhXb7xBgsafje3UGeII83Z5zewTThZ1fkE9AsWYsRzkf1Tj
         3iQg==
In-Reply-To: <20160321062655.GA9896-0VdLhd/A9Pl+NNSt+8eSiB/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ronit Halder <ronit.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernelnewbies <kernelnewbies-7JyXY6prKcjpASu1u0TL5ti2O/JbrIOy@public.gmane.org>

Thanks for helping

So, this module is used to dump the crash kernel.
Am I right?
If not then can you explain how kdump kernel calls the makedumpfile?
