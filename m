From: "Blatt, Andrew C" <andrew.blatt-0VvZYiCTZkr6SQ/niu2adgC/G2K4zDHf@public.gmane.org>
Subject: Request for bonding support (lacp and alb options).
Date: Thu, 17 Jun 2010 10:40:11 -0400
Message-ID: <A0AB91A7860A204E9419232B858135D90235E2F3@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1276785624;
	bh=77KxbAkGEtuwUH2ytvT4LdrwVno5AelXyP3k8lXqFgc=;
	h=Date:From:Subject:To:Message-id:MIME-version:Content-type:
	 Content-transfer-encoding;
	b=wEFileAc+X7ou9WZi8wzME89VcPDNu2x89ojfNByW4n+uUZ/44KP++2q+ysOPj3Ob
	 sSgg1u3Rbech9KDO/moaHKvWVg0CW3y/pm7V/JInviAjJ/S2+pfPfYwSxqgWB3s3ro
	 mQxhe8yFfEVqNGAx2Q3yVkZw1zsFS0yLobvoRKVM=
Content-class: urn:content-classes:message
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

Is it possible to add bonding support in Dracut?  We currently have 2
bonding options in our current stateless environment (using busybox
initrd), but looking to move to Dracut when using RH6/Fedora13 going
forward..

Currently, we do the following in our init script:

We currently are using NETWORK= passed on cmdline:

# NETSTR formats:
# NETWORK=bridge
# NETWORK=lacp:second-nic-mac
# NETWORK=bond:second-nic-mac

Here is a snip from our init script:

...
...
# add virtio
insmod /lib/virtio_ring.ko
insmod /lib/virtio.ko
insmod /lib/virtio_pci.ko

NETDRIVERS=`/sbin/kudzu -q -p -c NETWORK | awk '/driver/ {print $2}' |
uniq`

for DRIVER in ${NETDRIVERS}
do
      # Loading the igb driver kills the IMM
      if [ ${DRIVER} != 'igb' ]
      then
            echo loading /lib/${DRIVER}.ko
            insmod /lib/${DRIVER}.ko

            if [ ${DRIVER} = 'mlx4_core' ]
            then
                  insmod /lib/mlx4_en.ko
            fi
      fi
done

# BOOTIF is passed on cmdline
# requires IPAPPEND 2 in pxelinux.cfg/default file BOOTIF=`echo
${BOOTIF} |sed 's/^01-//' |sed  's/\-/:/g'` echo ipappend bootif is
${BOOTIF}

# Get the NETWORK string from the cmdline # Also BOOTIF if not defined
for STR in `cat /proc/cmdline` do
      KEY=`echo $STR |awk -F= '{print $1}' | sed 's/^01-//' | sed
's/\-/:/g'`

      if [ ${KEY} = "NETWORK" ]
      then
            NETSTR=`echo $STR |awk -F= '{print $2}'`
            echo cmdline network is ${NETSTR}
      fi

      if [ -z "${BOOTIF}" ]
      then
            if [ ${KEY} = "BOOTIF" ]
            then
                  BOOTIF=`echo $STR |awk -F= '{print $2}'`
                  echo cmdline bootif is ${BOOTIF}
            fi
      fi
done

# Match the BOOTIF address to a ethX device if [ ! -z "${BOOTIF}" ] then
   for ETH in `(cd /sys/class/net; ls -d eth*)`
   do
      if grep -i $BOOTIF /sys/class/net/${ETH}/address > /dev/null
      then
            export NIC1=${ETH}
            echo NIC1 is ${NIC1}
            break
      fi
   done
fi

# If not found default to eth0
if [ -z "${NIC1}" ]
then 
      export NIC1="eth0"
fi

# NETSTR formats:
# NETWORK=bridge
# NETWORK=lacp:second-nic-mac
# NETWORK=bond:second-nic-mac

if echo ${NETSTR} | grep bridge > /dev/null 2>&1 then
      BRIDGE=1
else
      BRIDGE=0
fi

if echo ${NETSTR} | grep lacp > /dev/null 2>&1 then
      LACP=1
        BOOTIF2=`echo ${NETSTR} |awk -F: '{print $2}' | sed 's/^01-//' |
sed 's/\-/:/g'` else
      LACP=0
fi

if echo ${NETSTR} | grep bond > /dev/null 2>&1 then
      BOND=1
        BOOTIF2=`echo ${NETSTR} |awk -F: '{print $2}' | sed 's/^01-//' |
sed 's/\-/:/g'` else
      BOND=0
fi

# BOOTIF2 is the mac address of the second link in a bond if [ ! -z
"${BOOTIF2}" ] then
   # Match the BOOTIF2 address to a ethX device
   for ETH in `(cd /sys/class/net; ls -d eth*)`
   do
      if grep -i ${BOOTIF2} /sys/class/net/${ETH}/address > /dev/null
      then
            export NIC2=${ETH}
            echo NIC2 is ${NIC2}
            break
      fi
   done
else
      # Guess the NIC to use, ${NIC1} plus 1
      NUMBER=`echo ${NIC1} | sed s/eth//`
      NEXTNUMBER=`expr ${NUMBER} + 1`
      NIC2="eth"${NEXTNUMBER}
fi

if [ ${BRIDGE} -eq 1 ]
then
      echo Creating a KVM bridge
      insmod /lib/bridge.ko
      brctl addbr bridge1
      brctl addif bridge1 ${NIC1}
      ip link set bridge1 up
      ip link set ${NIC1} up
      export NIC1=bridge1
fi

if [ ${BOND} -eq 1 ]
then
      # A ALB bond
      insmod /lib/crypto_api.ko
      insmod /lib/xfrm_nalgo.ko
      insmod /lib/ipv6.ko 
      insmod /lib/bonding.ko miimon=100 mode=balance-alb downdelay=1000
updelay=5000
      
elif [ ${LACP} -eq 1 ]
then
      # A LACP bond
      insmod /lib/crypto_api.ko
      insmod /lib/xfrm_nalgo.ko
      insmod /lib/ipv6.ko 
      insmod /lib/bonding.ko miimon=100 mode=802.3ad lacp_rate=1
      
fi

if [ ${BOND} -eq 1 -o ${LACP} -eq 1 ]
then
      # Set the bond link up
      ip link set bond0 up

      # Set eth0 bond so it can be added to the bond
      ip link set ${NIC1} down

      # Add the interfaces to the bond
      echo +${NIC1} > /sys/class/net/bond0/bonding/slaves
      echo +${NIC2} > /sys/class/net/bond0/bonding/slaves
      export NIC1=bond0

      # Wait for a while for the bond to sort itself out
      sleep 5
fi


# DEBUG
sleep 30

# Now let netstart get a DHCP address on the interface (${NIC1}) COUNT=0
MAX_COUNT=3
while [ ${COUNT} -le ${MAX_COUNT} ]
do
      echo "Running netstart for $NIC1"
      export ETHERNET=${NIC1}
      netstart
      if ! ifconfig | grep inet > /dev/null
      then
            echo -e "${RED}Failed to acquire address, retrying ${RESET}"
            sleep 1
            COUNT=`expr ${COUNT} + 1`
      else
            # We have an address so exit
            break
      fi
done

if ! ifconfig | grep inet > /dev/null
then
      echo -e "${RED}Failed to acquire address ${RESET}"
      echo -e "${RED}sleeping for a very long time${RESET}"
      sleep 99d
fi

...
...


Thanks.
