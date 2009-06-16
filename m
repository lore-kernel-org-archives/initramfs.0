From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/5] network/netroot
Date: Tue, 16 Jun 2009 09:53:21 +0200
Message-ID: <4A374F71.6030300@redhat.com>
References: <4A32703A.8080603@bfh.ch> <4A3271CC.9090608@bfh.ch> <4A32B75A.4090405@redhat.com> <4A32C676.6000308@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A32C676.6000308-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/12/2009 11:19 PM, Seewer Philippe wrote:
>
>
> Warren Togami wrote:
>> On 06/12/2009 11:18 AM, Seewer Philippe wrote:
>>> + # Default: We don't know the interface to use, handle all
>>> + else + printf 'ACTION=="add", SUBSYSTEM=="net", RUN+="/sbin/ifup
>>> $env{INTERFACE}"\n'
>>> + fi
>>
>> "else +"?
> *sigh* Why does this ever only happen with bigger patches?

If I save the message to a file, it seems to be correct
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
