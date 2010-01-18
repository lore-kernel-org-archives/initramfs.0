From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Ensure UNICODE keyboard layout is functional in	emergency
 shell
Date: Mon, 18 Jan 2010 10:11:36 +0100
Message-ID: <4B5425C8.40207@redhat.com>
References: <201001081054.55497.arvidjaar@mail.ru> <20100109085009.GA29904@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100109085009.GA29904-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Cc: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 01/09/2010 09:50 AM, Luca Berra wrote:
> this one is rebased against the kbd patch i sent earlier.
>
> regards,
> L.
> On Fri, Jan 08, 2010 at 10:54:55AM +0300, Andrey Borzenkov wrote:
>> The attached patch ensures that keyboard in emergency shell more
>> closely corresponds to live system. I am not sure about UNIKEYTABLE
>> which console_init checks as well - if it is not artifact, it can be
>> easily added as well.
>>
>> -andrey
>

pushed
