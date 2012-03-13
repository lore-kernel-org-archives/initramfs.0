From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [PATCH-v3 1/2] systemd: mount the securityfs
 filesystem at early stage
Date: Tue, 13 Mar 2012 19:38:01 +0100
Message-ID: <4F5F9409.6060706@polito.it>
References: <1331655340-11595-1-git-send-email-roberto.sassu@polito.it>
	<20120313173911.GY838@rampage>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120313173911.GY838@rampage>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: systemd-devel@lists.freedesktop.org, initramfs@vger.kernel.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, mzerqung@0pointer.de, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it, d@falconindy.com

On 03/13/2012 06:39 PM, Dave Reisner wrote:
> On Tue, Mar 13, 2012 at 05:15:35PM +0100, Roberto Sassu wrote:
>> The mount of the securityfs filesystem is now performed in the main systemd
>> executable as it is used by IMA to provide the interface for loading custom
>> policies. The unit file 'units/sys-kernel-security.mount' has been removed
>> because it is not longer necessary.
>>
>> Signed-off-by: Roberto Sassu<roberto.sassu@polito.it>
>> Acked-by: Gianluca Ramunno<ramunno@polito.it>
>> ---
>>   Makefile.am                     |    3 ---
>>   src/mount-setup.c               |    6 ++++--
>>   units/sys-kernel-security.mount |   17 -----------------
>>   3 files changed, 4 insertions(+), 22 deletions(-)
>>   delete mode 100644 units/sys-kernel-security.mount
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index d2bd340..c0fcd70 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -291,7 +291,6 @@ dist_systemunit_DATA = \
>>   	units/dev-mqueue.mount \
>>   	units/sys-kernel-config.mount \
>>   	units/sys-kernel-debug.mount \
>> -	units/sys-kernel-security.mount \
>>   	units/sys-fs-fuse-connections.mount \
>>   	units/var-run.mount \
>>   	units/media.mount \
>> @@ -2342,7 +2341,6 @@ systemd-install-data-hook:
>>   			dev-mqueue.mount \
>>   			sys-kernel-config.mount \
>>   			sys-kernel-debug.mount \
>> -			sys-kernel-security.mount \
>>   			sys-fs-fuse-connections.mount \
>>   			systemd-modules-load.service \
>>   			systemd-tmpfiles-setup.service \
>> @@ -2352,7 +2350,6 @@ systemd-install-data-hook:
>>   		$(LN_S) ../dev-mqueue.mount dev-mqueue.mount&&  \
>>   		$(LN_S) ../sys-kernel-config.mount sys-kernel-config.mount&&  \
>>   		$(LN_S) ../sys-kernel-debug.mount sys-kernel-debug.mount&&  \
>> -		$(LN_S) ../sys-kernel-security.mount sys-kernel-security.mount&&  \
>>   		$(LN_S) ../sys-fs-fuse-connections.mount sys-fs-fuse-connections.mount&&  \
>>   		$(LN_S) ../systemd-modules-load.service systemd-modules-load.service&&  \
>>   		$(LN_S) ../systemd-tmpfiles-setup.service systemd-tmpfiles-setup.service&&  \
>> diff --git a/src/mount-setup.c b/src/mount-setup.c
>> index 7c14ea8..75d5cae 100644
>> --- a/src/mount-setup.c
>> +++ b/src/mount-setup.c
>> @@ -51,13 +51,15 @@ typedef struct MountPoint {
>>   } MountPoint;
>>
>>   /* The first three entries we might need before SELinux is up. The
>> - * other ones we can delay until SELinux is loaded. */
>> -#define N_EARLY_MOUNT 3
>> + * fourth (securityfs) is needed by IMA to load a custom policy. The
>> + * other ones we can delay until SELinux and IMA are loaded. */
>> +#define N_EARLY_MOUNT 4
>>
>>   static const MountPoint mount_table[] = {
>>           { "proc",     "/proc",                  "proc",     NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
>>           { "sysfs",    "/sys",                   "sysfs",    NULL,                MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
>>           { "devtmpfs", "/dev",                   "devtmpfs", "mode=755",          MS_NOSUID,                    true },
>> +        { "securityfs", "/sys/kernel/security", "securityfs", NULL,              MS_NOSUID|MS_NOEXEC|MS_NODEV, true },
>
> Failure to mount securtiyfs might be fatal for _your_ purposes, but I'd
> wager that not only are some people not interested in this, but some
> people (myself included) might not even have securityfs in their kernel.
>

Hi Dave

i think i can change this to false without breaking
the other code, because at the beginning of the new
file 'src/ima-setup.c' i check for the IMA support in
the kernel by checking the existence of the
'/sys/kernel/security/ima' directory. If the mount
fails, this will be handled as the same as when the
IMA support is disabled in the kernel.
This could be acceptable because IMA requires the
security filesystem as dependency.

I'll wait for other comments before reposting the patches.

Thanks

Roberto Sassu


> dave
>
>>           { "tmpfs",    "/dev/shm",               "tmpfs",    "mode=1777",         MS_NOSUID|MS_NODEV,           true },
>>           { "devpts",   "/dev/pts",               "devpts",   "mode=620,gid=" STRINGIFY(TTY_GID), MS_NOSUID|MS_NOEXEC, false },
>>           { "tmpfs",    "/run",                   "tmpfs",    "mode=755",          MS_NOSUID|MS_NODEV, true },
>> diff --git a/units/sys-kernel-security.mount b/units/sys-kernel-security.mount
>> deleted file mode 100644
>> index 80cd761..0000000
>> --- a/units/sys-kernel-security.mount
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -#  This file is part of systemd.
>> -#
>> -#  systemd is free software; you can redistribute it and/or modify it
>> -#  under the terms of the GNU General Public License as published by
>> -#  the Free Software Foundation; either version 2 of the License, or
>> -#  (at your option) any later version.
>> -
>> -[Unit]
>> -Description=Security File System
>> -DefaultDependencies=no
>> -ConditionPathExists=/sys/kernel/security
>> -Before=sysinit.target
>> -
>> -[Mount]
>> -What=securityfs
>> -Where=/sys/kernel/security
>> -Type=securityfs
>> --
>> 1.7.7.6
>>
>
>
>
>> _______________________________________________
>> systemd-devel mailing list
>> systemd-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/systemd-devel
>
