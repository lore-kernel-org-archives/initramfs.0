From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 14:47:32 +0100
Message-ID: <49A3FA74.50002@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>  <49A301FF.2090303@redhat.com>  <1235434056.28090.28.camel@sentry-no.fnordovax.org>  <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org> <Pine.LNX.4.64.0902241443320.22015@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0902241443320.22015-qcrbbFV08EMdmw7VdWMmteH3J2bgQ+4lG9Ur7JDdleE@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Bogdan Costescu wrote:
> On Tue, 24 Feb 2009, Victor Lowther wrote:
> 
>> My current plan was to try and mount the NFS share forever
> 
> Generally speaking, with any network based share, if you try to mount it 
> forever you might generate a DoS on the server exporting it, especially 
> if several computers boot at the same time.

That is correct. Although in a nfsroot environment mounting the share 
"forever" (read: lifetime until shutdown) is a necessity.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
