From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: root=dhcp broke
Date: Wed, 17 Jun 2009 13:15:37 -0400
Message-ID: <4A3924B9.2090303@redhat.com>
References: <4A391744.4040607@redhat.com> <4A3923F7.6000900@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A3923F7.6000900-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 06/17/2009 01:12 PM, Seewer Philippe wrote:
> Warren Togami wrote:
>> After that latest patch set, simply "root=dhcp" no longer boots.
>>
>> "root=dhcp ip=dhcp" fails as well.
>
> What's the contents of your dhcp root path? root=dhcp tests in the suite
> all pass.

Harald saw the problem.  The precedent for DHCP root= or root-path= 
syntax for NFSv3 is as documented here:

http://sourceforge.net/apps/trac/dracut/wiki/commandline

Begins with IP address, not "nfs:".  "nfs4:" prefix is true of NFSv4, 
but "nfs:" would be a new invention.  Harald is now fixing this.

Warren
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
