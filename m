From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/8] build initramfs: speedup
Date: Wed, 31 Aug 2011 15:09:30 +0200
Message-ID: <4E5E328A.5030604@redhat.com>
References: <4E5DBAE4.2000205@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E5DBAE4.2000205-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 31.08.2011 06:39, John Reiser wrote:
> This patch series saves 50% (a factor of 2) in real time before final gzip
> when building initramfs for Fedora 16.
>
> Probably you should apply only the first six patches (1,2,3,4,5,6)
> because directory symlinks and permissions aren't right after patch 7.
> [I don't care about directory symlinks now; permissions are 775 instead of 755.]
> I'm working on a different approach for those; it's not ready.
> However, the first six patches save 25% (a factor of 4/3),
> and patch 7 saves another 25% by replacing most /bin/cp with cpio.
>

Thanks for your work, but your patches are kind of broken.

Either your mail program scrambled them, or you have a weird git or patch 
implementation.

e.g. first diff hunk in patch 4 says
@@ -863,49 +863,63 @@ filter_kernel_modules_by_path () (

but in fact it should be s.th. like
@@ -863,45 +863,59 @@ filter_kernel_modules_by_path () (

All blank lines are missing in the hunks!

Care to resend?
