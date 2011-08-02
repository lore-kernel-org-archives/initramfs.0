From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] livenet: module for fetching live images from the
 network
Date: Tue, 02 Aug 2011 11:33:55 -0400
Message-ID: <1312299236.10823.34.camel@samus.localdomain>
References: <1312230160-11295-1-git-send-email-wwoods@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312230160-11295-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2011-08-01 at 16:22 -0400, Will Woods wrote:
> The livenet module allows you to use a root arg like:
> 
>     root=http://server.name/path/to/live.img ip=dhcp

Whoops, that should be:
  root=live:http://server.name/path/to/live.img ip=dhcp

We *could* make livenet the default behavior for "root=[URL]", but I'm
not sure if there are other things that might want to use that scheme..
so let's keep the "live:..." convention for now.

-w
