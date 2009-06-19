From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH 3/7] kill the server after the test_run
Date: Thu, 18 Jun 2009 22:52:19 -0400
Message-ID: <1245379939.28792.6.camel@lap75545.ornl.gov>
References: <1245331581-2453-1-git-send-email-harald@redhat.com>
 <1245331581-2453-4-git-send-email-harald@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1245331581-2453-4-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 2009-06-18 at 15:26 +0200, Harald Hoyer wrote:
> ---
>  test/TEST-20-NFS/test.sh |    4 ++++
>  test/TEST-40-NBD/test.sh |    6 ++++++

I wonder why the cleanup function did not kill it for you? It always did
for me.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
