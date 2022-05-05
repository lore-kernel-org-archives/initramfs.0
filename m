From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: Re: [PATCH] dracut: dmsquash-live: overlay module can be built-in
 the kernel
Date: Thu, 5 May 2022 09:01:12 +0200
Message-ID: <20220505070112.xnga2m4hu4e5a3jn@cwe-513-vol689.cern.ch>
References: <20220420071523.1185188-1-federico.vaga@cern.ch>
 <CAJh=p+6s1q3yxVxTPePDOx1JyGKi+14RXqtzHirqYYtAihdqww@mail.gmail.com>
 <20220426084005.7d5cso3ik2dcfosh@cwe-513-vol689.cern.ch>
 <CAJh=p+7tGGaQNpwBfmKNp8+Zwu+vDV2u-xO2z-CHB44j6aQ-xQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixmuYlGOKkhElXnBqnUEepIorTjHGAABE7499Nukyi4=;
 b=pd3Mmg90I+mOgpaAZ5Vjuwlrt22MtJeD73EmN25pFhd57ZOWxP22Po1zdZOL05dDB5wNzgsnehrEXz1i3XPTEd5AgRs0ryM2iRVjnfYZJLHjmNKuNsmrngiNp6i1TlCQsFO+1a8dSknG4wMhCxPBOTh3GDkC9hMR++cODcLI2N4=
Content-Disposition: inline
In-Reply-To: <CAJh=p+7tGGaQNpwBfmKNp8+Zwu+vDV2u-xO2z-CHB44j6aQ-xQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: German Maglione <gmaglione-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Crystal clear, thanks! I will submit a V2 patch using curly brackets

On Wed, May 04, 2022 at 12:03:26PM +0200, German Maglione wrote:
>On Tue, Apr 26, 2022 at 10:40 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>>
>> On Fri, Apr 22, 2022 at 01:04:45PM +0200, German Maglione wrote:
>> >On Wed, Apr 20, 2022 at 9:17 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>> >>
>> >> The dmsquash-live module assumes that `overlay` is always a module.
>> >> Therefore, when `overlay` is built-in the kernel, this module will fail
>> >> to detect the presence of such a feature.
>> >>
>> >> This patch adds a fallback mechanism to check also `/proc/filesystem`.
>> >> This is also what happens with the dracut NSF module when loading the
>> >> kernel module `rpc_pipefs`.
>> >>
>> >> Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
>> >> ---
>> >>  modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >> index fd8a858a..b4a44e92 100755
>> >> --- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >> +++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >> @@ -170,7 +170,7 @@ do_live_overlay() {
>> >>          fi
>> >>      fi
>> >>      if [ -n "$overlayfs" ]; then
>> >> -        if ! modprobe overlay; then
>> >> +        if ! (modprobe overlay || strstr "$(cat /proc/filesystems)" overlay); then
>> >
>> >if ! { modprobe overlay || strstr "$(cat /proc/filesystems)" overlay; }; then
>> >
>> >I recently made the same mistake of using a subshell.
>>
>> For my understanding:
>>
>> Why do you think it's a mistake to use a subshell?
>>
>> Are you thinking about execution performance, or some locale variable
>> that do not get exported to the subshell?
>
>Well, maybe "mistake" was not the best word to use in this case,
>the subshell here it's simply unnecessary
>
>> Then, why curly brackets and not double square brackets?
>
>do you mean like:
>if ! [[ modprobe overlay; ]]; then
>this is a mistake, you cannot wrap commands in [[ ]] (or []), try this:
>
>[[ false ]] && echo "you should not see this"
>
>> I see the latter is far more used among modules; even if it is
>> enforcing a dependency on bash (or whatever supports `[[`)
>
>That the hooks be posix compliant (as you said [[ can be considered as
>a bashism)
>is explicitly required In the dracut docs, although it is true that
>there are some hooks
>that use [[, but mostly setup scripts.
>
>>
>> Thanks in advance for the clarifications :)
>>
>> >>              if [ "$overlayfs" = required ]; then
>> >>                  die "OverlayFS is required but not available."
>> >>                  exit 1
>> >> --
>> >> 2.27.0
>> >>
>> >
>> >
>> >--
>> >German
>> >
>>
>
>
>-- 
>German
>
