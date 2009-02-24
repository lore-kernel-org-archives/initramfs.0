From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Tue, 24 Feb 2009 16:22:09 +0100
Message-ID: <49A410A1.7000505@bfh.ch>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>  <49A301FF.2090303@redhat.com> <1235434056.28090.28.camel@sentry-no.fnordovax.org> <49A3AB75.1010805@bfh.ch> <Pine.LNX.4.64.0902241430270.22015@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0902241430270.22015-qcrbbFV08EMdmw7VdWMmteH3J2bgQ+4lG9Ur7JDdleE@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bogdan Costescu <Bogdan.Costescu-hEciA7+sKtudPOQpRHQ53DeJuz7u0hKX@public.gmane.org>
Cc: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Bogdan Costescu wrote:
> On Tue, 24 Feb 2009, Seewer Philippe wrote:
> 
>> Though I see a small problem: Ever thought about what happens if there 
>> are multiple interfaces on different networks? Only one is valid to 
>> mount the root-fs...
> 
> The Debian initramfs-tools documents as following here the rule from the 
> kernel's nfsroot.txt which allows an ip=... kernel command line 
> parameter which can contain the name of the device. Is this an option 
> that would fit your purpose ?

In my case: no. I need a general purpose netboot init where I don't know which or how many interfaces there are.


>  From what I know, there is no automated way to get that information 
> automatically in the format described, so you'd have to maintain it, 
> possibly in a PXE config file; it's possible to find out what interface 
> was used for PXE booting when using PXELINUX with the 'IPAPPEND 2' 
> option which will add a BOOTIF=mac_address to the kernel command line.

That is correct. Sadly this only works in a PXE environment.


> This might however not be enough: there could be a case where the 
> booting (via PXE) is done on a different network (and interface) than 
> the one where the root NFS is exported. I know that this sounds 
> complicated, but it has been implemented in real life ;-)

Aye. Or similar: Consider a system with an interface into the standardnetwork and one into a lab net. Both yield correct dhcp results but only one is correct for a specific root-server.

To solve this, I'm currently just doing the network stuff sequentially, aborting when I've found the correct interface. The script looks more or less like this (yes, I know its ugly):

...
NETDEVICE=""
for i in $(sed -nr 's/^ *(\w+[0-9]+):.*$/\1/p' /proc/net/dev) ; do
	NETDEVICE=""
	for j in 1 2 3 4; do
	        if (udhcpc --interface=$i -n >/dev/null 2>&1) ; then
			NETDEVICE=$i
			break;
		fi
	        sleep $j
        done

	if [ "$NETDEVICE" = "" ] ; then
                continue
        fi

	NETDEVICE=""
	if (ping -c 2 $NFSSERVER >/dev/null 2>&1) ; then
		NETDEVICE=$i
	fi

	if [ "$NETDEVICE" = "" ] ; then
		ifconfig $i down
		continue
	fi

	NETDEVICE=""
	if (mount -r $NFSOPTS $NFSSERVER:$NFSPATH /newroot >/dev/null 2>&1) ; then
		NETDEVICE=$i
	fi

	if [ "$NETDEVICE" = "" ] ; then
		ifconfig $i down
		continue
	fi
done
if [ "$NETDEVICE" = "" ] ; then
	echo "Error: " #lots of text here
	sh -i
fi
...

Hmm... looking at this, we can do this with Dracut really simple: 

1. Don't start dhclient inside udev. Might even be a good idea, since IMHO udev is "only" there to load modules and set up devicefiles, not necessarily configure the devices. 
2. Use a pre-mount script to up interfaces. dracut could provide a simple script for simple cases which can be overridden with site specific craziness. 
3. A simple mount.nfs would be enough in /mount/

What do you think?

Regards,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
