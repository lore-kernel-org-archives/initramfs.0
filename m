From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/8] Netroot updates and multinic test-suite
Date: Wed, 07 Oct 2009 12:53:46 -0400
Message-ID: <4ACCC79A.2000602@redhat.com>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch> <4ACCAAAA.7070003@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ACCAAAA.7070003-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Where?  I don't see these changes at origin/master.

On 10/07/2009 10:50 AM, Harald Hoyer wrote:
> pushed most of these
>
> On 09/17/2009 05:16 PM, Philippe Seewer wrote:
>> A bit late, but this is the corrected updates to netroot I sent
>> a while ago, plus some new things that are needed.
>>
>> Philippe Seewer (8):
>> Give the kernel some time to up interfaces
>> Be a bit more optimistic when setting mtus
>> Get rid of hostname utility
>> Add simple STP timeout handler
>> Add DAD to dhclient-script
>> Add multinic test suite
>> Move write-ifcfg to its own module
>> Move netroot to initqueue
>>
>> modules.d/40network/check | 2 +-
>> modules.d/40network/dhclient-script | 24 +++-
>> modules.d/40network/ifup | 5 +-
>> modules.d/40network/install | 6 +-
>> modules.d/40network/net-genrules.sh | 2 +-
>> modules.d/40network/netroot | 23 ++++
>> modules.d/40network/write-ifcfg.sh | 52 --------
>> modules.d/45ifcfg/check | 6 +
>> modules.d/45ifcfg/install | 2 +
>> modules.d/45ifcfg/write-ifcfg.sh | 60 +++++++++
>> modules.d/99base/init | 11 +--
>> test/TEST-50-MULTINIC/Makefile | 10 ++
>> test/TEST-50-MULTINIC/client-init | 9 ++
>> test/TEST-50-MULTINIC/dhcpd.conf | 36 ++++++
>> test/TEST-50-MULTINIC/exports | 1 +
>> test/TEST-50-MULTINIC/hard-off.sh | 2 +
>> test/TEST-50-MULTINIC/hosts | 5 +
>> test/TEST-50-MULTINIC/server-init | 30 +++++
>> test/TEST-50-MULTINIC/test.sh | 226 +++++++++++++++++++++++++++++++++++
>> 19 files changed, 436 insertions(+), 76 deletions(-)
>> delete mode 100755 modules.d/40network/write-ifcfg.sh
>> create mode 100755 modules.d/45ifcfg/check
>> create mode 100755 modules.d/45ifcfg/install
>> create mode 100755 modules.d/45ifcfg/write-ifcfg.sh
>> create mode 100644 test/TEST-50-MULTINIC/Makefile
>> create mode 100755 test/TEST-50-MULTINIC/client-init
>> create mode 100644 test/TEST-50-MULTINIC/dhcpd.conf
>> create mode 100644 test/TEST-50-MULTINIC/exports
>> create mode 100755 test/TEST-50-MULTINIC/hard-off.sh
>> create mode 100644 test/TEST-50-MULTINIC/hosts
>> create mode 100755 test/TEST-50-MULTINIC/server-init
>> create mode 100755 test/TEST-50-MULTINIC/test.sh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe initramfs" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
