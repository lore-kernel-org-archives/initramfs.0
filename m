From: Vladislav Bogdanov <bubble-Awb4OmSD/41iLUuM0BA3LQ@public.gmane.org>
Subject: Re: [RFC] [PATCH] Bonding support for dracut
Date: Mon, 18 Oct 2010 17:31:36 +0300
Message-ID: <4CBC5A48.1010304@hoster-ok.com>
References: <4CBC37E7.9010904@hoster-ok.com> <4CBC4661.3020100@redhat.com> <4CBC504A.7020002@hoster-ok.com> <4CBC566C.9080407@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CBC566C.9080407-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

18.10.2010 17:15, Harald Hoyer wrote:
> On 10/18/2010 03:48 PM, Vladislav Bogdanov wrote:
>> 18.10.2010 16:06, Harald Hoyer wrote:
>>> On 10/18/2010 02:04 PM, Vladislav Bogdanov wrote:
>>>> Hi all,
>>>>
>>>> I attach patch for bonding support in dracut.
>>>> It is against 005 (developed on fedora 13 version).
>>>> No documentation yet.
>>>> (partially) Tested to work correctly with bond0 alone and bridge on top
>>>> of bond0.
>>>>
>>>> Comments are welcome,
>>>>
>>>> Best,
>>>> Vladislav
>>>
>>> Please patch against the git version...
>>>
>>> $ git clone git://dracut.git.sourceforge.net/gitroot/dracut/dracut
>>>
>>> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut
>>
>> This should be it.
> 
> pushed
> ...
> 
> 
> http://dracut.git.sourceforge.net/git/gitweb.cgi?p=dracut/dracut;a=commitdiff;h=96fb9c8dd708dfbab9cf6515d9a450abb060e623

Ahmmm....
So quick :)
I was ready for a long discussion :)

Some notes:

There is no documentation yet :( and it should not be forgotten to add
it. I generally hate to edit XML by hands. Could someone who operates
some magic XML tools do it?

Also both original patch (against 005) and commit message has a typo (in
head comments):
bond=bond0:eth0,eth1:balance-rr
should be really
bond=bond0:eth0,eth1:mode=balance-rr

Patch against git has this corrected (together with one more typo -
s/DEVICE/netif/)

Or even better third clause (options) should be omitted from that line:
it remained from a revision where I had mode as a separate clause.
Current version leaves all options defaulting to bonding.ko (and
balance-rr is its default mode btw).

One more is a mode of parse-bond.sh which should be 0755 (for consistency?).

And last, this should be tested thoroughly. I only did limited testing -
not all use cases, especially not with default values. It seems to be
correct, but I'm not 100% sure.

Best,
Vladislav
