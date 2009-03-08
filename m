From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC] Dracut and complicated netboot cases
Date: Sun, 8 Mar 2009 14:35:18 +0100
Message-ID: <49B3C996.10302@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hello list

With the frantic activity during the last few weeks Dracut is in a very=
=20
usable state. Sure, there's still a way to go, but we have an=20
infrastructure able to boot different configurations very well. Adding =
a=20
simple module to handle netboots isn't great magic anymore. What I'm=20
worrying about is some difficult cases, hence this plea for RFC.


Short introduction to netbooting: Network based boots aren't that=20
different from host based boots. Instead of a local root file system,=20
the root is delivered from a network server. The big difference is that=
=20
not only network interfaces need to be discovered and their drivers=20
loaded, these interfaces need to be configured as well. Usually with=20
dhcp or an ip option passed to the kernel. While this may be easy most=20
of the time, in some cases there's added logic needed to discover which=
=20
network interface is to be used. You could compare this to the state=20
booting was before we had label- or uuid-based mounting: Without=20
actually knowing which specific device to boot from, initrd's had to do=
=20
some real magic trying to discover the correct device.


Of course, there's no netboot module yet, but as mentioned that's simpl=
e=20
to do. But with the current state and a netboot module, the following=20
cases should work:

- Systems with only one network interface, configured statically (ip=20
boot option) or a successful dhcp
- Systems with multiple interfaces, but only one is connected, dhcp=20
succeeds and the network server is reachable via that configuration.
- Systems with multiple connected interfaces, dhcp succeeds, only one=20
default route is offered and the server is reachable via that configura=
tion.
- Handling of Systems with no network interfaces or missing drivers if=20
netboot is required. This just makes boot fail.


What will work with a bit of added logic:
- Systems with multiple interfaces and a passed boot option specifying=20
which interface to use (interface=3D... or mac=3D...). Would work with =
both=20
static and dynamic configuration
- Only configure network devices if necessary: If we're not booting fro=
m=20
a network server, network interfaces should not be configured.


What I'm worried about are the following cases:
- No static configuration and dhcp fails: This can usually mean there i=
s=20
no network. But with some network configurations, the initial setup-tim=
e=20
can take a while. Dracut currently has no means to restart the=20
configuration process.
- System with multiple interface, static configuration and no mac=3D...=
=20
option: The static configuration (ip=3D...) usually contains only the=20
configuration required to see the network server. But if we have severa=
l=20
interfaces we just don't know which interface this data has to be=20
applied to.
- System with multiple interfaces and dynamic configuration (dhcp): If=20
the network server is directly reachable without needing a default rout=
e=20
that is not a problem. But if we have more complicated network setups=20
(which is usually the case), the system needs a default route. But what=
=20
if the dhcp answer for interface A and interface B wants to set=20
different default routes? Problem one is that we can have only one=20
default route, Problem two is we don't know through wich route the=20
network server can be reached.


To solve these cases, I've had the following (pseudo-code) in our=20
production environment for the last 5 years:

while (not OK) do
	for all known interfaces
		configure interface or FAIL
		ping server or FAIL
		mount root-filesystem or FAIL
		if not FAIL: set ok and break
		if FAIL: deconfigure interface
	endfor
	if not OK:
		print =93please check cabling and hit enter to retry=94
		wait for user
	endif
endwhile

(The ping part is an optimization since mounting can have a very long=20
timeout)


Now what I'm asking is: 1) Does Dracut need to be able to handle these=20
complicated cases? And if so 2) Is my solution really the 'Right Thing'=
=20
to do or is there be a better solution?

Thanks,
Philippe
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
