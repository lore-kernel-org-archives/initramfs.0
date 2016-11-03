From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] add 99memdebug-ko dracut module
Date: Thu, 3 Nov 2016 16:38:26 +0800
Message-ID: <20161103083826.GA15431@dhcp-128-65.nay.redhat.com>
References: <1478077386-30039-1-git-send-email-xlpang@redhat.com>
 <20161103030142.GA3201@dhcp-128-65.nay.redhat.com>
 <581AB9D7.2010905@redhat.com>
 <581AE707.9050606@redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <581AE707.9050606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 11/03/16 at 03:28pm, Xunlei Pang wrote:
[snip]
> > For large trace data(tested on rhel7, the filter doesn't work on rhel7, and will produce huge trace data),
> > the time consumption is huge, I am afraid in minutes because I once suspected the script was in some
> > dead loop when parsing "tracing/trace" directly. It is the same situation when turning off tracing_on and
> > try again.
> 
> Although I don't know why, after I replaced the following scripts
> 1)
> while read pid cpu flags ts function
> do
>     ... ...
> done < "$TRACE_BASE/tracing/trace"
> 
> with
> 
> 2)
> cat "$TRACE_BASE/tracing/trace" | while read pid cpu flags ts function
> do
>     ... ...
> done
> 
> 2) became not time-consuming just like parsing the copied filename in 1) ...

Maybe 1) read the sysfs file a lot of times, but 2) only once then
parsing them in pipe which is quiker.

It should be fine if 2) is acceptable, but if the data is very large it
may worth to use some external program like awk which will be faster.

Thanks
Dave
