From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: 'make rpm' fails
Date: Fri, 29 Jul 2011 08:19:54 +0000 (UTC)
Message-ID: <j0tqfa$2kj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

[root@nec-em18 dracut]# make rpm
mkdir -p rpmbuild
cp dracut-011.tar.bz2 rpmbuild
cd rpmbuild; ../git2spec.pl 011 < ../dracut.spec > dracut.spec; \
rpmbuild --define "_topdir $PWD" --define "_sourcedir $PWD" \
        --define "_specdir $PWD" --define "_srcrpmdir $PWD" \
	--define "_rpmdir $PWD" -ba dracut.spec || :; \
cd ..;
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.ERlVK0
+ umask 022
+ cd /root/dracut/rpmbuild/BUILD
+ LANG=C
+ export LANG
+ unset DISPLAY
+ cd /root/dracut/rpmbuild/BUILD
+ rm -rf dracut-011
+ /usr/bin/bzip2 -dc /root/dracut/rpmbuild/dracut-011.tar.bz2
+ /bin/tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd dracut-011
+ /bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ echo 'Patch #1 (0001-dracut.spec-remove-noreplace-for-01-
dist.conf.patch):'
Patch #1 (0001-dracut.spec-remove-noreplace-for-01-dist.conf.patch):
+ /bin/cat /root/dracut/rpmbuild/0001-dracut.spec-remove-noreplace-for-01-
dist.conf.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #2 (0002-add-TEST-15-BTRFSRAID.patch):'
Patch #2 (0002-add-TEST-15-BTRFSRAID.patch):
+ /bin/cat /root/dracut/rpmbuild/0002-add-TEST-15-BTRFSRAID.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #3 (0003-dracut.logrotate-remove-yearly.patch):'
Patch #3 (0003-dracut.logrotate-remove-yearly.patch):
+ /bin/cat /root/dracut/rpmbuild/0003-dracut.logrotate-remove-yearly.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #4 (0004-dracut-logger-create-logfile-with-0600-
permissions.patch):'
Patch #4 (0004-dracut-logger-create-logfile-with-0600-permissions.patch):
+ /bin/cat /root/dracut/rpmbuild/0004-dracut-logger-create-logfile-
with-0600-permissions.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #5 (0005-90dmsquash-live-optionally-install-eject.patch):'
Patch #5 (0005-90dmsquash-live-optionally-install-eject.patch):
+ /bin/cat /root/dracut/rpmbuild/0005-90dmsquash-live-optionally-install-
eject.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #6 (0006-enable-shutdown-module-by-default.patch):'
Patch #6 (0006-enable-shutdown-module-by-default.patch):
+ /bin/cat /root/dracut/rpmbuild/0006-enable-shutdown-module-by-
default.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #7 (0007-90dm-dm-shutdown.sh-put-shutdown-in-
function.patch):'
Patch #7 (0007-90dm-dm-shutdown.sh-put-shutdown-in-function.patch):
+ /bin/cat /root/dracut/rpmbuild/0007-90dm-dm-shutdown.sh-put-shutdown-in-
function.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #8 (0008-90mdraid-md-shutdown.sh-put-shutdown-in-
function.patch):'
Patch #8 (0008-90mdraid-md-shutdown.sh-put-shutdown-in-function.patch):
+ /bin/cat /root/dracut/rpmbuild/0008-90mdraid-md-shutdown.sh-put-
shutdown-in-function.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #9 (0009-TEST-10-RAID-extend-test-case-to-shutdown.patch):'
Patch #9 (0009-TEST-10-RAID-extend-test-case-to-shutdown.patch):
+ /bin/cat /root/dracut/rpmbuild/0009-TEST-10-RAID-extend-test-case-to-
shutdown.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #10 (0010-TEST-10-RAID-test-init-turn-off-debug-for-
shutdown.patch):'
Patch #10 (0010-TEST-10-RAID-test-init-turn-off-debug-for-shutdown.patch):
+ /bin/cat /root/dracut/rpmbuild/0010-TEST-10-RAID-test-init-turn-off-
debug-for-shutdown.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #11 (0011-shutdown-fixed-check_shutdown-loop.patch):'
Patch #11 (0011-shutdown-fixed-check_shutdown-loop.patch):
+ /bin/cat /root/dracut/rpmbuild/0011-shutdown-fixed-check_shutdown-
loop.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #12 (0012-dracut-lib.sh-fixed-getargs.patch):'
Patch #12 (0012-dracut-lib.sh-fixed-getargs.patch):
+ /bin/cat /root/dracut/rpmbuild/0012-dracut-lib.sh-fixed-getargs.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #13 (0013-99base-dracut-lib.sh-fix-previous-getargs-
patch.patch):'
Patch #13 (0013-99base-dracut-lib.sh-fix-previous-getargs-patch.patch):
+ /bin/cat /root/dracut/rpmbuild/0013-99base-dracut-lib.sh-fix-previous-
getargs-patch.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #14 (0014-TEST-10-RAID-test-init-add-comment-for-rd.break-
shut.patch):'
Patch #14 (0014-TEST-10-RAID-test-init-add-comment-for-rd.break-
shut.patch):
+ /bin/cat /root/dracut/rpmbuild/0014-TEST-10-RAID-test-init-add-comment-
for-rd.break-shut.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #15 (0015-busybox-module-parse-busybox-defined-functions-
dynam.patch):'
Patch #15 (0015-busybox-module-parse-busybox-defined-functions-
dynam.patch):
+ /bin/cat /root/dracut/rpmbuild/0015-busybox-module-parse-busybox-
defined-functions-dynam.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #16 (0016-dracut.kernel.7.xml-s-voonsole.keymap-
vconsole.keyma.patch):'
Patch #16 (0016-dracut.kernel.7.xml-s-voonsole.keymap-
vconsole.keyma.patch):
+ /bin/cat /root/dracut/rpmbuild/0016-dracut.kernel.7.xml-s-
voonsole.keymap-vconsole.keyma.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #17 (0017-dracut.kernel.7.xml-beautified-doc.patch):'
Patch #17 (0017-dracut.kernel.7.xml-beautified-doc.patch):
+ /bin/cat /root/dracut/rpmbuild/0017-dracut.kernel.7.xml-beautified-
doc.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #18 (0018-99base-dracut-lib.sh-don-t-be-quiet-on-
rd.debug.patch):'
Patch #18 (0018-99base-dracut-lib.sh-don-t-be-quiet-on-rd.debug.patch):
+ /bin/cat /root/dracut/rpmbuild/0018-99base-dracut-lib.sh-don-t-be-quiet-
on-rd.debug.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #19 (0019-dracut-functions-only-dinfo-about-missing-optioal-
dr.patch):'
Patch #19 (0019-dracut-functions-only-dinfo-about-missing-optioal-
dr.patch):
+ /bin/cat /root/dracut/rpmbuild/0019-dracut-functions-only-dinfo-about-
missing-optioal-dr.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #20 (0020-99base-init-try-to-mount-usr-if-init-lives-on-
usr.patch):'
Patch #20 (0020-99base-init-try-to-mount-usr-if-init-lives-on-usr.patch):
+ /bin/cat /root/dracut/rpmbuild/0020-99base-init-try-to-mount-usr-if-
init-lives-on-usr.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #21 (0021-fixed-typos.patch):'
Patch #21 (0021-fixed-typos.patch):
+ /bin/cat /root/dracut/rpmbuild/0021-fixed-typos.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #22 (0022-dracut-logger-initialize-basic-vars.patch):'
Patch #22 (0022-dracut-logger-initialize-basic-vars.patch):
+ /bin/cat /root/dracut/rpmbuild/0022-dracut-logger-initialize-basic-
vars.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #23 (0023-dracut-functions-convert-absolute-symlinks-to-
relati.patch):'
Patch #23 (0023-dracut-functions-convert-absolute-symlinks-to-
relati.patch):
+ /bin/cat /root/dracut/rpmbuild/0023-dracut-functions-convert-absolute-
symlinks-to-relati.patch
+ /usr/bin/patch -s -p1 --fuzz=0
+ echo 'Patch #24 (0024-move-debian-to-debian.template-on-request-of-
debian-.patch):'
Patch #24 (0024-move-debian-to-debian.template-on-request-of-
debian-.patch):
+ /bin/cat /root/dracut/rpmbuild/0024-move-debian-to-debian.template-on-
request-of-debian-.patch
+ /usr/bin/patch -s -p1 --fuzz=0
/usr/bin/patch: **** Only garbage was found in the patch input.
error: Bad exit status from /var/tmp/rpm-tmp.ERlVK0 (%prep)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.ERlVK0 (%prep)
mv rpmbuild/noarch/*.rpm .; mv rpmbuild/*.src.rpm .;rm -fr rpmbuild; ls 
*.rpm
mv: cannot stat `rpmbuild/noarch/*.rpm': No such file or directory
mv: cannot stat `rpmbuild/*.src.rpm': No such file or directory
ls: cannot access *.rpm: No such file or directory
make: *** [rpm] Error 2

