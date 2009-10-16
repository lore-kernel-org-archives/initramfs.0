From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: dracut and debian unstable status
Date: Fri, 16 Oct 2009 11:03:39 +0200
Message-ID: <4AD836EB.5010206@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi all

I thought I'd give heads up: With the last three patches I just sent all 
test-cases complete with a beautiful OK on a current debian unstable. 
Most network tests run with debian stable as well, but don't expect any 
complicated cryptroot/mdraid/lvm stuff to wirk with the stable branch.

There is on note though: Currently debian does not include netbsd 
iscsi-start. So if anyone wants to run the iscsi test-suite that package 
needs to be downloaded in rpm format and converted with alien.

Regards,
Philippe
