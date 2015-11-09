From: Frederick Grose <fgrose-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dmsquash-live-root: Use non-persistent metadata for transient snapshots.
Date: Mon, 9 Nov 2015 10:58:53 -0800
Message-ID: <CAEcBt+VQHxk3RJDLN3DneBomeTNXYgqxt_H4YbbKSEOX51r4HA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=J0LFoQ8wmOAEO9xWn/B5lP4U2bPqztRAqSMfzSz4wLk=;
        b=qKylRTJOJN6EkOmxuRx+aHjxL90DDMRSwJFMAlbCu1J93tLN4F4UwZ4Yaryb7uhbfK
         cvohawn+zaXEoxBpqi38SXzem7QBpq4SaEAD99vKVl1tcsxiywMnVlAuA3lo+7eIUTpr
         opyd25qLyHGhH6xWBA+CO7YfWB1mEcmet/uVIGQHfrnZwB77CT0RmEK4ZRDurPo8OAQO
         ViBTTmugTyClV/46bJAZPnyAyrbRDfsP11aI22G2skzamhceAyflnUwrnN+dP385TEPU
         D++BTAIc+VaDemfwzYM/S7jOu3UxaToAdYMRIsY9RTzHB8Jx3leHJ9M+jNFAugwrfYRo
         Girg==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Transient snapshots can take advantage of smaller,
   non-persistent metadata structures.
Make the --readonly option explicit rather than inferred
   for the readonly_overlay target.
Assure that the live-base target is on the BASE_LOOPDEV.

See https://github.com/haraldh/dracut/pull/103
