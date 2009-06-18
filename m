From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: root=dhcp dhclient segfaulting on F-11
Date: Thu, 18 Jun 2009 10:34:20 +0200
Message-ID: <4A39FC0C.8020305@bfh.ch>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch> <4A3924B9.2090303@redhat.com> <4A398A7C.40003@redhat.com> <4A39A3D1.4070404@redhat.com> <4A39ED97.8040503@bfh.ch> <4A39F862.7060200@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A39F862.7060200-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Harald Hoyer wrote:
> On 06/18/2009 09:32 AM, Seewer Philippe wrote:
>>
>>
>> Warren Togami wrote:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=506626
>>>
>>> Filed the dhclient segfault here. I've been trying to debug this for
>>> the past 5 hours straight. I'm perplexed.
>>>
>>> Backing out to 1a945a576c0016c47f983d27727443ac33c5b6a8 prior to
>>> Phillippe's patch series dhclient does not crash.
>>
>> That is weird. I have no problems at all with isc-dhclient-V3.1.1
>>
>> Question: Does it segfault in the test-suites as well?
>>
> 
> WORKSFORME
> fine with: dhclient-4.1.0-20.fc11.x86_64

I've not been able to reproduce the segfault.

But I've got the dhcp decline in vanilla isc dhclient-4.1. 

Apparently dhclient-4.1 calls the dhclient-script twice with
reason BOUND. I have no idea why. But my dhclient-script has
(sadly) a small bug, which causes the dhclient to loop
endlessly and dhclient always declining.

Patch below fixes this, but I have absolutely no idea why.

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 80ab54c..4153eb8 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -43,12 +43,12 @@ if getarg rdnetdebug ; then
     set -x
 fi
 
-# Huh? Interface configured?
-[ -f "/tmp/net.$netif.up" ] && exit 0
-
 # We already need a set netif here
 netif=$interface
 
+# Huh? Interface configured?
+[ -f "/tmp/net.$netif.up" ] && exit 0
+
 case $reason in
     PREINIT)
 	ip link set $netif up
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
