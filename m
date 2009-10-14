From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Where to load dm_mod?
Date: Wed, 14 Oct 2009 10:43:25 +0200
Message-ID: <4AD58F2D.3030806@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Some kernels configurations may build dm as a module. dracut makes sure 
that dm_mod et al are included in the initramfs, but dm_mod is not 
automatically loaded when needed.

As I'm no expert on this, my question: which module and hook should 
ensure that dm_mod is properly loaded? Currently I have it 
90mdraid/mdmon-pre-udev.sh but I'm really not sure if this is the right 
place.

Thanks,
Philippe
