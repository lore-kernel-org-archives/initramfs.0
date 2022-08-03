From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] dracut: dmsquash-live: overlay module can be built-in
 the kernel
Date: Wed, 3 Aug 2022 13:41:32 -0400
Message-ID: <CAEcBt+VZ+_HasQMGCtW4VqQo3h_aN9MMVY4MtD8Ys4o42P-62Q@mail.gmail.com>
References: <20220518094707.943732-1-federico.vaga@cern.ch>
 <20220802135140.lxdgwvqkp56j6t4m@pcbe17027.cern.ch> <CAEcBt+WXEhVnXkiCesXhS7QqROFbpcMBoSqqamuAcH8yRFwgaQ@mail.gmail.com>
 <20220803151025.gvst5p2ymdcdfhif@pcbe17027.cern.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0kfC7xJlNPVpq/VBI4RhREpQoC5yKyEbwVrAd+WXBg=;
        b=m/5wwrHOTvv0F0H4n4LraZg3kAGU0ut+SKFY9xUkg6G9rinPhN45/8rekbsRmmaqJ7
         juKYn7Q11Iufc+rJCMwb0ng+T4PHmXfCGPPE7zXxcivemaoExBv1abWhDKIXBE4BWkAU
         a+65CJwKlgqfMSH6Jfo0GMGpIsRkf4pyNEfmSwraus3ZRYIpKNS50UQFZFNHHYu6qgCM
         oTvPBgaQKQZvdFfSzg5EvZz5hQWzjF72a6ddkOk6n1RNagGr0sZykLujCSsXGF1KxhmU
         sR5wraNK9TNJDQPMxp07SJ/vm/Kqlpu1ENZ7wNL1/ePdGsgM6weqmnV9H8tYEO+PI8R2
         5YbA==
In-Reply-To: <20220803151025.gvst5p2ymdcdfhif-1QOQnPiIM9xnkehFW44Bwe1GAupnlqi7@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Yes, but see the question from Marcos Mello (marcosfrm).  Please explain.

On Wed, Aug 3, 2022 at 11:10 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>
> Great, thanks. Should I do directly do a pull request next time?
>
> On Tue, Aug 02, 2022 at 07:00:33PM -0400, Frederick Grose wrote:
> >How about this?
> >https://github.com/dracutdevs/dracut/pull/1886
> >
> >On Tue, Aug 2, 2022 at 9:56 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
> >
> >> Hello,
> >>
> >> I've never got a feedback on this patch. Will it be integrated?
> >>
> >> Thanks
> >>
> >> On Wed, May 18, 2022 at 11:47:07AM +0200, Federico Vaga wrote:
> >> >The dmsquash-live module assumes that `overlay` is always a module.
> >> >Therefore, when `overlay` is built-in the kernel, this module will fail
> >> >to detect the presence of such a feature.
> >> >
> >> >This patch adds a fallback mechanism to check also `/proc/filesystem`.
> >> >This is also what happens with the dracut NSF module when loading the
> >> >kernel module `rpc_pipefs`.
> >> >
> >> >Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
> >> >---
> >> > v1 -> v2: do not use unnecessary sub-shell in the if statement
> >> >
> >> > modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
> >> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> >diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> >index fd8a858a..f68a979c 100755
> >> >--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> >+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> >@@ -170,7 +170,7 @@ do_live_overlay() {
> >> >         fi
> >> >     fi
> >> >     if [ -n "$overlayfs" ]; then
> >> >-        if ! modprobe overlay; then
> >> >+        if ! { modprobe overlay || strstr "$(cat /proc/filesystems)"
> >> overlay; }; then
> >> >             if [ "$overlayfs" = required ]; then
> >> >                 die "OverlayFS is required but not available."
> >> >                 exit 1
> >> >--
