From: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA  custom policies
Date: Mon, 20 Feb 2012 20:07:21 +0100
Message-ID: <20120220190720.GC360@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
 <4F3BDCAA.7040001@polito.it>
 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it>
 <20120220171446.GD26356@tango.0pointer.de>
 <4F4292A4.2030402@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F4292A4.2030402-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: Gustavo Sverzut Barbieri <barbieri-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org

On Mon, 20.02.12 19:36, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:

> 
> On 02/20/2012 06:14 PM, Lennart Poettering wrote:
> >On Wed, 15.02.12 18:12, Roberto Sassu (roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org) wrote:
> >
> >>The location of the policy file is not IMA dependent. I chose that
> >>because it seemed to me the right place where to put this file.
> >>So, i can easily modify the location to be distribution independent
> >>but i don't known which directory would be appropriate.
> >>Any proposal?
> >
> >/etc/ima.conf or /etc/ima/ima.conf sound like obvious candidates.
> >
> 
> I prefer the first one, because the second pathname raises the problem
> of creating a new subdirectory. However, i think we should keep the
> word 'policy' in the file name to avoid users believe that is a
> configuration file.

Creating a subdir is a problem? How so?

You should use a subdir /etc/ima/ if there's the chance that sooner or
later you might have to add another config file of some sorts to IMA. If
you are really sure that never happens, then you don't need the dir, but
if you are in doubt, better use one. (But this is the policy file,
right? so i figure you might end up with adding a conf file with options
like selinux' enforcing/permissive later on, so i think you should
better add a dir)

(Oh, and in contrast to what i suggested, if this is the policy file,
and not a configuration file, the .conf suffix of course makes little sense)

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
