From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] dracut: dmsquash-live: overlay module can be built-in
 the kernel
Date: Tue, 2 Aug 2022 19:33:23 -0400
Message-ID: <CAEcBt+X-gjoGiAc78anQmo1oGZHq09y6q6VVg4AEDJ5Xz+dz3g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wAbNeyEsHiWiAAHriBdvX04uMex8Sc09y8SJB4l2A4I=;
        b=Y0LP+B6vv6IbBkbbHC5q3XKe/33MGzo+w8J/hS059HQpGLGeEFcboxO0C56nSwRrs1
         WmwY3/kAua1gdf8kiT6FqwyXbJn8uacYHjr9CCYaavl30nzFy+8iOlMX1zDtsRHRxHrL
         XRQvJD/KAthQmyTaLGHuG2L+DOD8XG4N8XD3uHrsuM/49e+KngMbFgnKToynlbHiOjGK
         bq0L4PlDrKjMKHxfutaxJWfTYpMr+/vzbEM/rApsXQaZP1OYw/VS0yBveJnnTgaxYWXV
         um6IslFWez1hknuINgBhl4cNWaxxRI/ltx+exd4JYL6BgmaM7jTWnm4IdQ+3ewld1aHQ
         ZPhA==
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

How about this?
https://github.com/dracutdevs/dracut/pull/1886

On Tue, Aug 2, 2022 at 9:56 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>
> Hello,
>
> I've never got a feedback on this patch. Will it be integrated?
>
> Thanks
>
> On Wed, May 18, 2022 at 11:47:07AM +0200, Federico Vaga wrote:
> >The dmsquash-live module assumes that `overlay` is always a module.
> >Therefore, when `overlay` is built-in the kernel, this module will fail
> >to detect the presence of such a feature.
> >
> >This patch adds a fallback mechanism to check also `/proc/filesystem`.
> >This is also what happens with the dracut NSF module when loading the
> >kernel module `rpc_pipefs`.
> >
> >Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
> >---
> > v1 -> v2: do not use unnecessary sub-shell in the if statement
> >
> > modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >index fd8a858a..f68a979c 100755
> >--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >@@ -170,7 +170,7 @@ do_live_overlay() {
> >         fi
> >     fi
> >     if [ -n "$overlayfs" ]; then
> >-        if ! modprobe overlay; then
> >+        if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then
> >             if [ "$overlayfs" = required ]; then
> >                 die "OverlayFS is required but not available."
> >                 exit 1
> >--
> >2.27.0
> >
>
> --
> -------------------------------
> Federico Vaga - CERN BE-CEM-EDL
