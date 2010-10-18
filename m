From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] [PATCH] Bonding support for dracut
Date: Mon, 18 Oct 2010 16:15:08 +0200
Message-ID: <4CBC566C.9080407@redhat.com>
References: <4CBC37E7.9010904@hoster-ok.com> <4CBC4661.3020100@redhat.com> <4CBC504A.7020002@hoster-ok.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CBC504A.7020002-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/18/2010 03:48 PM, Vladislav Bogdanov wrote:
> 18.10.2010 16:06, Harald Hoyer wrote:
>> On 10/18/2010 02:04 PM, Vladislav Bogdanov wrote:
>>> Hi all,
>>>
>>> I attach patch for bonding support in dracut.
>>> It is against 005 (developed on fedora 13 version).
>>> No documentation yet.
>>> (partially) Tested to work correctly with bond0 alone and bridge on top
>>> of bond0.
>>>
>>> Comments are welcome,
>>>
>>> Best,
>>> Vladislav
>>
>> Please patch against the git version...
>>
>> $ git clone git://dracut.git.sourceforge.net/gitroot/dracut/dracut
>>
>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut
>
> This should be it.

pushed
...


http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=96fb9c8dd708dfbab9cf6515d9a450abb060e623
