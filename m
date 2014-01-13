From: James Lee <jlee-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH v2] crypt: Prevent asking for password multiple times
 if non-default crypt name is used.
Date: Mon, 13 Jan 2014 10:30:30 -0500
Message-ID: <52D40696.4080204@thestaticvoid.com>
References: <1388093183-19045-1-git-send-email-colin@mageia.org> <1388149248-23146-1-git-send-email-colin@mageia.org> <52D025F5.1050703@thestaticvoid.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D025F5.1050703-RWYTM8lfiZY4k1Tz1RznXQC/G2K4zDHf@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/10/2014 11:55 AM, James Lee wrote:
> I believe I've seen the situation this patch is trying to fix.  I will
> test these patches with my fairly complex crypt setup [1] this weekend.
> 
> James
> 
> [1]
> https://thestaticvoid.com/post/2013/10/26/how-i-do-encrypted-mirrored-zfs-root-on-linux/

Both patches (this one and the udev rule one) work great on all the
systems I tried them on.  Solves the problem I was seeing with being
asked for the passphrase multiple times.

Thanks!

James
