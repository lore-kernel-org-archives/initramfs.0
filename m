From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Get rid of cat and grep
Date: Fri, 05 Jun 2009 16:59:35 +0200
Message-ID: <4A2932D7.6060903@redhat.com>
References: <4A2907E7.1080008@bfh.ch> <1244213032.6963.1.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244213032.6963.1.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 04:43 PM, David Dillow wrote:
> On Fri, 2009-06-05 at 13:56 +0200, Seewer Philippe wrote:
>> cat and grep just bloat the initrd, this patch removes dependencies on them.
>
>> +incol2 /proc/filesystems nfs  || modprobe nfs || exit 1
>> +incol2 /proc/filesystems nfs4 || modprobe nfs || exit 1
>
> While I prefer the conditional list syntax, there has been push back on
> IRC about using it. Consider if xxx then, ugly as it may be.

I would accept that style, but not:

cmd1 && { a; b; c; } || { d; e; f && { g; h; i;}}
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
