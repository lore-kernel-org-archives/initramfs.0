From: <Praveen_Paladugu-DYMqY+WieiM@public.gmane.org>
Subject: Installing an OS with VLAN enabled to an ISCSI LUN (from ibft)
Date: Tue, 10 Jun 2014 10:35:16 -0500
Message-ID: <ABF506AF5815F54BB6579628C0CD9F9956345880E3@AUSX7MCPS310.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


When installing OS to a VLAN enabled iscsi LUN (extracted from iBFT), "/tmp/net.{xyz}.has_ibft_config" is not being set properly. 

Then anaconda installer requires 'BOOTPROTO="ibft"' populated in ifcfg of the vlan interface (ex: ibft0.20), for it to properly populate the kernel parameters post installation. The setting 'BOOTPROTO="ibft"' is populated by write-ifcfg.sh script only if the corresponding interface has a file /tmp/net.{xyz}.has_inft_config


To get around this issue, in ibft_to_cmdline() function in net-lib.sh file, I made the following changes to populate the has_ibft_config file for the vlan interface(ex: ibft0.20):

diff -up dracut-033/modules.d/40network/net-lib.sh.old dracut-033/modules.d/40network/net-lib.sh
--- dracut-033/modules.d/40network/net-lib.sh.old	2014-06-10 10:21:32.326572725 -0500
+++ dracut-033/modules.d/40network/net-lib.sh	2014-06-10 10:24:28.523422425 -0500
@@ -248,15 +248,19 @@ ibft_to_cmdline() {
                    case "$vlan" in
                        [0-9]*)
                            echo "vlan=$dev.$vlan:$dev"
+                           echo $mac > /tmp/net.${dev}.${vlan}.has_ibft_config
                            ;;
                        *)
                            echo "vlan=$vlan:$dev"
+                           echo $mac > /tmp/net.${dev}.has_ibft_config
                            ;;
                    esac
                fi
+            else
+                echo $mac > /tmp/net.${dev}.has_ibft_config
+                
             fi
 
-            echo $mac > /tmp/net.${dev}.has_ibft_config
         done
     ) >> /etc/cmdline.d/40-ibft.conf
 }


 


Thank you
Praveen K Paladugu
Dell Linux Engineering
