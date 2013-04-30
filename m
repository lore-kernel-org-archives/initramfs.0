From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [40network] Fix ifup.sh to always execute
 initqueue/online hook after bringing up an interface
Date: Tue, 30 Apr 2013 15:25:15 -0400
Message-ID: <1367349915.2614.5.camel@metroid.usersys.redhat.com>
References: <1365694894-7926-1-git-send-email-devurandom@gmx.net>
	 <5166DA48.20803@redhat.com> <1888619.XKMYbluzRY@ernie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1888619.XKMYbluzRY@ernie>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2013-04-11 at 18:13 +0200, Dennis Schridde wrote:
> Am Donnerstag, 11. April 2013, 17:44:08 schrieb Harald Hoyer:
> > IIRC, that is done, as soon as the dhcp client gets an IP

Technically it doesn't happen *immediately* - it adds a job to the
initqueue, and that job will run the initqueue/online hook.

> These patches are already a few months old, so dracut's behaviour may very 
> well have changed in the meantime. Where does what you describe happen?

See 40network/dhclient-script.sh - when $reason is BOUND (i.e. initial
binding to a new address, as per dhclient-script(8)), it adds a job
named "setup_net_$netif.sh" to the initqueue.

Hope that helps,

-w
