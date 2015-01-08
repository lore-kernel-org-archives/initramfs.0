From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [RFC][PATCH 6/9] gen_initramfs_list.sh: include xattrs
Date: Thu, 8 Jan 2015 09:01:01 -0500
Message-ID: <CA+5PVA77x2W9LyHMq1jSW3HKqNgFPz-gPVOH0QtEmmMBwzOx_Q@mail.gmail.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1420663980-20842-7-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0cnlDkjRagdnXxDi49IzuyXDGsZV8OIYsHyYLr5MNfk=;
        b=qQkr0QMb1LAY33w7t8V4S4sTLITxgdKr03opd0IbWiTP8yVsUs8/QKVb422WZXs1K/
         fb7Xgus3USZ3LKf/s7KQSMJgNKrx/0PhsWV/l4nJIJLmrtY4n2K7rhnR2yUr9JDpxcCI
         oAMe7V8hHHt6Ke2NHDWUfwClfQo9k+sOqs7lphKRO7cqC11SmNOr28F9V1KGrKf9stkM
         8kfRXuKWdkErznISQ9F73Jov57bBglEzKIW4l/lR/B5qe4/3pG3j01W8t1V59PwI27o8
         y42Q5TDJVPV/bblMQY+5jpWnIX3gDa0zRCDAiH3XX3eOIO+F2X3gW9aPp+/wc2CFP3d/
         7Dog==
In-Reply-To: <1420663980-20842-7-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: initramfs <initramfs@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Jan 7, 2015 at 3:52 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> This patch modifies the gen_initramfs_list.sh script to include xattrs
> in the initramfs.
>
> Dracut creates the initramfs using the cpio tool on the system, not
> the kernel's gen_init_cpio script. The following commands, for example,
> would create an initramfs containing xattrs.
>
> dracut -H -f /boot/initramfs-3.XX.0+.img 3.XX.0+ -M --keep \
>         --noprelink --nostrip
> gen_initramfs_list.sh /var/tmp/initramfs.XXXXXX/ > \
>         /var/tmp/initramfs_list.XXXXXX
>
> [Sign files here, if not already signed, using evmctl.]
>
> gen_init_cpio -x /var/tmp/initramfs_list.XXXXXX >  \
>         /boot/initramfs-3.XX.0+test.img

That's pretty awkward.  I think it highlights the major downside of
this approach in that from a standard distro point of view this
functionality isn't likely to be used.  Do you foresee this feature as
something that should be widely used, or something that would be used
more in custom, locked-down machines?

I can understand not wanting to redefine the newc format in userspace
cpio, but if you want this to be easier to use then perhaps working
with dracut upstream to make it support this out of the box would be a
good idea.

josh
