From: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] 98integrity: Use /etc/ima as dir for IMA policy and
 config file
Date: Wed, 30 Nov 2016 10:24:08 -0500
Message-ID: <2bda8815-b753-a0b4-b69a-2317dbeb8b33@linux.vnet.ibm.com>
References: <1480518634-31897-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <5526de6b-c774-f94b-30ce-065e03d28ce3@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5526de6b-c774-f94b-30ce-065e03d28ce3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On 11/30/2016 10:16 AM, Harald Hoyer wrote:
> On 30.11.2016 16:10, Stefan Berger wrote:
>> From: Stefan Berger <stefanb-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
>>
>> To sync with systemd, use the filepath /etc/ima/ima-policy as
>> the file location for the IMA policy. At the same time we
>> move the ima config file location to /etc/ima/ima. Adapt the
>> documentation to the new path.
>>
>> Signed-off-by: Stefan Berger <stefanb-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>
> One more thing: Do you want to be backwards compatible and also read the old files, if they exist?

I had thought about that and can certainly add it.  Neither Fedora, 
RHEL, nor SUSE are packaging these files so far. So likely there aren't 
many users out there. Considering that, what would you suggest?
