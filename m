From: lyndat3-p/IIKWkZnU0S+FvcfC7Uqw@public.gmane.org
Subject: Re: How to have dracut conditionally add different kernel modules for
 different kernels?
Date: Sun, 12 Apr 2015 09:32:19 -0700
Message-ID: <1428856339.2402820.252686921.0AA31DC6@webmail.messagingengine.com>
References: <1428693113.1734218.251850073.54517680@webmail.messagingengine.com>
 <20150412111154.5de2405f@opensuse.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=your-mail.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=j4p7opEXpOxeLfY0bjaBfH5lZW8=; b=cy2s4T
	PijG5mif5lKoBxtukt3/Pfu2aGrZeLlWkq9FSGh/ajODl0Q1nilRqKKFhFdqcZD6
	RS2kPc9zlWXvtlFk5ax1pDwbyCiURUdqpbC+Y2jA1F6CeiK1MGaTa7wapVlsYGm9
	pym2yZOvl/zpNhN4H1fFZz+SpHp0PxWe2QnJg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=j4p7opEXpOxeLfY
	0bjaBfH5lZW8=; b=ddMbpyQkb3nHsieonZZ4EluNFjZIPvP8Lwlh/n49Ehp5uiR
	OR+YEZNeWDsu3mJhjuE001ANxmtQU6jkIzN05b1Gu1/dFeHmBJgI/ARMvtUfOEkY
	Z3WnW10NlhGjDb850ZjSvkfER7hS6vefjAtIcrfT6HnHQ0WupThuqLAngk2k=
In-Reply-To: <20150412111154.5de2405f-stAJ6ESoqRzYCGPCin2YbQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrei Borzenkov <arvidjaar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Sun, Apr 12, 2015, at 01:11 AM, Andrei Borzenkov wrote:
> > What's the right way to add kernel-specific modules in dracut, so that for example the xen mods are ONLY added in the xen case?
> 
> Not sure about the "right" way, but dracut configuration files are
> shell scripts, so you can implement the same logic in /etc/dracut.d
> snippet, something like
> 
> if is_xen_kernel ; then
>   add_drivers+=" ..."
> fi
> 
> where is_xen_kernel does whatever check is required to detect domU
> kernel.

Option to use if ...  should do the trick.

Detecting if xen is RUNNING is

if test -d /proc/xen; then
 whatver
fi

But that's not the needed test.  Like you said have to get a test that checks if the dracut TARGET is a xen kernel.  When dracut's running across multiple xen & non-xen kernels, I'm not yet sure how to hook that info from inside dracut.conf.

LT
