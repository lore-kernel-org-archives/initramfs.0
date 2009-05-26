From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH] dracut: make initial devices outside of initramfs
Date: Mon, 25 May 2009 23:44:19 -0400
Message-ID: <1243309459.3584.51.camel@obelisk.thedillows.org>
References: <Pine.LNX.4.58.0905231331400.2058@gate.bb.dicp.net>
	 <1243305738.3584.40.camel@obelisk.thedillows.org>
	 <20090526024454.GA10049@redhat.com>
	 <1243306682.3584.42.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243306682.3584.42.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-05-25 at 22:58 -0400, David Dillow wrote:
> On Mon, 2009-05-25 at 22:44 -0400, Jeremy Katz wrote:
> > On Monday, May 25 2009, David Dillow said:
> > > dash gets upset when it cannot open /dev/tty, and we lose stderr. Even
> > > if we make /dev/tty once we're in the initramfs, it will still be too
> > > late for the inital dash shell running the init script. So, make a small
> > > set of nodes in the dracut script while building the directory structure
> > > of the initramfs.
> > 
> > Creating the nodes in the dracut script means that you can't create the
> > initramfs as non-root, though.  :(
> 
> Bummer, that. And while it makes the initial dash able to give us
> stderr, it doesn't fix the emergency shell. Of course, I noticed this
> after hitting send... so bad patch all around. :(

I'm a dope, initial dash has always had stderr.

This ugliness points /dev/tty at the actual device of /dev/console while
running the emergency shell, then puts it back when done so if we do
manage to mount things, /dev will have the right devices when
switch_root moves it.

I'm not sure if its worth it, but at least I have a prompt and stderr in
the emergency shell now, even after udev runs.

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 5ee897e..4e2d73f 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -11,7 +11,13 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
+    # Point /dev/tty at the device for /dev/console as we don't have a
+    # controlling shell here and dash won't give us stderr or a prompt
+    # w/o a working /dev/tty
+    rm -f /dev/tty; mknod /dev/tty c 5 1
     sh -i
+    # Point it back to the real device
+    rm -f /dev/tty; mknod /dev/tty c 5 0
 }
 
 source_all() {


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
