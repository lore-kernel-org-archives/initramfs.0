From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 21:09:16 +0100
Message-ID: <ac3eb2510902021209j2de84cc7ue4538b3685d071e5@mail.gmail.com>
References: <20090202163708.GA27474@redhat.com>
	 <20090202165736.GB29131@redhat.com>
	 <20090202195008.GA23229@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090202195008.GA23229-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Feb 2, 2009 at 20:50, Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Monday, February 02 2009, Dave Jones said:

>> Finally, the udev rules currently in dracut are kind of hacky.
>> It'd be good to just have a set of rules provided by the
>> system udev that we can drop in there.
>
> Yep.  Kay and I had a very brief discussion about it before the
> holidays.  And, eg, the dm/lvm rules that are there are almost entirely
> there because those tools don't ship sane rules themselves.  If they
> did, we could just suck them in.
>
> I do think that there needs to be /lib/udev/initrules.d or similar to
> say "these rules matter for booting" as opposed to the full set of rules
> in /lib/udev or the hard-coded list of rules files currently present

We are using the same rules as in the real root since we use udev in
initramfs. Only one initramfs specific rule is created on-the-fly by
the initramfs itself, based on the vales from the boot command line.

I'm not against adding such a directory, but what kind of rules do you
think would go there? I'm at the moment not sure, that they would need
to be different.

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
