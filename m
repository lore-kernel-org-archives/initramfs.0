From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] Multiple interfaces support and lots of cmdline
 parsing
Date: Wed, 17 Jun 2009 08:49:27 +0200
Message-ID: <4A3891F7.8060501@bfh.ch>
References: <4A327030.1000803@bfh.ch>	 <1244865916.18551.20.camel@obelisk.thedillows.org>	 <4A3360AA.9060600@bfh.ch> <1244895898.18551.30.camel@obelisk.thedillows.org> <4A33A062.7030208@bfh.ch> <4A36748E.7060408@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A36748E.7060408-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Warren Togami wrote:
> On 06/13/2009 08:49 AM, Seewer Philippe wrote:
>>
>> Working on getting the test-suite running right now, will try to split
>> my patches later the way you suggested. I guess apologies are in order
>> for the "mess".
> 
> Hi,
> 
> We are still waiting for a git repo to pull from so we can review this 
> patch set.  Please split unrelated changes into their own commits and 
> write detailed changelog entries on each.

There you go

http://github.com/seewer/dracut-seewer/commits/master

Patches are split as atomically as made sense (to me). Except for the 
ISCSI test-suite which I've ignored, all tests now pass. Accordingly the 
tree contains some fixes that weren't in the patches last week, this is 
mainly to fix the test-suites to run with Debian based distros and some 
enhancments that were discovered while running the test cases.

As for further examples how the multinic stuff should work, I've tried 
document an example in the two last multinic patches:

http://github.com/seewer/dracut-seewer/commit/db8158439dac10e7462203d3de44fd794bd35e2b
http://github.com/seewer/dracut-seewer/commit/8ecd9d010a46999263b629b16954156e34083244

Apologies it took longer than expected, the only thing I can say there 
is that Murphy is always right.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
