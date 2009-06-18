From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: Redundant nfsroot cmdline options
Date: Thu, 18 Jun 2009 09:23:21 +0200
Message-ID: <4A39EB69.6030007@bfh.ch>
References: <4A36A510.5010709@redhat.com> <20090617034849.GA22705@thedillows.org> <4A386B20.9010205@redhat.com> <4A3898E0.8090700@bfh.ch> <4A394352.1010007@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A394352.1010007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Warren Togami wrote:
>> #!/bin/sh
>> #
>> # Preferred format:
>> #       root=nfs[4]:[server:]path[:options]
>> #       [root=*] netroot=nfs[4]:[server:]path[:options]
> 
> Harald and I agree that there is no reason for this second variation to 
> exist in the case of NFS.  It seems the separate root= and netroot= only 
> makes sense for remote block device protocols like iscsi or nbd.
> 
>> #
>> # Legacy formats:
>> #
>> #       root=/dev/nfs nfsroot=[server:]path[,options]
>> #
>> #       XXX: All of the following have no reason to exist.
>> #       [net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[,options]
>> #       [net]root=[[/dev/]nfs[4]] nfsroot=[server:]path[:options]
>> #
> 
> I'm removing the three variations of the Legacy nfsroot.txt as discussed.

Fine by me.

[snip]
>> #
>> # If server is unspecified it will be pulled from one of the following
>> # sources, in order:
>> #       static ip= option on kernel command line
> 
> Huh?  How would you do that?

If $srv is in net.used-if.override it is used
>> #       DHCP next-server option
>> #       DHCP server-id option
>> #       DHCP root-path option
> 
> Do we really want this order?  It seems we want this order:
> 
> * root=
root= is superfluous. as it already takes precedence and these rules 
only apply if if server is unspeficied.

> * DHCP root-path
> * Everything else

I'm not sure about that. nfsroot.txt is a bit unclear here:

[quote]
<server-ip>   IP address of the NFS server. If RARP is used to determine
               the client address and this parameter is NOT empty only
               replies from the specified server are accepted.

               Only required for for NFS root. That is autoconfiguration
               will not be triggered if it is missing and NFS root is not
               in operation.

               Default: Determined using autoconfiguration.
               The address of the autoconfiguration server is used.
[/quote]

"address of the autoconfiguration server" translates for me as try 
next-server or server-id and if that fails use root-path.

>> #
>> # NFSv4 is only used if explicitly requested; default is NFSv2 or NFSv3
>> # depending on kernel configuration
>> #
>> # root= takes precedence over netroot= if root=nfs[...]
>> #
>>
> 
> This precedence order shouldn't be necessary as netroot= shouldn't be 
> necessary for NFS.

Yes that is true. I'd like to keep it there as it keeps the nfs cmdline 
arguments consistent with nbd and iscsi.

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
