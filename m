From: shadowfax-KK0ffGbhmjU@public.gmane.org
Subject: =?UTF-8?q?=5BPATCH=5D=20Draft=3A=20sshkey=20module=20to=20grab=20disk=20keys=20from=20ssh=20server?=
Date: Fri, 10 Sep 2010 06:06:03 -0600
Message-ID: <1284120363-4011-1-git-send-email-shadowfax@gmx.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

=46rom: Matt Smith <shadowfax-KK0ffGbhmjU@public.gmane.org>

See the README for information about it, and how to use it.

This module is not completed, but I decide to post it
for feedback and any help. The code and setup works alright,
but the networking has me stumpted. It just needs to come up
for long enough to get the keys, and then go back down.

This may be simpler than I think, as I am not very familar with
dracut's networking.

Oh, and when I say draft, I mean it still has my notes in it. But
I did keep it clean and readable. And I tried to use [] in the readme
whenever I had a concern or question about something.
---
 modules.d/90crypt/cryptroot-ask.sh |   83 +++++++++++++++++
 modules.d/95sshkey/README          |  174 ++++++++++++++++++++++++++++=
++++++++
 modules.d/95sshkey/check           |   23 +++++
 modules.d/95sshkey/install         |   14 +++
 modules.d/95sshkey/ssh_config      |   30 ++++++
 5 files changed, 324 insertions(+), 0 deletions(-)
 create mode 100644 modules.d/95sshkey/README
 create mode 100755 modules.d/95sshkey/check
 create mode 100755 modules.d/95sshkey/install
 create mode 100644 modules.d/95sshkey/ssh_config

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cry=
ptroot-ask.sh
index efec56c..7341edd 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -105,6 +105,72 @@ fi
 unset keypaths
=20
 #
+# Get key by way of ssh
+#
+# We will use sftp to get keys, if requested and module is installed.
+
+# This may be better in its own script which is run earlier, and that =
keeps
+# the keys. That would save on connections and maybe start the network=
 at a better time?
