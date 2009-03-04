From: Jeremy Katz <katzj-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] Get rid of some RedHat specific modules and udev
	rules
Date: Tue, 3 Mar 2009 19:24:23 -0500
Message-ID: <20090304002422.GA96609@redhat.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com> <1d16a0aef8ab7f83212bd12dd71908f5c1a1a2a5.1236124962.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1d16a0aef8ab7f83212bd12dd71908f5c1a1a2a5.1236124962.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tuesday, March 03 2009, Victor Lowther said:
> They are not needed to boot with dracut, so away they go.
[snip]
> diff --git a/modules/10redhat-i18n.sh b/modules/10redhat-i18n.sh

Without loading keymaps, if you have an encrypted root device, you may
not be able to (correctly) type your passphrase.  

Jeremy
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
