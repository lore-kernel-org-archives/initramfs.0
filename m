From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH,RFC] virtfs root filesystem support
Date: Thu, 19 Apr 2012 12:15:01 +0200
Message-ID: <4F8FE5A5.7000300@redhat.com>
References: <20120415004017.GI28523@wantstofly.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120415004017.GI28523-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 15.04.2012 02:40, schrieb Lennert Buytenhek:
> Qemu/KVM provides virtfs, a paravirtualised filesystem that is
> implemented by running the Plan 9 folder sharing protocol over
> virtio.
> 
> Make booting with root=virtfs:foobar use the virtfs filesystem
> with mount tag 'foobar' as root filesystem, to allow booting
> virtual machines off virtfs.
> 
> Note that this only handles 9p over virtio (i.e. virtfs), and
> doesn't attempt to handle mounting 9p filesystems over TCP/IP,
> for example.
> 
> Signed-off-by: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> 

pushed... and yes we should factor out the mount somehow
