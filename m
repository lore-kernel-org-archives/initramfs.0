From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/11] More test suite stuff (and bug fixes)
Date: Mon, 08 Jun 2009 15:11:41 +0200
Message-ID: <4A2D0E0D.2060303@redhat.com>
References: <cover.1244435634.git.dave@thedillows.org> <1244436164.23139.8.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1244436164.23139.8.camel-1q1vX8mYZiGLUyTwlgNVppKKF0rrzTr+@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/08/2009 06:42 AM, David Dillow wrote:
> On Mon, 2009-06-08 at 00:40 -0400, David Dillow wrote:
>> This add more comprehensive tests to the NFS test suite, such as
>> verifying that we used the right server IP address, and that we
>> added mount options appropriately. It may be a bit too comprehensive,
>> as it takes over 7 minutes to run for me.
>>
>> Also of note, I addded support for a default NFS path and %s
>> substitution as done by the kernel's nfsroot handling.
>>
>> This also has the first round of testing for NBD root, and a fix
>> for a bug found by the test suite.
>
> Of course, I forgot to mention that this series is based on the one I
> posted Saturday morning.
>
> You can get all of the changes at http://thedillows.org/dracut.git
>

Excellent! Thank you very much!

Pulled and merged into main repo, though I had to make some changes to make it 
pass on Fedora 11.

It seems NFS4 mount only works on Fedora 11, if the ipv6 module is loaded.
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
