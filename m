From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dracut network
Date: Mon, 18 May 2009 16:10:55 +0200
Message-ID: <4A116C6F.1020509@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

fixed the dracut network module in
git://dracut.git.sourceforge.net/gitroot/dracut

if you boot with "ip=dhcp", /net.<iface>.dhcpopts will contain 
new_root_path=<dhcp root path option> in the initrd root.

Next steps:
- add NFS root mount to the dracut initrd
- add NFS to the server with the test/root.ext2 loop mounted and exported
- add a proper testsuite structure

Tested with:

$ sudo ./test/make-server-root

which creates test/server.ext2 with a dnsmasq dhcp/dns server

To start the server:

$ sudo qemu-kvm -hda test/server.ext2 -m 256M \
      -net nic,macaddr=52:54:00:12:34:56 \
      -net socket,mcast=230.0.0.1:1234 \
      -kernel /boot/vmlinuz-$(uname -r) \
      -initrd test/initramfs.testing  \
      -append "root=/dev/sda rw"

Create the client image:

$ sudo ./dracut -c test/dracut.conf.test -l -f test/initramfs.testing

Then start the client

$ sudo qemu-kvm  -m 256M -nographic \
    -net nic,macaddr=52:54:00:12:34:57 \
    -net socket,mcast=230.0.0.1:1234  \
    -kernel /boot/vmlinuz-$(uname -r) \
    -initrd test/initramfs.testing \
    -append "ip=dhcp rw console=ttyS0,115200n81"

eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Bug in initramfs /init detected. Dropping to a shell. Good luck!
sh: cannot set terminal process group (-1): Inappropriate ioctl for device
sh: no job control in this shell
sh-4.0# cat /net.eth0.dhcpopts
new_broadcast_address='192.168.1.255'
new_dhcp_lease_time='604800'
new_dhcp_message_type='5'
new_dhcp_rebinding_time='529200'
new_dhcp_renewal_time='302400'
new_dhcp_server_identifier='192.168.1.1'
new_domain_name='test.net'
new_domain_name_servers='192.168.1.1'
new_expiry='1243260313'
new_ip_address='192.168.1.100'
new_network_number='192.168.1.0'
new_root_path='192.168.1.1:/mnt/root'
new_routers='192.168.1.1'
new_subnet_mask='255.255.255.0'


To exit qemu, press <ctrl-a> <c> <return>

sh-4.0#
(qemu) quit

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
