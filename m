From: Pierre Jean Schweitzer <pierre.jean.schweitzer-vJEk5272eHo@public.gmane.org>
Subject: NFS root on FUSE
Date: Thu, 1 Sep 2011 13:56:59 +0000
Message-ID: <2C830DE44569424E90F3600349931247117A99F9@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2C830DE44569424E90F3600349931247117A99F9PLOXCHG03cernch_"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-GB
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--_002_2C830DE44569424E90F3600349931247117A99F9PLOXCHG03cernch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

attached to this message, you will find a patch that addresses an issue tha=
t raise under the following conditions:
- You have a diskless system that boots from the network (using something l=
ike root=3Dnfs:... in its command line)
- The exported file system on which the system will boot is actually a FUSE=
 file system (then you had to put a fsid in /etc/exports/

Then, you will experience /proc and /sys being empty (not really umounted),=
 followed closely by /dev. The system then becomes unusable.
I searched and tried several things to prevent this issue to happen. Only o=
ne worked (all credits go to that guy: http://swik.net/zfs-fuse/linux+root+=
filesystem+on+zfs-fuse).
I modified the system-config-netboot initscript to get it on diskless clien=
ts and it indeed work. Since those tools are deprecated coming with RHEL6, =
I've ported this solution to dracut.

I don't really know where from this issue comes. I even don't know if that'=
s a proper fix, or just a hackfix. This is open to discussion.
Moreover, I've not been able to test yet that fix on non-diskless system (i=
f there are un-measured side effects).

With my best regards,
P. Schweitzer=

--_002_2C830DE44569424E90F3600349931247117A99F9PLOXCHG03cernch_
Content-Type: text/x-patch; name="fuse.diff"
Content-Description: fuse.diff
Content-Disposition: attachment; filename="fuse.diff"; size=604;
	creation-date="Thu, 01 Sep 2011 13:56:19 GMT";
	modification-date="Thu, 01 Sep 2011 13:56:19 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL21vZHVsZXMuZC85OWJhc2UvaW5pdCBiL21vZHVsZXMuZC85OWJhc2UvaW5p
dAppbmRleCBiNjY2ZDNlLi40Y2RkMmMyIDEwMDc1NQotLS0gYS9tb2R1bGVzLmQvOTliYXNlL2lu
aXQKKysrIGIvbW9kdWxlcy5kLzk5YmFzZS9pbml0CkBAIC00NTIsNiArNDUyLDE2IEBAIFNXSVRD
SF9ST09UPSQoY29tbWFuZCAtdiBzd2l0Y2hfcm9vdCkKIFBBVEg9JE9MRFBBVEgKIGV4cG9ydCBQ
QVRICiAKKyMgTWFrZSBzcGVjaWFsIG1vdW50IHBvaW50cyBwZXJzaXN0YW50IG92ZXIgc3dpdGNo
IHJvb3QKK21vdW50IC0tbWFrZS1yc2hhcmVkIC9kZXYKK21vdW50IC0tYmluZCAvZGV2ICIkTkVX
Uk9PVC9kZXYiCisKK21vdW50IC0tbWFrZS1yc2hhcmVkIC9zeXMKK21vdW50IC0tYmluZCAvc3lz
ICIkTkVXUk9PVC9zeXMiCisKK21vdW50IC0tbWFrZS1yc2hhcmVkIC9wcm9jCittb3VudCAtLWJp
bmQgL3Byb2MgIiRORVdST09UL3Byb2MiCisKIGlmIFsgLWYgL2V0Yy9jYXBzZHJvcCBdOyB0aGVu
CiAgICAgLiAvZXRjL2NhcHNkcm9wCiAgICAgaW5mbyAiQ2FsbGluZyAkSU5JVCB3aXRoIGNhcGFi
aWxpdGllcyAkQ0FQU19JTklUX0RST1AgZHJvcHBlZC4iCg==

--_002_2C830DE44569424E90F3600349931247117A99F9PLOXCHG03cernch_--
