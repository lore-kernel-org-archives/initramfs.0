From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [2/3] test suite: automate NFS testing
Date: Fri, 05 Jun 2009 08:51:05 +0200
Message-ID: <4A28C059.6030508@redhat.com>
References: <1244176354.29842.1.camel@obelisk.thedillows.org>	 <1244176478.29842.4.camel@obelisk.thedillows.org> <1244176744.29842.7.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244176744.29842.7.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>, "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/05/2009 06:39 AM, David Dillow wrote:
> On Fri, 2009-06-05 at 00:34 -0400, David Dillow wrote:
>> First cut at automating the NFS test suite.
>
> The second part I'm planning is to remove dnsmasq and require the full
> dhcpd server, so that we can test various combinations of command lines
> and DHCP options by multiple invocations of the client initramfs and
> varying the MAC address. This may also involve expanding the test
> harness to support multiple tests in a single invocation.
>
> Any thoughts or objections?
>

no objections :)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
