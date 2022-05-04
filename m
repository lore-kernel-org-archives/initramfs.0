From: German Maglione <gmaglione-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dracut: dmsquash-live: overlay module can be built-in the kernel
Date: Wed, 4 May 2022 12:03:26 +0200
Message-ID: <CAJh=p+7tGGaQNpwBfmKNp8+Zwu+vDV2u-xO2z-CHB44j6aQ-xQ@mail.gmail.com>
References: <20220420071523.1185188-1-federico.vaga@cern.ch>
 <CAJh=p+6s1q3yxVxTPePDOx1JyGKi+14RXqtzHirqYYtAihdqww@mail.gmail.com> <20220426084005.7d5cso3ik2dcfosh@cwe-513-vol689.cern.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651658647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8YJCKGxLLwFYjdKO+tEv4R1VQRf8W7SjCFjjngZgoE=;
        b=Gqt+mzYzsp86HpEgRiTMlSQSvYZyI0LoBLLew71A8dn3SHLwNOuj7cfRi5pWDu4dJ5anyj
        QL/j5WrcHpVlMna3L8gx12LCGnxSN/+3yXj91eOXq18fHTi0UIf5XlmLLHJN0hxRi0sLqf
        ZVq0rMLgabHyEylYnhyZ51Ljj805DQM=
In-Reply-To: <20220426084005.7d5cso3ik2dcfosh-A6n7nn9GgJBD7ITmBszAl7ajPOKdvyMf@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 26, 2022 at 10:40 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>
> On Fri, Apr 22, 2022 at 01:04:45PM +0200, German Maglione wrote:
> >On Wed, Apr 20, 2022 at 9:17 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
> >>
> >> The dmsquash-live module assumes that `overlay` is always a module.
> >> Therefore, when `overlay` is built-in the kernel, this module will fail
> >> to detect the presence of such a feature.
> >>
> >> This patch adds a fallback mechanism to check also `/proc/filesystem`.
> >> This is also what happens with the dracut NSF module when loading the
> >> kernel module `rpc_pipefs`.
> >>
> >> Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
> >> ---
> >>  modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> index fd8a858a..b4a44e92 100755
> >> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
> >> @@ -170,7 +170,7 @@ do_live_overlay() {
> >>          fi
> >>      fi
> >>      if [ -n "$overlayfs" ]; then
> >> -        if ! modprobe overlay; then
> >> +        if ! (modprobe overlay || strstr "$(cat /proc/filesystems)" overlay); then
> >
> >if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then
> >
> >I recently made the same mistake of using a subshell.
>
> For my understanding:
>
> Why do you think it's a mistake to use a subshell?
>
> Are you thinking about execution performance, or some locale variable
> that do not get exported to the subshell?

Well, maybe "mistake" was not the best word to use in this case,
the subshell here it's simply unnecessary

> Then, why curly brackets and not double square brackets?

do you mean like:
if ! [[ modprobe overlay; ]]; then
this is a mistake, you cannot wrap commands in [[ ]] (or []), try this:

[[ false ]] && echo "you should not see this"

> I see the latter is far more used among modules; even if it is
> enforcing a dependency on bash (or whatever supports `[[`)

That the hooks be posix compliant (as you said [[ can be considered as
a bashism)
is explicitly required In the dracut docs, although it is true that
there are some hooks
that use [[, but mostly setup scripts.

>
> Thanks in advance for the clarifications :)
>
> >>              if [ "$overlayfs" = required ]; then
> >>                  die "OverlayFS is required but not available."
> >>                  exit 1
> >> --
> >> 2.27.0
> >>
> >
> >
> >--
> >German
> >
>


-- 
German

