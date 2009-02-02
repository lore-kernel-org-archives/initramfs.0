From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Current status of dracut.
Date: Mon, 2 Feb 2009 15:14:56 -0500
Message-ID: <20090202201456.GC31858@redhat.com>
References: <20090202163708.GA27474@redhat.com> <20090202165736.GB29131@redhat.com> <20090202195008.GA23229@redhat.com> <ac3eb2510902021209j2de84cc7ue4538b3685d071e5@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac3eb2510902021209j2de84cc7ue4538b3685d071e5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Feb 02, 2009 at 09:09:16PM +0100, Kay Sievers wrote:

 > We are using the same rules as in the real root since we use udev in
 > initramfs. Only one initramfs specific rule is created on-the-fly by
 > the initramfs itself, based on the vales from the boot command line.
 > 
 > I'm not against adding such a directory, but what kind of rules do you
 > think would go there? I'm at the moment not sure, that they would need
 > to be different.

The LVM case for example, to auto-assemble volume groups.

What we have now is..

SUBSYSTEM!="block", GOTO="lvm_end"
ACTION!="add|change", GOTO="lvm_end"

KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
ENV{ID_FS_TYPE}=="LVM2_member", RUN+="/sbin/lvm vgscan", RUN+="/sbin/lvm vgchange -ay"

LABEL="lvm_end"

which isn't great..


dmraid is another case.

	Dave

-- 
http://www.codemonkey.org.uk
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
