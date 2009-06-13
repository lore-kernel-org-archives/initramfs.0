From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] Multiple interfaces support and lots of cmdline
 parsing
Date: Sat, 13 Jun 2009 14:49:38 +0200
Message-ID: <4A33A062.7030208@bfh.ch>
References: <4A327030.1000803@bfh.ch>	 <1244865916.18551.20.camel@obelisk.thedillows.org>	 <4A3360AA.9060600@bfh.ch> <1244895898.18551.30.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244895898.18551.30.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
[snip]
>>> Perhaps a theory of operation/design document as to what the flow is
>>> expected to be, or what is handled where would help?
>> Is it really that complex? I'll write down my thoughts and add in a few 
>> examples.
> 
> I think part of the problem is that your series does too much in each
> step. You have style changes, network device handling changes,
> dhclient.conf changes, and command line parsing changes in the series.
> Each one of those should be its own patch.
> 
> I would suggest getting the dhclient.conf and network device handling
> changes in first; the dhclient.conf change should be uncontroversial and
> we need to get the discussion on the handling going -- that is holding
> back other progress. The command line handling is important, but lower
> priority at the moment in my opinion.

Hmmm... yes and no. To me, the command line handling is important as 
well since at least the ip= parser needs to work for the network handling.

> Also, please try again to get the test suite running locally, and make
> sure any support you add/drop is reflected in the test suite in the same
> patch, if at all possible. This will help demonstrate the effect of the
> changes you are making.

ok, thanks for the great feedback!

Working on getting the test-suite running right now, will try to split 
my patches later the way you suggested. I guess apologies are in order 
for the "mess".

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