+# Currently there is no network setup.
+
+# Server user and host; user@server
+sshkey_connect=3D"$(getargs rd_LUKS_SSHKEY_CONNECT)"
+# /path/to/key
+sshkey_path=3D"$(getargs rd_LUKS_SSHKEY_PATH)"
+
+# checks
+if [ -n "$sshkey_connect" ] &&[ -z "$sshkey_path" ]; then
+    warn "ssh key file path is empty. Please set rd_LUKS_SSHKEY_PATH."
+
+elif [ -n "$sshkey_connect" ] && [ -n "$sshkey_path" ]; then
+    # save keys here
+    sshkey_save=3D"/mnt/sshkey"
+    # get other args:  -o ciphers=3Dblah -o port=3D2222 -o user=3Dyour=
user
+    sshkey_args=3D"$(getargs rd_LUKS_SSHKEY_ARGS)"
+   =20
+    # process args (old idea that I left in case people like it better=
)
+    # it left out the '-o', like args=3D'port=3D222 user=3Dusername"
+    # I believe it will have a problem with spaces in the args
+#    $sshkey_args=3D""
+#    if [ "x$sshkey_args_line" !=3D "x" ]; then
+#        $sshkey_args=3D"$(echo $sshkey_args_line | sed 's/ / -o /g')"
+#    fi
+    info "Obtaining key/s from keyserver"
+    mkdir -p -m 700 "$sshkey_save"
+    sshkey_got=3D255
+    # loop to allow for failed connects and server problems, avoiding =
need to reboot
+    # this can be useful with network outages and higher security of k=
eys
+    # except if specified no to do so (see last line)
+    while [ $sshkey_got -ne 0 ]; do
+        # dont quote sshkey_args, it contains multiple args
+	info "sftp -F /root/.ssh/config $sshkey_args $sshkey_connect:$sshkey_=
path/* $sshkey_save"
+	# info "$(ip addr)"
+	# get keys. Dont use recursive (-r) until more users have it. It was
+	# introduced in openssh 5.4, could cause problems, and this works fin=
e.
+	sftp -F "/root/.ssh/config" $sshkey_args "$sshkey_connect:$sshkey_pat=
h/*" "$sshkey_save/"
+	sshkey_got=3D$?
+	[ $sshkey_got -eq 0 ] || sleep 10
+	info "$(ls $sshkey_save)"
+	[ getargs rd_LUKS_SSHKEY_NOLOOP ] && sshkey_got=3D0
+    done
+   =20
+    # make sure we got something
+    if [ -n "$(ls $sshkey_save)" ]; then
+        info "Got keys"
+    else
+	info "Did not get any keys. Reverting to password method"
+	rmdir "$sshkey_save"
+	sshkey_save=3D""
+    fi
+   =20
+    unset sshkey_connect sshkey_path sshkey_args
+    unset sshkey_got
+fi
+
+# [ -f /file ] && . /file
+
+
+#
 # Open LUKS device
 #
=20
@@ -118,6 +184,23 @@ if [ -n "$keydev_uuid" ]; then
     umount "$mntp"
     rmdir -p "$mntp" 2>/dev/null
     unset mntp keypath keydev_uuid
+
+elif [ -d "$sshkey_save" ]; then
+    # First, try a master key, then the uuid, then try all=20
+    # keys (just to be nice, but they cannot have spaces)
+    for KEY in master "$luksname" $(ls "$sshkey_save"); do
+        try_key=3D"$sshkey_save/$KEY"
+	if [ -f "$try_key" ] ; then
+	    info "Trying key $KEY"
+	    cryptsetup -d "$try_key" luksOpen "$device" "$luksname"
+            [ $? -eq 0 ] && break
+	fi
+    done
+    rm -f $sshkey_save/*
+    rmdir "$sshkey_save"
+    # TODO??: leave key to be deleted later (we may have multiple part=
itions to unlock)
+    # what happens to ramdisk after boot? if it completely disappears,=
 we could leave keys
+   =20
 else
     # Prompt for password with plymouth, if installed.
     # Should we check if plymouthd is running?
diff --git a/modules.d/95sshkey/README b/modules.d/95sshkey/README
new file mode 100644
index 0000000..1595135
--- /dev/null
+++ b/modules.d/95sshkey/README
@@ -0,0 +1,174 @@
+
+Introduction
+
+This dracut module allows your machine(s) to automatically open encryp=
ted
+volumes without human intervention. It should be of value to those who
+operate lots of machines, especially in clustered enviroments, where
+the admin does not want to have to input passwords nor plugin usb
+drives everytime there is a reboot, yet desires to prevent data theft.
+
+Of course there are secrity issues, but not many that aren't already a=
n
+issue. See the security section below for more infomation.
+
+How it works
+
+We have two machines: the 'client' which needs its encryption
+key(s) in order to open its encrypted volumes, and the 'key server'
+which holds those encryption keys.
+
+The client boots and starts up its networking. It then connects to the=
 key
+server by way of ssh to get its keys, verifying the key server's
+fingerprint to prevent a man-in-the-middle attack. Once it has its key=
s, it opens
+its encrypted volume(s) and discards the keys. It then shuts down
+the networking and continues to boot.
+
+Grub command line options
+
+The address of the key server. You can use the actual address or a
+host name (the /etc/hosts file is copied into the initram). User name
+is recommended, as without it 'root' is used which is a security risk.
+
+  rd_LUKS_SSHKEY_CONNECT=3Duser-Q0ErXNX1RuYHl39pQlpXfw@public.gmane.org
+
+Path to directory holding the ssh keys. Note that this is the
+directory as accessed from sftp, so if you use a chroot setup you will
+need to state it according to the client's access.
+
+  rd_LUKS_SSHKEY_PATH=3D/path/to/keys/directory
+
+Extra arguments to pass to ssh. [currently implemented using the first=
 one].
+
+  rd_LUKS_SSHKEY_ARGS=3D"-o Port=3D2222 -o User=3Dusername"
+  [old idea: rd_LUKS_SSHKEY_ARGS=3D"Port=3D2222 User=3Dusername"]
+
+By default the module will continue to try to get the key(s) until it
+connects, gets its keys, and recieves an exit of 0. Setting this
+variable will disable that so it only will try to get a key once.
+Useful for debugging and testing.
+
+   rd_LUKS_SSHKEY_NOLOOP
+
+[networking options?] rd_LUKS_SSHKEY_IP/DHCP
+
+
+Needed keys and files
+
+The ssh key file and known_hosts files come from /root. The ssh key mu=
st
+_not_ be password protected. Without these files, the module will not =
install.
+  Key to access key server: /root/.ssh/dracut_sshkey
+  Machine verification:     /root/.ssh/known_hosts
+
+
+Naming of keys
+
+To begin, sftp downloads the entire rd_LUKS_SSHKEY_PATH directory,
+non-recursively, and will try all the files in that directory to=20
+open the drive. Just make sure you don't use any spaces in your file n=
ames.
+
+However, some setups may have many disks/devices, and requirements for=
=20
+each to have different keys. For these and others requiring fast setup=
s,
+there is a prefence to the order in which the keys are used.
+
+The first key name is 'master', which is always tried.  The second is=20
+the UUID of the device, from 'cryptsetup luksDump', prefixed by 'luks-=
'.=20
+It's the name that is usually seen /dev/mapper.
+
+For example: luks-84c4b4e0-ed8d-4f00-a5ef-ab3b98cfcc98
+
+And then all the other keys are tried in alphabetical order using a si=
mple 'ls'.
+
+
+IV. Security Concerns
+
+This section is very important. You must understand that you are
+allowing your machines to open encrypted partitions on their own,
+without any supervision or outside authorization.
+
+Remember to not rely on just the encryption keys. You should also have
+a long password or your own usb keyfile. The last thing you want=20
+is the key server messing up your keys, and you not being able to=20
+access the data.
+
+[ do we need this? ]
+Also note that while the dracut mailing list may help with problems in
+this area, it does not specialize in it. Your questions would
+be better answered in a security forum, or from the openssh mailing
+list. (It'd be like asking the kernel developers how to create a
+complex website. It's not what they do.)
+
+
+1. Physical Security.
+
+You must physically secure your machines. The private key that connect=
s
+to the key server will be located on the /boot partition in plain text=
=2E
+Anyone with access to the machine could get that key and then get the
+encryption key from the key server.
+
+Also note that many computer memory modules (the physical ones) retain
+their memory state from seconds to even minutes after the power is
+disconnected. Thus someone who has physical access could scan the
+memory module for your key(s). This currently is a known attack vector
+for storage of keys. (Even with safer modules, you still should
+not rely on the machine being able to protect itself.)
+
+
+2. Client Security.
+
+The initram file must be set to 600 [TODO], as it contains the ssh
+keys for accessing the keyserver.
+
+We verify the key server's fingerprint using root's known_hosts.=20
+[do we need any keys if HashKnownHosts is set? Does it hash the hosts
+according to machine keys, or is it independant?]
+
+
+3. Key Server Security.
+
+The key server must be secure as well. Have a good firewall, limit
+access to it, and treat it very special. It holds a gold mine.=20
+
+You may want to use ChrootDirectory to limit what data each client
+can access, as well as limit any breaches from either exploits or
+misconfigurations.
+
+Here is part of a sshd_config example that chroots all users of group
+'keyusers' into /keys/$username, and only allows access from the
+internal network:
+
+[needs work]
+
+Subsystem   sftp   internal-sftp
+
+Match Group keyusers Address 10.43.56.78/24
+  X11Forward no
+  AllowTcpForwarding no
+  PasswordAuthentication no
+  ChrootDirectory /keys/%u
+  ForceCommand internal-sftp
+
+Remember that since the chroot directory must be owned by root, you wi=
ll
+need a directory inside the chroot that is only accessible by that
+user. On SELinux systems you may have to change the file contexts with
+chcon and semanage (user_home_t). See sshd_config manual for more info=
=2E
+
+And make sure you _test_ it for weaknesses before you put it into use.
+
+
+4. Keyserver advanced security, availability, and ideas.
+
+If you can, you should store the keys in an encrypted partition on the=
 key server
+and store the keys there. That way even if the key server is stolen,
+it won't help the attacker. You may want to only leave it open during
+business hours, or maybe more/less.
+
+If you are in an enviroment where high availability is desired, you
+may need to have two key servers that share the keys by way of drbd
+(through encrypted channels, of course). This would also allow you to
+encrypt the entire machine (key server), since it would failover to
+the next one. [but we want to allow it to close enc area in case of a
+mem swipe].
+
+As an advanced idea, you could theoretically implement a automatic key
+changing script that would change the encryption key(s) once every
+while. This could limit the window of opportunity for the attacker. Or
+it may be used against you / break your system. YMMV.
diff --git a/modules.d/95sshkey/check b/modules.d/95sshkey/check
new file mode 100755
index 0000000..32bb1e4
--- /dev/null
+++ b/modules.d/95sshkey/check
@@ -0,0 +1,23 @@
+#!/bin/bash
+# We depend on network modules being loaded
+[ "$1" =3D "-d" ] && echo network
+
+# did 90crypt get loaded (how can we do this?)
+
+
+# If hostonly was requested, fail the check if there is not match in g=
rub
+# (probably a terrible way to do this - we are suppose to be independa=
nt)
+if [ "$1" =3D "-h" ]; then
+    [ "$(grep rd_LUKS_SSHKEY_CONNECT /boot/grub/menu.lst)" ] || exit 1
+fi
+
+# if cryptsetup is not installed, then we cannot support encrypted dev=
ices.
+# no need if we can detect if 90crypt was successful
+which cryptsetup >/dev/null 2>&1 || exit 1
+
+# If our prerequisites are not met, fail anyways.
+which sftp >/dev/null 2>&1 || exit 1
+[ -s /root/.ssh/known_hosts ] || exit 1
+[ -s /root/.ssh/dracut_sshkey ] || exit 1
+
+exit 0
diff --git a/modules.d/95sshkey/install b/modules.d/95sshkey/install
new file mode 100755
index 0000000..e958a9a
--- /dev/null
+++ b/modules.d/95sshkey/install
@@ -0,0 +1,14 @@
+#!/bin/sh
+dracut_install sftp
+# libs? ldd `which sftp` <- I did not need this
+
+dracut_install /root/.ssh/known_hosts
+dracut_install /root/.ssh/dracut_sshkey
+inst "$moddir"/ssh_config /root/.ssh/config
+# dracut_install /root/.ssh/config
+# (not needed - usually just extra) dracut_install /etc/ssh/ssh_config
+
+dracut_install /etc/hosts
+
+# 95nfs has a lot of info
+# do we need passwd?
diff --git a/modules.d/95sshkey/ssh_config b/modules.d/95sshkey/ssh_con=
fig
new file mode 100644
index 0000000..a07d720
--- /dev/null
+++ b/modules.d/95sshkey/ssh_config
@@ -0,0 +1,30 @@
+# Remenber, it's the first found option that is used:
+# 1. command-line options
+# 2. user=E2=80=99s configuration file (this file)
+# 3. system-wide configuration file (/etc/ssh/ssh_config)
+
+Host *
+BatchMode yes
+IdentityFile /root/.ssh/dracut_sshkey
+UserKnownHostsFile /root/.ssh/known_hosts
+StrictHostKeyChecking yes
+ForwardAgent no
+ForwardX11 no
+ForwardX11Trusted no
+
+
+# 'Thrown out' ideas
+
+# We should not specify ciphers in case they get changed/dropped in
+# the future, and the user can specify their own options.
+## Ciphers aes256-ctr,arcfour256,aes192-ctr,arcfour128,aes128-ctr,aes2=
56-cbc,aes192-cbc,aes128-cbc,3des-cbc,blowfish-cbc,cast128-cbc
+
+# This won't work if server is using a closed encrypted partition
+# to store keys. It will just fail, and we will have to manually
+# reboot machine after opening the partition. It's better to just
+# loop it.
+## This will keep on trying to connect to ssh server, even=20
+## if it is not there or is refusing connections (like during
+## a reboot), for 1157 days. Nice for tmp outages.
+## ConnectionAttempts 99999999
+
--=20
1.7.2.2
