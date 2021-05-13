From: Hari Bathini <hbathini-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: [PATCH 0/2] Add support to have multi-purpose builds into a single
 initramfs image
Date: Fri, 14 May 2021 02:27:41 +0530
Message-ID: <162093940333.146305.6079089813493806819.stgit@hbathini>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=5vaSg4y5yN7si3KslQoD1XhBU01ytAWKfSkiiVmTba8=;
 b=gYxLusuqBlcRDWvVkFsvOVMTVWZMPfkcpANpLe7PL2cxc7KtmAQIK76UmRkxtFSyfVyP
 dRgu+MlubUCKd3E2qyd+GhmczmTYtL7uEERywrX8U5wbEPEH5zc+V5yTR5BE03bbAohn
 jPbXciUe0S1q/EWVxe7XEiigSX48vKpBlw0aSfuPXkjVJSkiRFR86TF6AZF/0hGlooss
 etZJrXFL/VSVE1lyztEE5nowtMKDHrqBGokWxnyhk+s+iok1XVDp2EGTGHARv9XsZzSm
 FoTMZ8uGNe4GtV/JrLMFbFBkXofbFFfatL3LsoSk3in2fNzTA5eHAEb5HNef0icq0i5u Cw== 
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mahesh J Salgaonkar <mahesh-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sourabh Jain <sourabhjain-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Kairui Song <kasong-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

With the addition of modules.d/99squash module, most of the files in                               
the initramfs image can now be squash'ed. While this saves space, this                             
can also be extended further to provide support for having different                               
initramfs images built into a single image, each squash'ed separately                              
& activated based on different boot scenarios.
        
For that, introduce two dracut options. One, '--squash-input-images':                              
takes a space-separated list of input initramfs images to squash &                                 
include in the initramfs image. Patch one adds this option.                                        
        
Two, '--squash-image-conditional': takes a script file that sets up                                
the appropriate squash image for every possible boot scenario. The                                 
second patch introduces this option.

---

Hari Bathini (2):
      dracut: add a new argument "--squash-input-images"
      dracut/99squash: make sqaush image setup flexible


 dracut.sh                                     | 26 +++++++-
 modules.d/99squash/module-setup.sh            | 17 ++++-
 .../99squash/setup-squash-conditional.sh      | 65 +++++++++++++++++++
 .../99squash/squash-image-conditional.sh      |  5 ++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100755 modules.d/99squash/setup-squash-conditional.sh
 create mode 100755 modules.d/99squash/squash-image-conditional.sh
