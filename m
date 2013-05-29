From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] 50drm: Install dracut 50drm module in hostonly mode when
 drm driver is currently in use.
Date: Wed, 29 May 2013 10:45:28 +0800
Message-ID: <51A56BC8.2010205@redhat.com>
References: <1369383763-24956-1-git-send-email-chaowang@redhat.com> <51A49E65.9000206@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A49E65.9000206-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/28/2013 08:09 PM, Harald Hoyer wrote:
> On 05/24/2013 10:22 AM, WANG Chao wrote:
>> Now only 50plymouth module can pull in 50drm and that's very limited.
>> Because KMS capable drm drivers are much needed in initrd to have a
>> frame buffer console on the screen.
>>
>> Particularly, when building kdump initrd, plymouth module is omitted,
>> but drm is necessary to setup a working screen for one sitting in front
>> of a monitor.
>>
>> Signed-off-by: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  modules.d/50drm/module-setup.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
>> index bf33c5b..648e8f4 100644
>> --- a/modules.d/50drm/module-setup.sh
>> +++ b/modules.d/50drm/module-setup.sh
>> @@ -3,6 +3,10 @@
>>  # ex: ts=8 sw=4 sts=4 et filetype=sh
>>  
>>  check() {
>> +    if [[ $hostonly ]] && [ -d /sys/module/drm/drivers ]; then
>> +        return 0
>> +    fi
>> +
>>      return 255
>>  }
>>  
>>
> 
> Hmm, why not let the kdump module depend on drm?

If you do not like it we can consider add it to kdump module..

> 
> depends() {
>     echo drm
> }
> 
> Anyway, do we really need drm for a simple console? Those drivers are really
> really big and take a long time to load and initialize?

It's a little awkward, after kernel crashing suppose 1st kernel is in
kms mode, it can not reset to nomodeset, so screen will keep black.

There's no such issue in normal initramfs because bios always reset
devices for us.

> 


-- 
Thanks
Dave

