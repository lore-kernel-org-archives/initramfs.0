From: Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 0/4] new dracut modules
Date: Fri, 08 Jul 2011 14:33:46 -0400
Message-ID: <1310150026.3309.6.camel@localhost.localdomain>
References: <1310127065-23292-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310127065-23292-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On Fri, 2011-07-08 at 14:10 +0200, Roberto Sassu wrote:
> Hi all
> 
> i'm reposting the patch set which allows to mount the securityfs filesystem
> from the initial ramdisk and introduces three new modules: masterkey,
> integrity and ecryptfs.
> 
> Changelog from version v2:
> * masterkey: added MULTIKERNELMODE configuration variable;
> * {masterkey,integrity, ecryptfs}: modified some debug messages for better
>   clarity;
> * ecryptfs: ECRYPTFS_EXTRA_MOUNT_OPTS configuration variable set to empty;
> * ecryptfs: replaced ECRYPTFSDIR with ECRYPTFSSRCDIR and ECRYPTFSDSTDIR.
> 
> Roberto Sassu

Nice! For patches 1 - 3,

Acked-by: Mimi Zohar <zohar-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

thanks,

Mimi
