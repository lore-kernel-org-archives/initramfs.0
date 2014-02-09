From: Till Maas <opensource-44rtNO6TQJOzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] Cryptroot-ask.sh: Use variables consistently
Date: Sun, 9 Feb 2014 16:19:57 +0100
Message-ID: <20140209151957.GE12401@genius.invalid>
References: <1391933322-17308-1-git-send-email-opensource@till.name>
 <52F77EFA.2070600@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F77EFA.2070600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sun, Feb 09, 2014 at 02:13:30PM +0100, Harald Hoyer wrote:
> On 02/09/2014 09:08 AM, Till Maas wrote:
> > - Always use $luksname instead of sometimes $2
> > - define $asked_file instead of using the same path twice
> > ---
> >  modules.d/90crypt/cryptroot-ask.sh | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> 
> Thanks! Pushed.

Thank you. Unluckily the patch did not apply as intended since someone
else did some similar changes since I created the patch. Please apply
the patch I just sent to the mailing list to clean this up. Sorry for
the trouble.

Regards
Till
