From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 09:55:03 -0700
Message-ID: <e9c3a7c20902060855s4834f012vf3c1536a0727b057@mail.gmail.com>
References: <20090206164019.GD552@redhat.com>
	 <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=j5Qw8Hd2s8jaL0gjyshNZqMRt0rvbx5pKjFt2XoLp78=;
        b=FnmreNeaORLtN9DdwNAJfDaEu90qYeUMFF0rxlJfK7h1S+U+cr1aJrG1d8DJpElbdU
         jYuKFu2kymlv3CJ8suHRAGvPtm5dcl3N7g+EtZ6mMxhwCq4R7OVhF2Iq2bbtZqEiFpjj
         lKC0iGt2kEm7Q0NJQJ65m+CENDHs1neT5Fd+8=
In-Reply-To: <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA-IGOiFh9zz4yvNW/NfzhIbrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

On Fri, Feb 6, 2009 at 9:50 AM, Danecki, Jacek <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
>> Is there a real need for mdmon to start prior to being in the real
>> rootfs?
>
> mdmon is needed to change raid array to RW mode, so as long as rootfs is mounted RO, mdmon can be started in real rootfs.--

No, that is what I originally thought until I tried to mount an xfs
filesystem that had been uncleanly shutdown.  Even if the rootfs is
mounted read-only the backing device needs to be read-write to recover
the journal.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
