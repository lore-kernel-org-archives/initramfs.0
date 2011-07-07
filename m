From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/4] new dracut modules
Date: Thu, 07 Jul 2011 09:53:22 -0400
Message-ID: <1310046803.3356.22.camel@localhost.localdomain>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1309882990-2828-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On Tue, 2011-07-05 at 18:23 +0200, Roberto Sassu wrote:
> Hi all
> 
> this patch set introduces three new modules (masterkey, integrity and
> ecryptfs) and allows to mount the securityfs filesystem from the initial
> ramdisk.
> 
> These patches are based upon the first version sent by Mimi Zohar, which
> can be retrieved at the address:
> 
> http://article.gmane.org/gmane.linux.kernel.initramfs/1910
> 
> Roberto Sassu 

Nice!  Thanks Roberto for updating the modules. They're look really
good.

One really minor issue is that although the user can override the
default masterkey blob filename, using a boot command line option, the
default filename is kernel version specific.  Until the tools are
available to create and seal keys to a set of PCRs, as we discussed,
perhaps there should be an additional filename default, without the
kernel version appended, as well.

thanks,  

Mimi
