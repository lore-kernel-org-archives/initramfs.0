From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] add iSCSI module
Date: Tue, 02 Jun 2009 14:07:36 +0200
Message-ID: <4A251608.4050801@redhat.com>
References: <1243942901-5474-1-git-send-email-harald@redhat.com>	 <1243942901-5474-2-git-send-email-harald@redhat.com> <1243944299.647.39.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243944299.647.39.camel-76q0VzFBGGr21HsLBtNmTckMGDeJXHgy@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/02/2009 02:04 PM, Victor Lowther wrote:
> On Tue, 2009-06-02 at 13:41 +0200, Harald Hoyer wrote:
>> ---
>>   modules.d/95iscsi/check              |   11 +++
>>   modules.d/95iscsi/install            |    8 ++
>>   modules.d/95iscsi/iscsi-netroot.sh   |   13 ++++
>>   modules.d/95iscsi/iscsiroot          |  121 ++++++++++++++++++++++++++++++++++
>>   modules.d/95iscsi/parse-iscsiroot.sh |   37 ++++++++++
>>   test/TEST-30-ISCSI/Makefile          |   10 +++
>>   test/TEST-30-ISCSI/create-root.sh    |   34 ++++++++++
>>   test/TEST-30-ISCSI/cryptroot-ask     |    6 ++
>>   test/TEST-30-ISCSI/hard-off.sh       |    2 +
>>   test/TEST-30-ISCSI/test.sh           |   68 +++++++++++++++++++
>>   10 files changed, 310 insertions(+), 0 deletions(-)
>>   create mode 100755 modules.d/95iscsi/check
>>   create mode 100755 modules.d/95iscsi/install
>>   create mode 100755 modules.d/95iscsi/iscsi-netroot.sh
>>   create mode 100755 modules.d/95iscsi/iscsiroot
>>   create mode 100755 modules.d/95iscsi/parse-iscsiroot.sh
>>   create mode 100644 test/TEST-30-ISCSI/Makefile
>>   create mode 100755 test/TEST-30-ISCSI/create-root.sh
>>   create mode 100755 test/TEST-30-ISCSI/cryptroot-ask
>>   create mode 100755 test/TEST-30-ISCSI/hard-off.sh
>>   create mode 100755 test/TEST-30-ISCSI/test.sh
>
> Perhaps I missed it, but where do you create the VM that hosts the isci
> target?  That would make fully automating this test much easier for
> those of us who do not have a spare iscsi target lying around.
>

Well, for now, I hosted the iSCSI disk on a local NAS.
But, we could setup a small virtual machine that serves the iSCSI disk. I was 
just too lazy to do that step now :-)
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
