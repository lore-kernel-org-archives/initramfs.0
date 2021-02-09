From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Only 16GB of 20GB memory / RAM : found by kernel
Date: Mon, 8 Feb 2021 19:27:45 -0800
Message-ID: <800460be-1d92-cdec-063b-c32c9cbf7010@infradead.org>
References: <CAMr-kF222fGDaLM2RT3U6MAcukB_0nUDSQcJxpfO=bt_WxU4RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=3T90axOItsCfL5nIlFviuB0KBQdViWqsIFFN8ryx0Jo=; b=Swaco0uhchbaxeNzjqP8bdu1yb
        0GmiAGwAG+P/LF4AF4mRLDJDDT+dNQmdI6ptSh/6H9XL55g0t11f3tl6RdkjyrI95zlfBVpxr0Ezk
        uEHtkHrxJwZ9a4vP/OBRftt2CbIwW1F9o5r3xFQW3eLwuPcE4govX082NXs4Ht2Kn30GGE7voM5u1
        l+kCy9xOw4Cfe58dVMDoBwuCocNNH/W4suH7Dd9yMe9l26YzdgIqtbAF4OhspVejrn82oGH+9JToy
        WuTZi8agF+8DY8N4HEv+qmckfVdsRXRLYpVc5qAiC/BmXGPZ99eN3WyxPvjA3wCXGqVQjMdNNl9T4
        jDzmjHtQ==;
In-Reply-To: <CAMr-kF222fGDaLM2RT3U6MAcukB_0nUDSQcJxpfO=bt_WxU4RQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hanasaki Jiji <hanasaki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 2/8/21 5:25 PM, Hanasaki Jiji wrote:
> free -g reports 17GB
> 
> ROM set reports 20GB as does the below (4+16GB)   How to get the 4GB
> bank to usable
> 
> kernel 5.10.x
> 
> ****************
> dmidecode -t memory
> 
> # dmidecode 3.3
> Getting SMBIOS data from sysfs.
> SMBIOS 3.2.1 present.

Hi,

a. wrong mailing list. Please try linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

b. Let us know if this failure is new for 5.10.x or not.
   I.e., did it work previously?

c. Is this an x86 system? Probably need to Cc: some relevant
   maintainers, whether it's x86 or something else.
   Probably also need to provide more boot log info, not just
   dmidecode.

-- 
~Randy

