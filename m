From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] crypt/parse-crypt.sh: hide encrypted devices from
 systemd timeout warnings.
Date: Thu, 26 Mar 2015 12:51:49 +0100
Message-ID: <5513F2D5.6050205@redhat.com>
References: <20150326043938.10121.34223.stgit@notabene.brown> <20150326044148.10121.15286.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326044148.10121.15286.stgit-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26.03.2015 05:41, NeilBrown wrote:
> When systemd's crypttab generator parsed crypttab, it tells systemd about 
> several devices which may not appear until later in the boot sequence,
> and which are not needed while dract is running.
> 
> This can particularly happen when an md array is encrypted, and the array 
> is newly degraded so that it doesn't appear until dracut runs 
> mdraid_start.sh.
> 
> This can result in systemd printing warning messages which are 
> inappropriate.
> 
> So tell systemd that the timeout for each of these is zero.
> 
> This is involves splitting some functionality out of wait_for_dev()
> 
> That function does two things: - creates 'finished' hooks so that dracut 
> will wait for the device, and - sets the systemd timeout for the device
> to zero, so systemd doesn't wait.
> 
> We only want the second of these for most encrypted devices. So split
> that out into a new function set_systemd_timeout_for_dev(), and call it
> from parse-crypt.sh
> 
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> --- 
> modules.d/90crypt/parse-crypt.sh |    4 +++
> modules.d/99base/dracut-lib.sh |   53
> ++++++++++++++++++++++++-------------- 2 files changed, 38 insertions(+),
> 19 deletions(-)
> 
> diff --git a/modules.d/90crypt/parse-crypt.sh 
> b/modules.d/90crypt/parse-crypt.sh index 94ad1f63ae6f..5a64652cc51c 100755
> --- a/modules.d/90crypt/parse-crypt.sh +++ 
> b/modules.d/90crypt/parse-crypt.sh @@ -14,6 +14,10 @@ else LUKS=$(getargs 
> rd.luks.uuid -d rd_LUKS_UUID) tout=$(getarg rd.luks.key.tout)
> 
> +    while read _dev _uuid ; do +        set_systemd_timeout_for_dev $_dev
> +    done +

missing redirector from /etc/crypttab I guess


