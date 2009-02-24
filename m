From: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 14:49:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0902241446170.22015@kenzo.iwr.uni-heidelberg.de>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
  <49A301FF.2090303@redhat.com>  <1235434056.28090.28.camel@sentry-no.fnordovax.org>
  <49A3AB75.1010805@bfh.ch> <1235475578.28090.64.camel@sentry-no.fnordovax.org>
 <49A3F43F.6000103@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A3F43F.6000103-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 24 Feb 2009, Seewer Philippe wrote:

> - Why are you killing dhclient at the end?

I can see at least 2 reasons:
- dhclient coming from the initramfs is started on that FS and should
   not be running across the switch_root
- to give the possibility to the actual system being booted to use its
   own network configuration mechanism, be it also DHCP or something
   else

-- 
Bogdan Costescu

IWR, University of Heidelberg, INF 368, D-69120 Heidelberg, Germany
Phone: +49 6221 54 8240, Fax: +49 6221 54 8850
E-mail: bogdan.costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
