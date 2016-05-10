From: "=?ISO-8859-15?Q?Steffen=20Wei=DFgerber?=" <WeissgerberS-Srp0Ujq4vxI@public.gmane.org>
Subject: dracut: missing rbd module
Date: Tue, 10 May 2016 09:07:53 +0200
Message-ID: <5731A4E9020000CD0002B5F3@mail.dbknb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

switching from dracut 043-r2 to 044 I miss the rbd module.

Up to 043-r2 I used dracut on gentoo based on portage overlay hacking-gentoo
provided by mad-hacking.net and booting from rbd images provided by our ceph
storage cluster worked fine.

Since version 044 dracut is available in portage and the overlay seems to be no longer
available. But now in /usr/lib/dracut/modules.d/ the directory 95rbd is missing.

Why this is removed? Booting from rbd directly is a cool feature, I think?

Regards

Steffen




-- 
Klinik-Service Neubrandenburg GmbH
Allendestr. 30, 17036 Neubrandenburg
Amtsgericht Neubrandenburg, HRB 2457
Geschaeftsfuehrerin: Gudrun Kappich
