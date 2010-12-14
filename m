From: Matt Domsch <Matt_Domsch-8PEkshWhKlo@public.gmane.org>
Subject: Re: [PATCH] include biosdevname calls in dracut
Date: Tue, 14 Dec 2010 13:58:07 -0600
Message-ID: <20101214195807.GB31714@auslistsprd01.us.dell.com>
References: <20101206005229.GA687@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101206005229.GA687-fZmvIyTar7vbK7CpiBUVEGyRm/Zj/t/4AL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Dec 05, 2010 at 06:52:29PM -0600, Matt Domsch wrote:
> For your consideration.  This allows biosdevname to be called from
> network-using functions in dracut.  biosdevname is included in Fedora
> 15, and there are tickets open to include it in other distros.

Any thoughts on this patch?

Thanks,
Matt

-- 
Matt Domsch
Technology Strategist
Dell | Office of the CTO
