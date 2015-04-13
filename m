From: Martin Whitaker <mailing-list-3eMjGWAP0YmXMog9sF/ZqQnefFxSTc/J@public.gmane.org>
Subject: [PATCH] Allow boot to continue if swap devices are not detected.
Date: Mon, 13 Apr 2015 23:21:33 +0100
Message-ID: <552C416D.7070603@martin-whitaker.me.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

In hostonly mode, any swap devices found in the fstab when the initrd
is generated are added to the $host_devs list. If these devices are
not detected on boot, dracut drops to the emergency shell and won't
continue the boot. This patch creates a timeout job for each swap
device that removes the corresponding finished job from the initqueue,
thus allowing boot to continue. This gives the user a chance to
still boot a system if the UUIDs have changed (e.g. because they've
installed another system that's reformatted the swap partition).

diff --git a/dracut.sh b/dracut.sh
index ab84221..2d43d1b 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1223,7 +1223,9 @@ if [[ $hostonly ]]; then
                      done < /etc/crypttab
                  fi
  -                push_host_devs "$(readlink -f "$dev")"
+                _dev=$(readlink -f "$dev")
+                push_host_devs $_dev
+                push swap_devs $_dev
                  break
              done < /etc/fstab
          done < /proc/swaps
@@ -1334,7 +1336,7 @@ export initdir dracutbasedir \
      omit_drivers mdadmconf lvmconf root_dev \
      use_fstab fstab_lines libdirs fscks nofscks ro_mnt \
      stdloglvl sysloglvl fileloglvl kmsgloglvl logfile \
-    debug host_fs_types host_devs sshkey add_fstab \
+    debug host_fs_types host_devs swap_devs sshkey add_fstab \
      DRACUT_VERSION udevdir prefix filesystems drivers \
      systemdutildir systemdsystemunitdir systemdsystemconfdir \
      host_modalias host_modules hostonly_cmdline loginstall \
diff --git a/modules.d/99base/dracut-lib.sh b/modules.d/99base/dracut-lib.sh
index 259e205..4f19ade 100755
--- a/modules.d/99base/dracut-lib.sh
+++ b/modules.d/99base/dracut-lib.sh
@@ -953,6 +953,22 @@ wait_for_dev()
      fi
  }
  +timeout_wait_for_dev()
+{
+    local _name
+    _name="$(str_replace "$1" '/' '\x2f')"
+
+    type mark_hostonly >/dev/null 2>&1 && mark_hostonly 
"$hookdir/initqueue/timeout/devexists-${_name}.sh"
+
+    [ -e "${PREFIX}$hookdir/initqueue/timeout/devexists-${_name}.sh" ] && 
return 0
+
+    {
+        printf 'warn "Cancelling wait for %s. Device not found."\n' $1
+        printf 'cancel_wait_for_dev %s\n' $1
+        printf 'rm -f -- "$job"\n'
+    } >> "${PREFIX}$hookdir/initqueue/timeout/devexists-${_name}.sh"
+}
+
  cancel_wait_for_dev()
  {
      local _name
diff --git a/modules.d/99base/module-setup.sh b/modules.d/99base/module-setup.sh
index fd65cdf..3b891b7 100755
--- a/modules.d/99base/module-setup.sh
+++ b/modules.d/99base/module-setup.sh
@@ -110,6 +110,15 @@ install() {
                          *) ;;
                      esac
                  done
+                for _dev in ${swap_devs[@]}; do
+                    [[ "$_dev" == "$root_dev" ]] && continue
+                    _pdev=$(get_persistent_dev $_dev)
+
+                    case "$_pdev" in
+                        /dev/?*) timeout_wait_for_dev $_pdev;;
+                        *) ;;
+                    esac
+                done
              )
          fi
      fi
-- 
2.3.2
