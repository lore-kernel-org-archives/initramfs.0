From: Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] let user specify action after systemd start dracut-emergency
Date: Wed, 29 May 2013 17:15:35 +0800
Message-ID: <51A5C737.5050902@redhat.com>
References: <078c160e62c2c750efe71fc8a05dd7c5de71bde3.1369809156.git.bhe@redhat.com> <d493350a355dc81998fd9a0b2d543ca79c2eb0c7.1369809156.git.bhe@redhat.com> <51A5A3A2.8070403@redhat.com> <51A5A828.5040700@redhat.com> <51A5C256.6070107@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51A5C256.6070107-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 05/29/2013 04:54 PM, Harald Hoyer wrote:

>>> >>
>>> >> ! action_on_fail "Systemd is starting emergency shell" && exec sh -i -l
>>> >> ------->
>>> >> action_on_fail "Systemd is starting emergency shell"
>>> >>
>> > 
>> > Well, I was wrong. Looks like the dracut-emergency will hang there, not
>> > interactive.
>> > 
>> > will post again.
>> > 
>> > Baoquan
>> > Thanks a lot
>> > 
> Does adding ConditionKernelCommandLine=!action_on_fail=continue to the [Unit]
> section of dracut-emergency.service work for you?


It is also good. But I tried it just now, it didn't work. I don't know why.
