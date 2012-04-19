From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] add pre-pivot-cleanup hook
Date: Thu, 19 Apr 2012 12:16:35 +0200
Message-ID: <4F8FE603.1040406@redhat.com>
References: <20120419040136.GA17472@localhost.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120419040136.GA17472-bi+AKbBUZKaljkADxpZm/1aTQe2KTcn/@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

Am 19.04.2012 06:01, schrieb Dave Young:
> Sometimes some hook script will need to be before the cleanup hook scripts
> For example dhclient killing, nfs cleanup, etc. must not happen before kdump
> because it will use their fuctionalities.
> 
> So here introduce a new hook pre-pivot-cleanup, all cleanup scripts will go there.
> that means pre-pivot hook is splited to two hooks pre-pivot and pre-pivot-cleanup
> 
> Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

pushed
