From: maximilian attems <max-U9r9yeDMy7A@public.gmane.org>
Subject: Re: New rd.* namespace for dracut-008
Date: Thu, 28 Oct 2010 15:46:04 +0000
Message-ID: <20101028154604.GA32323@vostochny.stro.at>
References: <4CC99414.5060607@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CC99414.5060607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Oct 28, 2010 at 05:17:40PM +0200, Harald Hoyer wrote:
> I cleaned up the kernel command line parameters and moved them to the 
> rd.* namespace. The deprecated options are supported until dracut-010 and 
> will be removed afterwards.
>

hmm as initramfs-tools hasn't cleaned up it's namespace yet,
this is a good point to jump in ask more details:

* what does rd stand for?

* is it envisaged to be used by other tools
  (or should initramfs-tools use it.break)?

I'd appreciated more info on the background of this move as
it can't be painless.

thanks.

-- 
maks
