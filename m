From: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 0/4] new dracut modules
Date: Thu, 7 Jul 2011 16:41:38 +0200
Message-ID: <201107071641.38666.roberto.sassu@polito.it>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it> <201107071614.39627.roberto.sassu@polito.it> <1310049731.3356.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id; s=smtpout; bh=JehsJp5UnVbsAOye6146mUxZmqY=; b=eAfxChru/I6GD/3bgbQNXVxBtxi3+8c7GbHJ/Tf6E7ik1ErItYGPgN25WAlnHiTu0Fd+c8sb3jqSWGc97ppvHrXSChmGCmbs/JdbL5OqRLhvMoFo2P13gUQU+GjuDtUE45pL9BYD1L2KKybAyFnFZw4auCV9Tn/tJoI0Y1eE018=
In-Reply-To: <1310049731.3356.24.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On Thursday, July 07, 2011 04:42:11 PM Mimi Zohar wrote:
> On Thu, 2011-07-07 at 16:14 +0200, Roberto Sassu wrote:
> > On Thursday, July 07, 2011 03:53:22 PM Mimi Zohar wrote:
> > > On Tue, 2011-07-05 at 18:23 +0200, Roberto Sassu wrote:
> > > > Hi all
> > > > 
> > > > this patch set introduces three new modules (masterkey, integrity and
> > > > ecryptfs) and allows to mount the securityfs filesystem from the initial
> > > > ramdisk.
> > > > 
> > > > These patches are based upon the first version sent by Mimi Zohar, which
> > > > can be retrieved at the address:
> > > > 
> > > > http://article.gmane.org/gmane.linux.kernel.initramfs/1910
> > > > 
> > > > Roberto Sassu 
> > > 
> > > Nice!  Thanks Roberto for updating the modules. They're look really
> > > good.
> > > 
> > > One really minor issue is that although the user can override the
> > > default masterkey blob filename, using a boot command line option, the
> > > default filename is kernel version specific.  Until the tools are
> > > available to create and seal keys to a set of PCRs, as we discussed,
> > > perhaps there should be an additional filename default, without the
> > > kernel version appended, as well.
> > > 
> > 
> > Hi Mimi
> > 
> > thanks.
> > I think we can solve this issue by adding a new option, called
> > 'MULTIKERNELMODE', which can be used to decide if the kernel
> > version should be added to the default masterkey filename or
> > not. By default, we can set its value to 'NO'.
> > 
> > Roberto Sassu
> 
> Sounds good.
> 

Ok, i'll wait other comments before reposting patches.

Roberto Sassu


> thanks,
> 
> Mimi
> 
> 
