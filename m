From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: Patches, Patches, Patches ...
Date: Wed, 30 Dec 2009 08:42:14 +0100
Message-ID: <20091230074214.GA752@maude.comedia.it>
References: <20091229125447.GA5522@maude.comedia.it> <1262103052.8998.8.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=comedia.it; h=
	user-agent:in-reply-to:content-disposition:content-type
	:mime-version:references:message-id:subject:from:date:received:
	x-virus-scanned; s=200808; t=1262158934; bh=OeOlABv4N1QM8AjjkUYL
	dJ+eHaKhJ86Ba1Eg4hR13d8=; b=kwKbSBwLwF9/bvZ281jYH0vJjjlRcaHRH6ql
	ve2JHGMU9GaZppXmgyppzAvhOlQfHiv+WT+pe6tMButjmA+84dTpnKGP/dxIuZsI
	GN4W8hK18InLXtJliEPYh1cCa0qIdzR1miawULEW+8ROrfJJh+yoHoepTWmVUoJp
	lJQhfRs=
Content-Disposition: inline
In-Reply-To: <1262103052.8998.8.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 29, 2009 at 11:10:52AM -0500, David Dillow wrote:
>On Tue, 2009-12-29 at 13:54 +0100, Luca Berra wrote:
>> btw i am unable to git clone from sourceforge:
>> $ git clone -v git://dracut.git.sourceforge.net/gitroot/dracut
>> Initialized empty Git repository in /home/bluca/GIT/dracut/.git/
>> fatal: The remote end hung up unexpectedly
>
>Sourceforge changed the paths at some point in past. Use
>git://dracut.git.sourceforge.net/gitroot/dracut/dracut
>
thanks a lot.
btw someone should fix the instructions on the wiki then

L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
