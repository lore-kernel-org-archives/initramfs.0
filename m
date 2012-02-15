From: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Wed, 15 Feb 2012 12:30:27 -0200
Message-ID: <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
	<1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329312229-11856-2-git-send-email-roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mzerqung-uLTowLwuiw4b1SvskN2V4Q@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Wed, Feb 15, 2012 at 11:23 AM, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org> wrote:
> The new function ima_setup() loads an IMA custom policy from a file in the
> default location '/etc/sysconfig/ima-policy', if present, and writes it to

isn't /etc/sysconfig too specific to Fedora?

Also, I certainly have no such things in my system and see no point in
calling ima_setup() on it. Or even compiling the source file in such
case.

-- 
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
