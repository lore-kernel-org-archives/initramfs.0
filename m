From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: why not install selinux with systemd being used
Date: Mon, 27 May 2013 13:40:34 +0200
Message-ID: <51A34632.8040901@redhat.com>
References: <519C9A2E.2080100@redhat.com> <519C9A7C.7080904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <519C9A7C.7080904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Baoquan <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On 05/22/2013 12:14 PM, Dave Young wrote:
> On 05/22/2013 06:13 PM, Dave Young wrote:
>> Hi, Harald
>>
>> I have a question about selinux module.
>>
>> In dracut.spec there's below code:
>>
>> %if %{defined _unitdir}
>> # with systemd IMA and selinux modules do not make sense
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/96securityfs
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/97masterkey
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98integrity
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98selinux
>> %endif
>>
>> I'm confused why they are excluded for systemd?
>>
>> And how can we load selinux policy in initramfs without 98selinux now?

Do you have to load the selinux policy in the initramfs?
systemd does it after switching to the real root.
