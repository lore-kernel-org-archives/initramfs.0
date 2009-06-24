From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [PATCH 4/5] Add DAD do dhclient-script
Date: Wed, 24 Jun 2009 21:56:03 +0200
Message-ID: <4A4284D3.5050007@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch> <1245866912-3643-5-git-send-email-philippe.seewer@bfh.ch> <1245868789.31775.16.camel@lap75545.ornl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245868789.31775.16.camel-FqX9LgGZnHWDB2HL1qBt2PIbXMQ5te18@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

David Dillow wrote:
> On Wed, 2009-06-24 at 20:08 +0200, Philippe Seewer wrote:
>> The manpage for dhclient-script says:
>>
>> Before actually configuring the address, dhclient-script should
>> somehow ARP for it and exit with a nonzero status if it receives a
>> reply.
>>
>> By using arping in dracut this is very easy, since arping has a
>> specific option to do just that.
> 
>> --- a/modules.d/40network/dhclient-script
>> +++ b/modules.d/40network/dhclient-script
>> @@ -64,6 +64,7 @@ case $reason in
>>  	sleep 1
>>  	;;
>>      BOUND)
>> +	arping -q -D -c 2 -I $netif $new_ip_address || exit 1
> 
> Where's the addition of arping to 40network/install?

*sigh* Thanks for noticing, forgot to add it to the commit. Complete
Patch below

---
 modules.d/40network/dhclient-script |    1 +
 modules.d/40network/install         |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 6df630d..3fb8da6 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -64,6 +64,7 @@ case $reason in
 	sleep 1
 	;;
     BOUND)
+	arping -q -D -c 2 -I $netif $new_ip_address || exit 1
 	setup_interface 
 	set | while read line; do
 	    [ "${line#new_}" = "$line" ] && continue
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 0b76cbd..513503c 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-dracut_install ip dhclient hostname
+dracut_install ip dhclient hostname arping
 # Include wired net drivers, excluding wireless
 for modname in $(find "/lib/modules/$kernel/kernel/drivers" -name '*.ko'); do
   if nm -uPA $modname | grep -q eth_type_trans; then
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
