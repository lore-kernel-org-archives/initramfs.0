From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] added extention to module files
Date: Wed, 18 Feb 2009 08:47:49 -0600
Message-ID: <9594AD60-9303-4345-8FC6-B59FAA2C60EE@gmail.com>
References: <1234960574-32612-1-git-send-email-ro@duskblue.org>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=WLJvp8X/XeIZ8GoyqNlG8XaWb7bfkOFBIjGKR1jMKLY=;
        b=TTKQ0DE04lV3jQ4G5Nf8nlSzFbDu3/A2FmC2mnYQ5omPVCLb5Y8RbRBtl8IFgaMndw
         Jk6uBV8m0MYwzSHToSgWiqYwRLnjOUz1OkfJ6vlGylwVzAXvx4OGqNdDrWbomRZ0ebJn
         On/kbh2AIJaZp2Qh05DToIJY38Cz8oxddopbg=
In-Reply-To: <1234960574-32612-1-git-send-email-ro-ubUvw2JwXcZg9hUCZPvPmw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
To: Thiago Galesi <ro-ubUvw2JwXcZg9hUCZPvPmw@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


On Feb 18, 2009, at 6:36 AM, Thiago Galesi <ro-ubUvw2JwXcZg9hUCZPvPmw@public.gmane.org> wrote:

> From: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Here's a simple patch to add the .sh extention to modules/ files as
> suggested in a previous message
>
> I'm not sure if more modifications are needed in dracut though.

You will also need to modify the dracut script to only source modules  
with the .sh extension, and make sure the $dracutmodules functionality  
still works as expected.

You will also need to modify the Makefile to only install modules with  
the .sh extension.

>
>
> Signed-off-by: Thiago Galesi <thiagogalesi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> modules/{00dash => 00dash.sh}                     |    0
> modules/{10redhat-i18n => 10redhat-i18n.sh}       |    0
> modules/{90crypt => 90crypt.sh}                   |    0
> modules/{90kernel-modules => 90kernel-modules.sh} |    0
> modules/{90lvm => 90lvm.sh}                       |    0
> modules/{95debug => 95debug.sh}                   |    0
> modules/{95terminfo => 95terminfo.sh}             |    0
> modules/{95udev-rules => 95udev-rules.sh}         |    0
> modules/{99base => 99base.sh}                     |    0
> 9 files changed, 0 insertions(+), 0 deletions(-)
> rename modules/{00dash => 00dash.sh} (100%)
> rename modules/{10redhat-i18n => 10redhat-i18n.sh} (100%)
> rename modules/{90crypt => 90crypt.sh} (100%)
> rename modules/{90kernel-modules => 90kernel-modules.sh} (100%)
> rename modules/{90lvm => 90lvm.sh} (100%)
> rename modules/{95debug => 95debug.sh} (100%)
> rename modules/{95terminfo => 95terminfo.sh} (100%)
> rename modules/{95udev-rules => 95udev-rules.sh} (100%)
> rename modules/{99base => 99base.sh} (100%)
>
> diff --git a/modules/00dash b/modules/00dash.sh
> similarity index 100%
> rename from modules/00dash
> rename to modules/00dash.sh
> diff --git a/modules/10redhat-i18n b/modules/10redhat-i18n.sh
> similarity index 100%
> rename from modules/10redhat-i18n
> rename to modules/10redhat-i18n.sh
> diff --git a/modules/90crypt b/modules/90crypt.sh
> similarity index 100%
> rename from modules/90crypt
> rename to modules/90crypt.sh
> diff --git a/modules/90kernel-modules b/modules/90kernel-modules.sh
> similarity index 100%
> rename from modules/90kernel-modules
> rename to modules/90kernel-modules.sh
> diff --git a/modules/90lvm b/modules/90lvm.sh
> similarity index 100%
> rename from modules/90lvm
> rename to modules/90lvm.sh
> diff --git a/modules/95debug b/modules/95debug.sh
> similarity index 100%
> rename from modules/95debug
> rename to modules/95debug.sh
> diff --git a/modules/95terminfo b/modules/95terminfo.sh
> similarity index 100%
> rename from modules/95terminfo
> rename to modules/95terminfo.sh
> diff --git a/modules/95udev-rules b/modules/95udev-rules.sh
> similarity index 100%
> rename from modules/95udev-rules
> rename to modules/95udev-rules.sh
> diff --git a/modules/99base b/modules/99base.sh
> similarity index 100%
> rename from modules/99base
> rename to modules/99base.sh
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs"  
> in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
