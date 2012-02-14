From: Daniel J Walsh <dwalsh-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dracut: ordering of modules
Date: Tue, 14 Feb 2012 13:53:21 -0500
Message-ID: <4F3AADA1.5090508@redhat.com>
References: <1328886121.2472.19.camel@falcor> <4F38DEF0.8010202@redhat.com> <4F38E337.7030200@polito.it> <4F38E5F4.9070009@redhat.com> <4F3941A2.3040205@redhat.com> <4F3A836E.1020208@polito.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F3A836E.1020208-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, selinux-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/14/2012 10:53 AM, Roberto Sassu wrote:
> Hi Dan
> 
> i confirm this issue happens in a Fedora 16 system with the 
> selinux-policy package installed.
> 
> The selinux dracut module tries to load the policy but returns with
> the error below. After switching root, the policy is successfully
> loaded by Systemd.
> 
> Thanks
> 
> Roberto Sassu
> 
> 
Well in F16 dracut is not supposed to load the policy.
> On 02/13/2012 06:00 PM, Daniel J Walsh wrote: On 02/13/2012 05:29
> AM, Harald Hoyer wrote:
>>>> Am 13.02.2012 11:17, schrieb Roberto Sassu:
>>>>> Hi Harald
>>>>> 
>>>>> this functionality seems to be broken in dracut due to a
>>>>> change in the SELinux load_policy tool. After enabling the
>>>>> selinux module in dracut, i obtain:
>>>>> 
>>>>> [    3.369059] dracut: Loading SELinux policy [
>>>>> 3.449850] dracut: /sbin/load_policy: Can't load policy: No
>>>>> such file or directory [    3.659899] dracut: Switching
>>>>> root
>>>>> 
>>>> 
>>>> This error can have multiple causes... Dan?
> 
> Well likeliest would be selinux-policy package is not installed.
> 
> -- selinux mailing list selinux-TuqUDEhatI4ANWPb/1PvSmm0pvjS0E/A@public.gmane.org 
> https://admin.fedoraproject.org/mailman/listinfo/selinux

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk86rZ4ACgkQrlYvE4MpobPKXwCfbVdkQuaylTtHIASztazyokqN
u4wAnR9bueXLrFH4vvDxSPYSNqBDYP19
=W0oJ
-----END PGP SIGNATURE-----
