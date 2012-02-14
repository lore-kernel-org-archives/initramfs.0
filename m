From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 9/9] skiproot - script for network setup without network
 root
Date: Tue, 14 Feb 2012 13:42:47 -0500
Message-ID: <1329244967.28129.23.camel@samus.usersys.redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
	 <1329241090-26908-10-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-10-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2012-02-14 at 12:38 -0500, Will Woods wrote:
> This allows you to set up the network for non-netroot things (like
> fetching updates for live images, etc).
> 
> The other parse-*.sh script can set 'netroot=skip', and anything that
> should happen when the network comes up can be put into the 'netroot'
> hook, something like this:
> 
>   echo "fetch-liveupdate $update_url" >> $hookdir/netroot/liveupdates.sh

This patch can be ignored - I like the rd.neednet solution better,
although I wish it ran through the setup in netroot and ran the
'netroot' hooks..

-w
