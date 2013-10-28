From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Mon, 28 Oct 2013 17:19:37 +0100
Message-ID: <526E8E99.2020702@redhat.com>
References: <5253DD0C.7050506@redhat.com>	<l4dk8e$fv8$1@ger.gmane.org>	<526A7412.8030804@redhat.com> <20131028134216.049c6a01@work.puleglot> <l4lvht$4jh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <l4lvht$4jh$1@ger.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/28/2013 04:23 PM, Colin Guthrie wrote:

> That being the case, I would propose that the usrmount module be
> automatically included when /usr is a mount point regardless of on which
> partition init lives?

Might be the safest option to include it in all non-systemd setups.
