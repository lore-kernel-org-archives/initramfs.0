From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: initqueue
Date: Thu, 02 Jul 2009 12:11:43 +0200
Message-ID: <4A4C87DF.10904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

To move all "big" jobs out of the udev event handling, I introduce the 
"initqueue". This prevents the job from being killed by udev timeouts.

See
http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut;a=commit;h=eab677a2164bccb3990487dc5ef4549b30cb1055

for the patch.

Basically inside a udev event, you don't do

RUN+="/sbin/ifup $env{INTERFACE}"

you now queue this in the initqueue with:

RUN+="/sbin/initqueue /sbin/ifup $env{INTERFACE}"

Inside init all jobs are worked on in serial order by the do_initqueue() function.

Now we have no more side effects due to the parallel nature of udev and still be 
fast, in case udev supports "udevadm settle --exit-if-exists="
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
