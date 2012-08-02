From: Wang Chao <wangchao19890207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Revert "dracut-functions: $_x should exist, no need to
 test."
Date: Thu, 02 Aug 2012 20:29:26 +0800
Message-ID: <501A72A6.4040105@gmail.com>
References: <1343791422-8391-1-git-send-email-chaowang@redhat.com> <5019953D.6080203@ziu.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LYJlbMagqWjN508+8/AzkttgSzoOsca5KWfsa8cZQy8=;
        b=vq6XcRd8uT9T4eHkkbIu4cnwUZWX4NzV67XWqB396RH6k07D4ZADfvOFB4HcPBsHkL
         djwfX9iumw9rH8x3rlqsSc9dXY/UbJh4/+Eodv9yR4d58DsFWkDmIs5XiYog+AR0UGAJ
         m+VVw1OyRNeR8EA5nRsLpGqYlBDhacwZ2KzQB5t7RccUH97Bc/f5So2/C3TUeKeIqrEd
         GB+c8pMVMRC+3fY3mnPt2FDxnYkNksfM8kephVU1MYfKc4qTewq+tRPCnV5C5jggBDuf
         7c67X0bErFGZLU9eQJ5+IdnOEAjCkB7kn4r6diuh5/IaEuWxrZgVvG4G78jUoBjJz3hb
         hVQQ==
In-Reply-To: <5019953D.6080203-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Cc: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 08/02/2012 04:44 AM, Michal Soltys wrote:
> On 2012-08-01 05:23, Chao Wang wrote:
>> This reverts commit b2d225a6698607bbcb73b6e6d12fbfc5be014102.
>>
>
> For the record, your original commit could work after setting:
>
> shopt -s nullglob
>
> For failing globs this expands to empty string and the loop is never
> executed. All kinds of such checks could go away in any bash-expecting
> script.

Good to know! Thank you!

-Chao
