From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] introduce optional job control
Date: Tue, 18 Oct 2011 09:52:31 +0000 (UTC)
Message-ID: <j7ji8v$p6b$1@dough.gmane.org>
References: <1318885310-12535-2-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 17 Oct 2011 23:01:50 +0200, Michal Soltys wrote:

> Option --ctty will optionally add setsid binary to dracut's image.
> 
> During runtime, if rd.ctty is set and is a character device, emergency
> shells will be spawned with job control.
> 

Hi,

Please also update dracut.8.xml.

Thanks.
