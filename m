From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: /etc/passwd thoughts
Date: Sat, 13 Jun 2009 06:04:54 +0200
Message-ID: <4A332566.8080501@bfh.ch>
References: <4A32B84E.8090603@redhat.com>	 <20090612202045.GA30968@nostromo.devel.redhat.com>	 <4A32B94E.10902@redhat.com>  <4A32C6CF.9010802@bfh.ch> <1244859170.18551.9.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244859170.18551.9.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



David Dillow wrote:
> On Fri, 2009-06-12 at 23:21 +0200, Seewer Philippe wrote:
>> Actually 95nfs doesn't create its own entry. The part is commented out.
> 
> Right; I'm torn on this. We want to support both portmap and rpcbind,
> and at least rpcbind needs a user to run as -- it won't run without it.
> I don't know what portmap wants.

Portmap doesn't want anything. In the past, I've even run it without an 
/etc at all.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
