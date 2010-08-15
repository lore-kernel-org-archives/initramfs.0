From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: [PATCH 01/16] Trivial cleanups in dracut-functions
Date: Sun, 15 Aug 2010 11:10:56 +0200
Message-ID: <20100815091056.GA649@maude.comedia.it>
References: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <170ac6ad6189b7d7d31610a797d059d590807484.1281812505.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, Aug 14, 2010 at 02:23:24PM -0500, Victor Lowther wrote:
>-    if [[ -f "/sys/dev/block/$2/../dev" ]]; then
>+    if [[ -f /sys/dev/block/$2/../dev ]]; then

I fail to see any advantages in removing quotes from patterns,
on the contrary i think it could lead to weird failures.

if it were me i'd add quotes where they are missing instead.

L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
