From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] mkinitrd-dracut.sh: Build host images for default_kernel_images
 and -i/-k paths
Date: Fri, 04 Oct 2013 13:58:28 +0200
Message-ID: <524EAD64.9040001@redhat.com>
References: <1380305940-64410-1-git-send-email-trenn@suse.de> <1380305940-64410-7-git-send-email-trenn@suse.de> <524BF48D.2030803@redhat.com> <4360710.7nGyE1EdAP@skinner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4360710.7nGyE1EdAP@skinner>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/04/2013 01:42 PM, Thomas Renninger wrote:
> On Wednesday, October 02, 2013 12:25:17 PM Harald Hoyer wrote:
>> On 09/27/2013 08:19 PM, Thomas Renninger wrote:
> ...
>>> @@ -119,8 +122,8 @@ while (($# > 0)); do
>>>
>>>          --version)
>>>          
>>>              echo "mkinitrd: dracut compatibility wrapper"
>>>              exit 0;;
>>>
>>> -        -v|--verbose) dracut_args="${dracut_args} -v";;
>>> -        -f|--force) dracut_args="${dracut_args} -f";;
>>> +        -v|--verbose) dracut_args="${dracut_args} -v --keep";;
>>
>> do you really want to keep the entire files in /var/tmp/<tmpdir>  for
>> --verbose?
> No, that was not intended.
> What about the rest? If it is ok, I would re-post this series.
> 
> Thanks,
> 
>    Thomas

Pushed all + removed the "--keep"
