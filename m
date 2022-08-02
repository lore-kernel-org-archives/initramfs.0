From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: Re: [PATCH v2] dracut: dmsquash-live: overlay module can be built-in
 the kernel
Date: Tue, 2 Aug 2022 15:51:40 +0200
Message-ID: <20220802135140.lxdgwvqkp56j6t4m@pcbe17027.cern.ch>
References: <20220518094707.943732-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CcLw99xsKJ7u898rvQOb8/0TOFnRM7GMuhdR1DXous=;
 b=MDpg8vLRRtWFmSwdMHAWFz0Np1Ybm+GCAbBAifE5eSB0jGTaJWhLANVfkhvxb+7DG7Zk3FprMc9BNT46ZeUjs0YxPTqOZSnlwP3cnJJQWv9BMHeVlQ+IJk+JnZR4fJ+EL26yeSdwMMvuXqj7bqBmeIvGjv917DvdKAieza3lpf4=
Content-Disposition: inline
In-Reply-To: <20220518094707.943732-1-federico.vaga-vJEk5272eHo@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I've never got a feedback on this patch. Will it be integrated?

Thanks

On Wed, May 18, 2022 at 11:47:07AM +0200, Federico Vaga wrote:
>The dmsquash-live module assumes that `overlay` is always a module.
>Therefore, when `overlay` is built-in the kernel, this module will fail
>to detect the presence of such a feature.
>
>This patch adds a fallback mechanism to check also `/proc/filesystem`.
>This is also what happens with the dracut NSF module when loading the
>kernel module `rpc_pipefs`.
>
>Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
>---
> v1 -> v2: do not use unnecessary sub-shell in the if statement
>
> modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>index fd8a858a..f68a979c 100755
>--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>@@ -170,7 +170,7 @@ do_live_overlay() {
>         fi
>     fi
>     if [ -n "$overlayfs" ]; then
>-        if ! modprobe overlay; then
>+        if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then
>             if [ "$overlayfs" = required ]; then
>                 die "OverlayFS is required but not available."
>                 exit 1
>-- 
>2.27.0
>

-- 
-------------------------------
Federico Vaga - CERN BE-CEM-EDL
