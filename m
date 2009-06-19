From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/7] kill the server after the test_run
Date: Fri, 19 Jun 2009 08:20:56 +0200
Message-ID: <4A3B2E48.7030509@redhat.com>
References: <1245331581-2453-1-git-send-email-harald@redhat.com> <1245331581-2453-4-git-send-email-harald@redhat.com> <1245379939.28792.6.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245379939.28792.6.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/19/2009 04:52 AM, David Dillow wrote:
> On Thu, 2009-06-18 at 15:26 +0200, Harald Hoyer wrote:
>> ---
>>   test/TEST-20-NFS/test.sh |    4 ++++
>>   test/TEST-40-NBD/test.sh |    6 ++++++
>
> I wonder why the cleanup function did not kill it for you? It always did
> for me.

well, it helped debugging after several:

$ make run

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
