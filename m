From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] Add "die" and some minor changes in base
Date: Fri, 12 Jun 2009 15:27:01 -0400
Message-ID: <4A32AC05.8040000@redhat.com>
References: <4A327035.6060100@bfh.ch> <1244821283.15165.2.camel@lap75545.ornl.gov> <4A32A106.1050806@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A32A106.1050806-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/12/2009 02:40 PM, Warren Togami wrote:
> On 06/12/2009 11:41 AM, David Dillow wrote:
>>
>>> +die() {
>>> + printf "FATAL: $1\n"
>>> + printf "Refusing to continue\n"
>>> + exit 1
>>> +}
>>> +
>
> Furthermore, is printf available in the image currently?
>
> It seems other parts of the code already use printf in the image, but
> the printf binary isn't copied in.
>

I see that printf is both a built-in of bash/dash, and also an 
independent binary...

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
