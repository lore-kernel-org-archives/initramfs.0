From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dracut GIT] branch, master, updated. 5dc6f240856a37d864298e67233a8312c882a927
Date: Wed, 10 Nov 2010 23:44:43 +0100
Message-ID: <4CDB205B.2080009@redhat.com>
References: <E1PGIZ6-00043s-D7@sfp-scmshell-1.v30.ch3.sourceforge.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1PGIZ6-00043s-D7-k4i/gY8Meg/5oxsc1G8FJ7gy3r6b7hxHn8KVU9S6xrQkmLvzuZlaBw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Just wanted to give a heads up.
With this commit the test suite finally passes again:

$ time sudo make check
make -C test check
make[1]: Entering directory `/net/nas/home-harald/git/dracut/test'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-10-RAID'
TEST: root filesystem on an encrypted LVM PV on a RAID-5 [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-10-RAID'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-11-LVM'
TEST: root filesystem on LVM PV [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-11-LVM'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-12-RAID-DEG'
TEST: root filesystem on an encrypted LVM PV on a degraded RAID-5 [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-12-RAID-DEG'
make[2]: Entering directory 
`/net/nas/home-harald/git/dracut/test/TEST-13-ENC-RAID-LVM'
TEST: root filesystem on LVM on encrypted partitions of a RAID-5 [OK]
make[2]: Leaving directory 
`/net/nas/home-harald/git/dracut/test/TEST-13-ENC-RAID-LVM'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-14-IMSM'
TEST: root filesystem on LVM PV on a isw dmraid [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-14-IMSM'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-20-NFS'
TEST: root filesystem on NFS [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-20-NFS'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-30-ISCSI'
TEST: root filesystem over iSCSI [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-30-ISCSI'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-40-NBD'
TEST: root filesystem on NBD [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-40-NBD'
make[2]: Entering directory `/net/nas/home-harald/git/dracut/test/TEST-50-MULTINIC'
TEST: root filesystem on NFS with multiple nics [OK]
make[2]: Leaving directory `/net/nas/home-harald/git/dracut/test/TEST-50-MULTINIC'
make[1]: Leaving directory `/net/nas/home-harald/git/dracut/test'

real	38m27.274s
user	8m32.362s
sys	13m27.486s
