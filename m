From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: small 90mdraid fixups, v2 info update
Date: Fri, 23 Sep 2011 09:34:35 +0200
Message-ID: <4E7C368B.5040903@redhat.com>
References: <1316733173-21157-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316733173-21157-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 23.09.2011 01:12, Michal Soltys wrote:
> Before v2 (which is in large part a rewrite), these 3 fixes:
> 
> 1) *_raid_member checks are too generic, as blkid can report many more than
>    just ddf/isw/linux native raid members - so go back to older approach
> 2) more thorough removal of incremental assembly from stock
>    rules
> 3) include md_d devices in loops
> 
> The following changes since commit 08769b7f8a9efc57cd95d1f81e8aaf1a48db0d28:
> 
>   dracut-functions: inst_rules() add missing "" (2011-09-22 16:14:38 +0200)
> 
> are available in the git repository at:
>   git://git.hasevolq.net/dracut.git fixup
> 
> Michal Soltys (3):
>       90mdraid: check precisely for supported contaiers
>       90mdraid: more thorough 64-md-raid.rules edit
>       90mdraid: adjust /dev/md loops
> 
>  modules.d/90mdraid/65-md-incremental-imsm.rules |    7 +++++--
>  modules.d/90mdraid/mdraid-cleanup.sh            |    2 +-
>  modules.d/90mdraid/mdraid_start.sh              |    2 +-
>  modules.d/90mdraid/module-setup.sh              |    4 ++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> 

all sane and pushed...
