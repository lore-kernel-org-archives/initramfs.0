From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: relative order of /etc/dracut.conf and /etc/dracut.conf.d
Date: Wed, 17 Mar 2010 11:58:04 +0100
Message-ID: <4BA0B5BC.2000404@redhat.com>
References: <201003060754.08574.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201003060754.08574.arvidjaar-JGs/UdohzUI@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 03/06/2010 05:54 AM, Andrey Borzenkov wrote:
> Currently dracut.conf is sourced after dracut.conf.d. Is it intentional?
>
> I'd actually expect the opposite - dracut.conf used for distribution defaults,
> dracut.conf.d for local system adjustments with command line options overruling
> them all.
>

err.. I would see dracut.conf.d as a place for packages to drop their files in, 
so I would like to have dracut.conf as the last instance to override any 
settings imposed by other packages.
