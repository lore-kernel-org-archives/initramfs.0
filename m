From: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
Subject: Re: [PATCH v2] dracut: dmsquash-live: overlay module can be built-in
 the kernel
Date: Wed, 3 Aug 2022 17:10:25 +0200
Message-ID: <20220803151025.gvst5p2ymdcdfhif@pcbe17027.cern.ch>
References: <20220518094707.943732-1-federico.vaga@cern.ch>
 <20220802135140.lxdgwvqkp56j6t4m@pcbe17027.cern.ch>
 <CAEcBt+WXEhVnXkiCesXhS7QqROFbpcMBoSqqamuAcH8yRFwgaQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hxMWTNxBDYu9WbiuNLtHlpLTVVl0NesSQ9ECNmp0X8=;
 b=kMVgEWFlCXjInalsFSzgmfOE4x9d6jbFti/bb2w2dcYO3zCnjit8UyusQuIHM2gnfAfz42gy9Xt2ivVOB8d9u1BoMeIMt4IP0T57NlaJTuOEdYRhZc4jOUq2YDS45Fxtzh0LYBDDqEla+JXEptGtqCQzeqNam8sCZ2xCo+FQwWQ=
Content-Disposition: inline
In-Reply-To: <CAEcBt+WXEhVnXkiCesXhS7QqROFbpcMBoSqqamuAcH8yRFwgaQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Great, thanks. Should I do directly do a pull request next time?

On Tue, Aug 02, 2022 at 07:00:33PM -0400, Frederick Grose wrote:
>How about this?
>https://github.com/dracutdevs/dracut/pull/1886
>
>On Tue, Aug 2, 2022 at 9:56 AM Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org> wrote:
>
>> Hello,
>>
>> I've never got a feedback on this patch. Will it be integrated?
>>
>> Thanks
>>
>> On Wed, May 18, 2022 at 11:47:07AM +0200, Federico Vaga wrote:
>> >The dmsquash-live module assumes that `overlay` is always a module.
>> >Therefore, when `overlay` is built-in the kernel, this module will fail
>> >to detect the presence of such a feature.
>> >
>> >This patch adds a fallback mechanism to check also `/proc/filesystem`.
>> >This is also what happens with the dracut NSF module when loading the
>> >kernel module `rpc_pipefs`.
>> >
>> >Signed-off-by: Federico Vaga <federico.vaga-vJEk5272eHo@public.gmane.org>
>> >---
>> > v1 -> v2: do not use unnecessary sub-shell in the if statement
>> >
>> > modules.d/90dmsquash-live/dmsquash-live-root.sh | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >index fd8a858a..f68a979c 100755
>> >--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
>> >@@ -170,7 +170,7 @@ do_live_overlay() {
>> >         fi
>> >     fi
>> >     if [ -n "$overlayfs" ]; then
>> >-        if ! modprobe overlay; then
>> >+        if ! { modprobe overlay || strstr "$(cat /proc/filesystems)"
>> overlay; }; then
>> >             if [ "$overlayfs" = required ]; then
>> >                 die "OverlayFS is required but not available."
>> >                 exit 1
>> >--
>> >2.27.0
>> >
>>
>> --
>> -------------------------------
>> Federico Vaga - CERN BE-CEM-EDL
>>

-- 
-------------------------------
Federico Vaga - CERN BE-CEM-EDL
