From: Dominic Gross <domgross-Mmb7MZpHnFY@public.gmane.org>
Subject: random iscsi_initiatorname
Date: Mon, 11 Nov 2013 19:18:14 +0100
Message-ID: <52811F66.7040009@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

I am currently building a test setup with pxe diskless clients which use
an iscsi root device and came across a problem with the
iscsi-iinitiatorname used by dracut. Specifially, if iscsi-initiator is
not set manually the iscsiroot script calls iscsi-iname to get a valid
iscsi name (cf. rfc3720,rfc3721):

    if [ -z $iscsi_initiator ]; then
    # XXX is this correct?
        iscsi_initiator=$(iscsi-iname)


While iscsi-iname provides a valid iscsi name the result is random and
consequently the iscsi name changes with each reboot, e.g. calling
iscsi-iname results in:

iqn.1994-05.com.redhat:e25068854d3a (fedora)
iqn.2005-03.org.open-iscsi:ff1a0774235 (debian)

where the last part is random. However, some iscsi targets such as LIO
Linux SCSI Target require that the name of the iscsi initiator is in the
ACL of the target, otherwise the initiator will be unable to connect:

https://groups.google.com/forum/#!topic/linux-iscsi-target-users/5G5WJ8TwUB8

So imho a more predictable approach to generate the initiatorname is
required, otherwise I am not sure how to use dracut with LIO iscsi.

Furthermore, even without the issue of ACLs it seems sub optimal to use
iscsi names which change with every reboot. One workaround would be to
set the iscsi name manually but in some use cases (e.g. diskless clients
with shared read only rootfs) setting the initiator name manually would
either result all clients having the same initiator name or in a lot of
maintenance overhead. So imho the preferred solution would be something
along the lines suggested in the iscsi module:

# XXX rfc3720 says 'SCSI Initiator Name: The iSCSI Initiator Name
specifies
# the worldwide unique name of the initiator.' Could we use hostname/ip
# if missing?

There are a couple of ways this may be implemented. Dracut could
continue call iscsi-iname and replace the random part by something more
predictable (e.g. fully qualified hostname, mac address). Or simply
define the initiatorname completely independent of iscsi-iname, maybe
via fqdn and mac address?

I am currently using the following approach in iscsiroot.sh:

iscsi_initiator=$(iscsi-iname)
IFS=":"
set -- $iscsi_initiator
iscsi_initiator="$1:$(hostname -f)"
unset IFS

This works well, but of course only results in a globally unique iscsi
name if a globally unique hostname is set via dhcp.

Using the MAC Adress is a viable option but ties the ACL to a specific
NIC and may have some pitfalls if there is more than one NIC.

