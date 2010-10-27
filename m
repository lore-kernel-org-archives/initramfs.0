From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: crypt-cleanup.sh question
Date: Wed, 27 Oct 2010 15:08:24 +0200
Message-ID: <4CC82448.80403@redhat.com>
References: <4CC6C571.8010406@googlemail.com> <4CC6E7C1.1050703@googlemail.com> <4CC7F15C.7090600@redhat.com> <4CC815E4.4060705@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CC815E4.4060705-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/27/2010 02:07 PM, Mr Dash Four wrote:
>
>>>> What is the rationale behind closing all /dev/mapper/luks-* devices which are
>>>> not 'busy' in this shell script? Why would they have to be 'busy' (I presume
>>>> already mapped) to be left open?
>>>>
>>>> I am asking this because when the smartcard module opens a LUKS drive (not
>>>> root - '/') - this drive later to be mapped from the actual root /etc/fstab
>>>> file as '/dev/mapper/luks-XXX /some/directory' - this operation does not
>>>> succeed and I presume crypt-cleanup.sh closes it up before the actual root can
>>>> get it and therefore it cannot be mapped.
>>> Further to the above, I was able to verify that the above script is indeed to
>>> blame for closing LUKS partitions. The only 'busy' partition at the time
>>> crypt-cleanup.sh runs is the root (/sysroot) so I don't see how a LUKS partition
>>> (other than root) specified at the kernel command line could be opened, unless I
>>> am missing something obvious...
>>
>> So, what's the problem? You get real root and can do everything on the real
>> system afterwards...
> Well, 'the problem' as you put it, is that when I open a LUKS partition within
> initramfs (which isn't root!) the crypt-cleanup.sh script in the crypt module
> closes it before switching the real root and therefore that partition is no
> longer available and cannot be mapped.
>
> The same goes if I use the crypt module itself - it asks me for a password,
> opens the required partition and then promptly closes that same partition before
> switching root.
>
> My original query (and the reason for starting this thread) is what is the
> rationale behind this - why not leave the LUKS partitions which were open within
> initramfs to stay open so that they could be mapped by the userspace tools/the
> kernel itself?
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Hmm, maybe this could do it:


diff --git a/modules.d/90crypt/crypt-cleanup.sh b/modules.d/90crypt/crypt-cleanup.sh
index e9fc6ba..4722425 100755
--- a/modules.d/90crypt/crypt-cleanup.sh
+++ b/modules.d/90crypt/crypt-cleanup.sh
@@ -4,6 +4,11 @@
  # close everything which is not busy
  rm -f /etc/udev/rules.d/70-luks.rules >/dev/null 2>&1

+if getargs rd_LUKS_UUID || getarg rd_NO_LUKS; then
+    # do not clean up, if we did not autoassemble
+    exit 0
+fi
+
  while true; do
      local do_break="y"
      for i in /dev/mapper/luks-*; do
