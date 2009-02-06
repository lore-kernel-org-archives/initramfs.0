From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] raid: external and internal metadata support
Date: Fri, 6 Feb 2009 10:27:27 -0700
Message-ID: <e9c3a7c20902060927j2b900940kd851573469110135@mail.gmail.com>
References: <20090206164019.GD552@redhat.com>
	 <A9DE54D0CD747C4CB06DCE5B6FA2246F4B496AFA@irsmsx504.ger.corp.intel.com>
	 <20090206165601.GF11144@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=p4dBKHFvPaLKvXVBJx6iisDGbPV5WW1bLL50vyrmlFk=;
        b=q/Vycrp2+Xaona/1qGnH058J08RshN4nk4IOpbVZmOwgB3OHwNNf5rFmEzdxZfy1t4
         0Ou8XrJcODKiiv7q9IGfIdHLgiyFIar0FPNtNBQVi/YVVZNlN0FnMtGEkpogyq4lmTjy
         2qzvvOOsTaLxcLD0Y4yR7iA3lklIHrpwZtTz0=
In-Reply-To: <20090206165601.GF11144-Zdt1ptygihhQcNjhGXsBABcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Danecki, Jacek" <jacek.danecki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "neilb-l3A5Bk7waGM@public.gmane.org" <neilb-l3A5Bk7waGM@public.gmane.org>

On Fri, Feb 6, 2009 at 9:56 AM, Bill Nottingham <notting-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> So, for one particular specific type of block device, you need
> a daemon to switch it writable. Every other type of block device
> can handle this without separate tooling. I'm not seeing how this
> is an improvement.
>

It is not just setting writable, mdmon is also there to clear the bit
when writes have quiesced.  Raid devices have always been special in
that they need to manage a dirty bit in their metadata to determine if
a resync needs to be performed after a dirty shutdown.  With hardware
raid or pure kernel (MD metadata) raid this mechanism is hidden.

External metadata raid is akin to fuse filesystems.  The kernel
provides the generic infrastructure and a userspace daemon handles the
implementation details.

The improvement is that with one kernel implementation we can support
any number of metadata formats.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
