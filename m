From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 0/4] new dracut modules
Date: Fri, 12 Aug 2011 08:22:54 +0200
Message-ID: <4E44C6BE.1010506@redhat.com>
References: <1310127065-23292-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310127065-23292-1-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On 08.07.2011 14:10, Roberto Sassu wrote:
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
> 
> 
> Roberto Sassu (4):
>   base/init: mount the securityfs filesystem
>   dracut: added new module masterkey
>   dracut: added new module integrity
>   dracut: added new module ecryptfs
> 
>  dracut.kernel.7.xml                      |   29 +++++++++
>  modules.d/97masterkey/README             |   68 ++++++++++++++++++++
>  modules.d/97masterkey/masterkey.sh       |   75 ++++++++++++++++++++++
>  modules.d/97masterkey/module-setup.sh    |   25 ++++++++
>  modules.d/98ecryptfs/README              |   50 +++++++++++++++
>  modules.d/98ecryptfs/ecryptfs-mount.sh   |  100 ++++++++++++++++++++++++++++++
>  modules.d/98ecryptfs/module-setup.sh     |   20 ++++++
>  modules.d/98integrity/README             |   40 ++++++++++++
>  modules.d/98integrity/evm-enable.sh      |   91 +++++++++++++++++++++++++++
>  modules.d/98integrity/ima-policy-load.sh |   41 ++++++++++++
>  modules.d/98integrity/module-setup.sh    |   17 +++++
>  modules.d/99base/init                    |    6 ++
>  12 files changed, 562 insertions(+), 0 deletions(-)
>  create mode 100644 modules.d/97masterkey/README
>  create mode 100755 modules.d/97masterkey/masterkey.sh
>  create mode 100755 modules.d/97masterkey/module-setup.sh
>  create mode 100644 modules.d/98ecryptfs/README
>  create mode 100755 modules.d/98ecryptfs/ecryptfs-mount.sh
>  create mode 100755 modules.d/98ecryptfs/module-setup.sh
>  create mode 100644 modules.d/98integrity/README
>  create mode 100755 modules.d/98integrity/evm-enable.sh
>  create mode 100755 modules.d/98integrity/ima-policy-load.sh
>  create mode 100755 modules.d/98integrity/module-setup.sh
> 

pushed
