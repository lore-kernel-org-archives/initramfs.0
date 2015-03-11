From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: dracut, degraded md arrays, resume and systemd.
Date: Wed, 11 Mar 2015 11:28:45 +1100
Message-ID: <20150311112845.01dd3269@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Ctgq._m82M_cfq3zJLuacrY"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_/Ctgq._m82M_cfq3zJLuacrY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


hi,
 I have a problem....  I'm not entirely sure where to fix it.

 I have a system with 2 drives, each partitioned into 3 partitions and those
 partitions combined in md/raid RAID1 arrays.
 The arrays are used for /boot, swap and an LVM PV - which has the root
 filesystem in a VG.  Normally this all works wonderfully.

 If I shutdown, remove one drive, and boot - it doesn't.

 When mdadm sees a newly-degraded array like this (i.e. the one drive it
 finds doesn't have recorded that the other device is missing), it won't
 assemble the array until it is explicitly told that all devices have been
 found.

 dracut has code to do exactly this: /sbin/mdraid_start is placed on the
 'timeout' queue to be run after a suitable timeout.  And this script does
 the right thing.  The md arrays are all assembled, the LVM PV is found so
 the VG and LV is assembled, and the root filesystem is mounted..

 HOWEVER, before all that happens, systemd stops waiting and gives up -
 moments too soon.

 There are (at least) two other scripts on the 'timeout' queue which run
 immediately after mdraid_start.
 One is lvmscan, which probably does the right thing, isn't exactly necessa=
ry
 in my context I think, and certainly isn't a problem.

 But there is also the 'resume.sh' script:

        {
            printf -- "%s" 'warn "Cancelling resume operation. Device not f=
ound.";'
            printf -- ' cancel_wait_for_dev /dev/resume; rm -f -- "$job" "%=
s/initqueue/settled/resume.sh";\n
        } >> $hookdir/initqueue/timeout/resume.sh

 This calls cancel_wait_for_dev, which supposedly cancels the wait for the
 swap array.  Unfortunately it also cancels the wait for the root filesyste=
m.
 I'm not completely sure why, but it certainly relates to the
     systemctl daemon-reload
 command that cancel_wait_for_dev schedules.  If I comment that out, it all
 works. (also if I boot with noresume, it all works).

 But I don't think that is all of the problem.
 If I had swap on an LVM volume, then I suspect it wouldn't quite be found =
by
 the time that the resume.sh script gets run, and so the resume attempt wou=
ld
 incorrectly abort.

 My feeling is that if any script in the 'timeout' queue makes any progress,
 then the remaining scripts should be delayed for another timeout.

 There is code that does something a little bit like this:

    if [ $main_loop -gt $((2*$RDRETRY/3)) ]; then
        for job in $hookdir/initqueue/timeout/*.sh; do
            [ -e "$job" ] || break
            job=3D$job . $job
            udevadm settle --timeout=3D0 >/dev/null 2>&1 || main_loop=3D0
            [ -f $hookdir/initqueue/work ] && main_loop=3D0
        done
    fi

so if 'udevadm settle --timeout=3D0' fails, or if initqueue/work has been
created, the main_loop is set to 0, which seems to imply "try again".
However the subsequent jobs in the queue are not aborted.

Also, in my case, neither of these conditions trigger.  mdraid_start doesn't
create the 'initqueue/work' file, and 'udevadm settle' has never (as far as=
 I
can tell) actually honoured "--timeout=3D0" the way it is documented.
It waits indefinitely for the queue to be empty, then succeeds.

So my proposed solution (which is really just a suggestion and I suspect
something else will be better), is to:
1/ modify the above loop to break out if main_loop is ever reset to zero, a=
nd
2/ modify mdraid_start to create initqueue/work if it finds anything to do.

The following patch makes that explicit.  It seems to fix my problem.

Is this a good way to fix it?  Is there something better?

BTW, I also have a problem in a similar config where the md/raid RAID1 is
encrypted.  Systemd gives up waiting for the encrypted device after 90
seconds:
[   92.250437] linux systemd[1]: Dependency failed for Cryptography Setup f=
or cr_md1.

but mdraid_start doesn't get run until 120 seconds have elapsed.
I haven't looked into setup of encrypted devices yet, but if anyone has
suggestions, I'm very interested :-)

Thanks,
NeilBrown



diff --git a/modules.d/90mdraid/mdraid_start.sh b/modules.d/90mdraid/mdraid=
_start.sh
index 761e64f312d3..400ab5dc46c7 100755
--- a/modules.d/90mdraid/mdraid_start.sh
+++ b/modules.d/90mdraid/mdraid_start.sh
@@ -27,6 +27,7 @@ _md_force_run() {
=20
         _path_d=3D"${_path_s%/*}/degraded"
         [ ! -r "$_path_d" ] && continue
+        > $hookdir/initqueue/work
     done
 }
=20
diff --git a/modules.d/98systemd/dracut-initqueue.sh b/modules.d/98systemd/=
dracut-initqueue.sh
index 88cd1e056ed7..af9cec2c5b8c 100755
--- a/modules.d/98systemd/dracut-initqueue.sh
+++ b/modules.d/98systemd/dracut-initqueue.sh
@@ -60,6 +60,7 @@ while :; do
             job=3D$job . $job
             udevadm settle --timeout=3D0 >/dev/null 2>&1 || main_loop=3D0
             [ -f $hookdir/initqueue/work ] && main_loop=3D0
+            [ $main_loop -eq 0 ] && break
         done
     fi
=20

--Sig_/Ctgq._m82M_cfq3zJLuacrY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVP+MPTnsnt1WYoG5AQKYeBAAwt8FsihIDa1d1AMzDfXjI2Ck35pQyz3p
QNKcFVPzq0pE5soOBBHvPhmcmsV+H9+vmeDM8YxppZ2FGllTt2bb4yT6Hyg1jlhl
6e7OcJXv3WicRothpwwxJ+zimPI447x+puPAU8GLy4EhKk8DhV3FddpPAnNALEbZ
EYx4O+ujMOldAbShf0jZp5EFY5US5Yk2nBDvGS+86xf68+inY/DXYm80f182z+PD
5+oPA+hyB/mW76y1O7i/XCGBIbaSE+e/f991CRBy8Zgzg+LQES4QUuozcFxk3gRp
UmyKphhh36Q70+ECTtd6RcPcXscb65EVRnVEpu20aeYt/erqDs/Xauv90mR3hIs5
Y+mcJW5g2I7JPvy9zZ77rLgmQCxxCl/rBbzgBJ/c2jLDg6wpGNIVzguTZVFU8dSk
0jyraodAS/28BWDAcODxUu2z8vDr9GQXm5oUH+ZunyADXbn517oPRswgg4jTnqRw
yPzZI7lbmvlYkRHOUdh7pXgPnCPkScaz+ccomgJyk8EHNDAcrEsfBg9VIN8RiF8F
AZzvwbG9We+9KuCW6uXA+aIEA7njDspCyNMhAIAFYwLPe+EXPAM3k+NaxZGmQ/BV
P5b5+LafX/pjTMuDkhKUYTlBtG8XfvhBXuoHiQE20LV3iUHG+qlxwXvSq7fzkr8m
fwBgqLgFRsQ=
=2Eau
-----END PGP SIGNATURE-----

--Sig_/Ctgq._m82M_cfq3zJLuacrY--
