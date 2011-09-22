From: Harald Hoyer <harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 0/6] Update 90mdraid
Date: Thu, 22 Sep 2011 15:45:41 +0200
Message-ID: <4E7B3C05.9060905@gmail.com>
References: <1315261048-19544-1-git-send-email-soltys@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KPEeTtCaO17AKx0glAu33GDiuEbLPRmKqZZlgMoiVqQ=;
        b=BIyznsQTyjYyPdtjXhJx5lUPxsvkL7Kj6T9SdCeFNWTEGdcwTl0k/rWCLU1OIblZEs
         a4POq9nWGGHQ/3szjymDwU7b5cCvUEnxhoppMPoxr7zUQkP5iSnu22n2V1C3i5slTkyA
         tctTxl5N/30IOjDbO5O+o7HeJ0LKphVEutCoA=
In-Reply-To: <1315261048-19544-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06.09.2011 00:17, Michal Soltys wrote:
> This is a set of patches simplifying mdraid module, with a few fixes along the way.
> 
> 1)	90mdraid: adjust stock mdadm udev rules
> 2)	90(md|dm)raid: recognize ddf container
> 3)	90mdraid: containers are not runnable
> 4)	90mdraid: fix/adjust mdraid-cleanup
> 5)	90mdraid: fix/adjust force-run script
> 6)	90mdraid: fix/adjust 65-md* rules and related scripts
> 
> First 4 patches are pretty simple and could likely go in. In particular, 1st
> one has a fix for stock mdadm rules, which originally cause unconditional
> incremental assembly of all native+imsm components.
> 
> #4 - I'm still not sure, why exactly raid cleanup was called twice.
> 
> #5 and #6 are main part with more changes resulting with, subjecitvely,
> cleaner and shorter code. All the details and rationale are in respective
> commit messages.
> 
> It looks solid, but it's still work in progress and requires some
> testing. Comment if you have any objections or questions.
> 
> For convenience, it can be also pulled from:
>   git://git.hasevolq.net/dracut.git mdraid-fix-v1
> 
> 
> Michal Soltys (6):
>   90mdraid: adjust stock mdadm udev rules
>   90(md|dm)raid: recognize ddf container
>   90mdraid: containers are not runnable
>   90mdraid: fix/adjust mdraid-cleanup
>   90mdraid: fix/adjust force-run script
>   90mdraid: fix/adjust 65-md* rules and related scripts
> 
>  dracut.kernel.7.xml                             |    6 ++
>  modules.d/90dmraid/61-dmraid-imsm.rules         |    1 +
>  modules.d/90dmraid/parse-dm.sh                  |    4 +
>  modules.d/90mdraid/65-md-incremental-imsm.rules |   92 ++++++----------------
>  modules.d/90mdraid/md-noddf.sh                  |    5 +
>  modules.d/90mdraid/md-noimsm.sh                 |    2 +-
>  modules.d/90mdraid/md_finished.sh               |    9 --
>  modules.d/90mdraid/mdadm_auto.sh                |    2 +-
>  modules.d/90mdraid/mdcontainer_start.sh         |   12 ---
>  modules.d/90mdraid/mdraid-cleanup.sh            |   30 ++++---
>  modules.d/90mdraid/mdraid_start.sh              |   52 ++++++++-----
>  modules.d/90mdraid/module-setup.sh              |   15 +++-
>  modules.d/90mdraid/parse-md.sh                  |   15 +++-
>  13 files changed, 114 insertions(+), 131 deletions(-)
>  create mode 100755 modules.d/90mdraid/md-noddf.sh
>  delete mode 100755 modules.d/90mdraid/md_finished.sh
>  delete mode 100755 modules.d/90mdraid/mdcontainer_start.sh
> 


pushed to temporary git: http://git.surfsite.org/dracut.git
