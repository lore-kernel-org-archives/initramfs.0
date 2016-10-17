From: Martin Wilck <mwilck-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC/PATCH] Give --persistent_policy precedence over
 /dev/mapper names
Date: Mon, 17 Oct 2016 11:18:31 +0200
Message-ID: <1476695911.4871.2.camel@suse.de>
References: <20161005121303.31582-1-mwilck@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161005121303.31582-1-mwilck-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2016-10-05 at 14:13 +0200, Martin Wilck wrote:

> There is currently no way to override dracut's preference for
> /dev/mapper device names. But using these is problematic in
> different scenarios: For example, if a user has a multipath-
> enabled system but wants to disable multipath, or if the
> names of multipath maps change because of configuration changes
> (e.g. toggling user_friendly_names in /etc/multipath.conf).
> 
> This patch makes dracut prefer the user-specified
> --persistent_policy names over /dev/mapper names.
> 
> It might be worthwhile to discuss why dracut prefers /dev/mapper
> of /dev/disk/by-uuid at all. This preference was introduced
> in 9037b63e with the argument "dm devices maintain /dev/mapper/* as
> persistent names", but that's wrong for the scenarios mentioned
> above, and is not a compelling reason for preferring /dev/mapper
> over /dev/disk/by-uuid.

Ping - does nobody have an opinion on this suggestion?

Regards
Martin
