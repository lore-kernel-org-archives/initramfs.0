From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/3] 99base: add memtrace-ko.sh to debug kernel module
 large memory consumption
Date: Thu, 24 Nov 2016 08:39:15 +0100
Message-ID: <667da8d4-923d-8cf0-fabe-5f5da7f481e4@redhat.com>
References: <1479103886-24568-1-git-send-email-xlpang@redhat.com>
 <58365135.3040400@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58365135.3040400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Pratyush Anand <panand-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 24.11.2016 03:32, Xunlei Pang wrote:
> Hi Harald,
> 
> Do you have any comment on this patchset?
> 
> If you are ok with it, do I need tosend a pull request in github,or we can handle it directly
> as we have people in dracutdevs groupnow?
> 
> Regards,
> Xunlei

Pull request would be good, because the CI test suite is now triggered with it.

Of course, it would be great, if you would add a test case to the test suite also, so we can verify it works :-)
