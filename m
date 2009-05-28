From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: How do we want to handle configuring network boot devices?
Date: Thu, 28 May 2009 17:42:10 +0200
Message-ID: <4A1EB0D2.30500@redhat.com>
References: <1243126816.4217.248.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243126816.4217.248.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: 
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Ok, I updated
https://apps.sourceforge.net/trac/dracut/wiki/commandline
for the boot mechanism we should support in our first version. I removed the URI 
style root, because I misread the iscsi root path syntax the first time (no "//" 
involved).

Please correct/extend the list.

For e.g. password/user authentication, we have to inject conf files in the cpio 
archive, because /proc/cmdline is readable by everyone or use the dhcp root_path 
or other dhcp options.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
