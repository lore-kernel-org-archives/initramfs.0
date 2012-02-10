From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: dracut: ordering of modules
Date: Fri, 10 Feb 2012 10:01:55 -0500
Message-ID: <1328886121.2472.19.camel@falcor>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs@vger.kernel.org
Cc: Harald Hoyer <harald@redhat.com>, linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@polito.it>

Hi Harald,

Originally, 98integrity/ima-policy-load.sh didn't start executing before
98selinux/selinux-loadpolicy.sh finished, but unfortunately it now does.

inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
inst_hook pre-pivot 62 "$moddir/ima-policy-load.sh"

As the IMA policy could be dependent on LSM runtime info, this is a
problem.

[   10.040574] type=1805 audit(1328865524.387:2): action="dont_measure" fsmagic="0x9fa0" res=0
[   10.040663] type=1805 audit(1328865524.387:3): action="dont_appraise" fsmagic="0x9fa0" res=0
[   10.040729] type=1805 audit(1328865524.387:4): action="dont_measure" fsmagic="0x62656572" res=0
[   10.040792] type=1805 audit(1328865524.387:5): action="dont_appraise" fsmagic="0x62656572" res=0
[   10.040857] type=1805 audit(1328865524.387:6): action="dont_measure" fsmagic="0x64626720" res=0
[   10.040921] type=1805 audit(1328865524.387:7): action="dont_appraise" fsmagic="0x64626720" res=0
[   10.040985] type=1805 audit(1328865524.387:8): action="dont_measure" fsmagic="0x01021994" res=0
[   10.041047] type=1805 audit(1328865524.387:9): action="dont_appraise" fsmagic="0x01021994" res=0
[   10.041113] type=1805 audit(1328865524.387:10): action="dont_measure" fsmagic="0x73636673" res=0
[   10.041177] type=1805 audit(1328865524.387:11): action="dont_appraise" fsmagic="0x73636673" res=0
[   11.898956] SELinux:  Completing initialization.

I've tried adding a depend for selinux, but it doesn't seem to resolve
the problem, nor does delaying 98integrity to later.  Any suggestions
would be appreciated.

thanks,

Mimi
