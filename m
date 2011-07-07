From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 0/4] new dracut modules
Date: Thu, 7 Jul 2011 10:44:31 +0200
Message-ID: <201107071044.31979.roberto.sassu@polito.it>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it> <4E156E82.1060602@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id; s=smtpout; bh=PM5WEA6/2+nEijOU5w4jahgn+0E=; b=jHcO5XP6QOeKypWCaihPhgF1FMnh7d0jBphNkahdG0ks2MXurOTo4XDzJH7P5TyldqCs1vFfYtMGFkQa5dwlc+NxiETqG7czWJ3o9xAPkBmGTqXO8yx+NK0bPlHCklrXKjBw/5zY1LOEA9XzexwJ6zsM+3Q7IYXdBTdvMk3XF20=
In-Reply-To: <4E156E82.1060602-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On Thursday, July 07, 2011 10:29:54 AM Harald Hoyer wrote:
> On 05.07.2011 18:23, Roberto Sassu wrote:
> > Hi all
> > 
> > this patch set introduces three new modules (masterkey, integrity and
> > ecryptfs) and allows to mount the securityfs filesystem from the initial
> > ramdisk.
> > 
> > These patches are based upon the first version sent by Mimi Zohar, which
> > can be retrieved at the address:
> > 
> > http://article.gmane.org/gmane.linux.kernel.initramfs/1910
> > 
> > Roberto Sassu 
> > 
> 
> Why did you split it into three dracut modules?
> Personally, I would put it into one single module.
> 

Hi Harald

i've split the scripts in three modules because 'masterkey'
initializes a kernel key which can be further used by other
dracut modules, like 'integrity' and 'ecryptfs'.
Another reason is that the last two do completely different
things (the former initializes the EVM framework, the latter
mounts an eCryptfs filesystem).

Roberto Sassu
