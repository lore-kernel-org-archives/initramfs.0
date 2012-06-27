From: Srinivasa T N <seenutn-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/1] Convert MAC in BOOTIF parameter to lower case
Date: Wed, 27 Jun 2012 17:07:51 +0530
Message-ID: <4FEAF08F.1030103@linux.vnet.ibm.com>
References: <4FEA00BC.8090505@linux.vnet.ibm.com> <20120627203314.2e0136c1@kryten>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090000040708070106050905"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120627203314.2e0136c1@kryten>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------090000040708070106050905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/27/2012 04:03 PM, Anton Blanchard wrote:
>
> Hi,
>
>> The patch at
>> http://comments.gmane.org/gmane.linux.kernel.initramfs/2244 takes
>> care of only the MAC conversion to lower case in the interface name.
>> But the same has to be taken care for BOOTIF also.  This patch takes
>> care of changing the BOOTIF to lower case.
>>
>> Note that sed has been used instead of tr, as dracut does not install
>> tr to the initramfs, atleast on RHEL 6.x.
>
> Good to know, could you replace the existing interface MAC conversion
> with sed too?
>

Attached a patch to do the same.

Regards,
Seenu.

--------------090000040708070106050905
Content-Type: application/x-shellscript;
 name="convert-mac-to-lower-parse-ifname.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="convert-mac-to-lower-parse-ifname.sh"

RnJvbSAyZWM5YzkxYWRiZjgwOGRiYWQ5YmRkMjA1N2Q5ZGY1NWE2MmI3MTFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhc2EgVCBOIDxzZWVudXRuQGxpbnV4LnZu
ZXQuaWJtLmNvbT4KRGF0ZTogV2VkLCAyNyBKdW4gMjAxMiAxMToyMDoxMyArMDUzMApTdWJq
ZWN0OiBbUEFUQ0ggMS8yXSBGaXhlZCBCT09USUYgZm9yIGNvbnZlcnRpbmcgbWFjIGFkZHIg
dG8gbG93ZXJjYXNlCgotLS0KIG1vZHVsZXMuZC80MG5ldHdvcmsvbmV0LWdlbnJ1bGVzLnNo
IHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL21vZHVsZXMuZC80MG5ldHdvcmsvbmV0LWdlbnJ1bGVz
LnNoIGIvbW9kdWxlcy5kLzQwbmV0d29yay9uZXQtZ2VucnVsZXMuc2gKaW5kZXggOTlkMGZl
NS4uYjJmNGZiZiAxMDA3NTUKLS0tIGEvbW9kdWxlcy5kLzQwbmV0d29yay9uZXQtZ2VucnVs
ZXMuc2gKKysrIGIvbW9kdWxlcy5kLzQwbmV0d29yay9uZXQtZ2VucnVsZXMuc2gKQEAgLTEw
LDcgKzEwLDggQEAgZml4X2Jvb3RpZigpIHsKICAgICBtYWNhZGRyPSR7bWFjYWRkciU6fQog
ICAgICMgc3RyaXAgaGFyZHdhcmUgdHlwZSBmaWVsZCBmcm9tIHB4ZWxpbnV4CiAgICAgWyAt
biAiJHttYWNhZGRyJT8/Oj8/Oj8/Oj8/Oj8/Oj8/fSIgXSAmJiBtYWNhZGRyPSR7bWFjYWRk
ciM/Pzp9Ci0gICAgZWNobyAkbWFjYWRkcgorICAgICMgcmV0dXJuIG1hY2FkZHIgd2l0aCBs
b3dlcmNhc2UgYWxwaGEgY2hhcmFjdGVycyBleHBlY3RlZCBieSB1ZGV2CisgICAgZWNobyAk
bWFjYWRkciB8IHNlZCAneS9BQkNERUYvYWJjZGVmLycKIH0KIAogIyBEb24ndCBjb250aW51
ZSBpZiB3ZSBkb24ndCBuZWVkIG5ldHdvcmsKLS0gCjEuNy40LjQKCgo=
--------------090000040708070106050905--
