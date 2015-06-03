From: "Gerd v. Egidy" <lists-6VzpN07DMvo@public.gmane.org>
Subject: Re: [PATCH] Add support for ethernet point-to-point connections configured via DHCP
Date: Wed, 03 Jun 2015 09:35:31 +0200
Message-ID: <1561514.UqVy5huTaY@thunder>
References: <13711492.8HAMuGhYIN@thunder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13711492.8HAMuGhYIN@thunder>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Harald,

thank you for merging my patch into master.

Could you also merge it into the RHEL-7 branch so it will be released with 7.2 
or 7.3? Or do you prefer if I open a bug in Bugzilla for that?

It fixes a regression from RHEL 6 which could be network-installed with a dhcp 
configured point-to-point connection.

Thank you.

Kind regards,

Gerd
