From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Please revert commit "There is only one resolv.conf."
Date: Wed, 07 Oct 2009 17:21:45 -0400
Message-ID: <4ACD0669.8010904@redhat.com>
References: <4AB254A3.5000302@bfh.ch> <4AB300B8.4090307@redhat.com> <4AB32C08.2000406@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AB32C08.2000406-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/18/2009 02:43 AM, Seewer Philippe wrote:
>
>
> Warren Togami wrote:
>> On 09/17/2009 11:24 AM, Seewer Philippe wrote:
>>> Having only one resolv.conf is ok for a booted client. That is the
>>> normal and the usual behaviour is that the first interface to be up and
>>> ready with data is the one to write the contents.
>>>
>>> But inside dracut we really do not want that behaviour. First the
>>> primary interface (see bootdev cmdline argument) might not be the first
>>> interface to come up, second if we are in guess-the-interface mode,
>>> multiple interface might receive different data for resolv.conf and we
>>> have to use the correct stuff to mount.
>>>
>>> So please revert that commit.
>>
>> Do you agree the one copied ultimately should be the interface that
>> successfully netbooted?
>
> Well if you mean by that the one ultimately copied to the booted system
> that is correct. Just use the one /etc/resolv.conf after a successful
> mount.
>

modules.d/40network/netroot:
[ -e /tmp/net.$netif.gw ]          && . /tmp/net.$netif.gw
[ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
[ -e /tmp/resolv.conf ] && cp -f /tmp/resolv.conf /etc/resolv.conf

Previous to this change:
[ -e /tmp/net.$netif.gw ]          && . /tmp/net.$netif.gw
[ -e /tmp/net.$netif.hostname ]    && . /tmp/net.$netif.hostname
[ -e /tmp/net.$netif.resolv.conf ] && cp -f /tmp/net.$netif.resolv.conf 
/etc/resolv.conf

Even the previous version appears to not guarantee that /etc/resolv.conf 
is the interface that successfully mounted the rootfs because this 
happens before the mount handler in the netroot script.

Could you please suggest a patch?  Simply reverting it doesn't seem to 
improve things.

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
