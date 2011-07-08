From: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/4] dracut: added new module ecryptfs
Date: Fri, 8 Jul 2011 11:10:05 -0500
Message-ID: <20110708161005.GA17422@boyd.l.tihix.com>
References: <1310127065-23292-1-git-send-email-roberto.sassu@polito.it>
 <1310127065-23292-5-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <ecryptfs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310127065-23292-5-git-send-email-roberto.sassu@polito.it>
Sender: ecryptfs-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: initramfs@vger.kernel.org, harald.hoyer@gmail.com, zohar@linux.vnet.ibm.com, safford@watson.ibm.com, ramunno@polito.it, kirkland@canonical.com, ecryptfs-devel@lists.launchpad.net, ecryptfs@vger.kernel.org

On Fri Jul 08, 2011 at 02:11:02PM +0200, Roberto Sassu <roberto.sassu@polito.it> wrote:
> This module mounts an eCryptfs filesystem from the initial ramdisk using an
> encrypted key.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
> Acked-by: Gianluca Ramunno <ramunno@polito.it>

Thanks for the quick update.

Acked-by: Tyler Hicks <tyhicks@linux.vnet.ibm.com>

> ---
>  dracut.kernel.7.xml                    |    6 ++
>  modules.d/98ecryptfs/README            |   50 ++++++++++++++++
>  modules.d/98ecryptfs/ecryptfs-mount.sh |  100 ++++++++++++++++++++++++++++++++
>  modules.d/98ecryptfs/module-setup.sh   |   20 ++++++
>  4 files changed, 176 insertions(+), 0 deletions(-)
>  create mode 100644 modules.d/98ecryptfs/README
>  create mode 100755 modules.d/98ecryptfs/ecryptfs-mount.sh
>  create mode 100755 modules.d/98ecryptfs/module-setup.sh
> 
> diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
> index 759871b..c5d74d0 100644
> --- a/dracut.kernel.7.xml
> +++ b/dracut.kernel.7.xml
> @@ -724,6 +724,12 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
>              <para>Set the path name of the EVM key. e.g.: <programlisting>evmkey=/etc/keys/evm-trusted.blob</programlisting></para>
>            </listitem>
>          </varlistentry>
> +        <varlistentry>
> +          <term><envar>ecryptfskey=</envar><replaceable>&lt;eCryptfs key path name&gt;</replaceable></term>
> +          <listitem>
> +            <para>Set the path name of the eCryptfs key. e.g.: <programlisting>ecryptfskey=/etc/keys/ecryptfs-trusted.blob</programlisting></para>
> +          </listitem>
> +        </varlistentry>
>        </variablelist>
>      </refsect2>
>      <refsect2>
> diff --git a/modules.d/98ecryptfs/README b/modules.d/98ecryptfs/README
> new file mode 100644
> index 0000000..f741c54
> --- /dev/null
> +++ b/modules.d/98ecryptfs/README
> @@ -0,0 +1,50 @@
> +# Directions for creating the encrypted key that will be used to mount an
> +# eCryptfs filesystem
> +
> +# Create the eCryptfs key (encrypted key type)
> +#
> +# The encrypted key type supports two formats: the 'default' format allows
> +# to generate a random symmetric key of the length specified, the 'ecryptfs'
> +# format generates an authentication token for the eCryptfs filesystem,
> +# which contains a randomly generated key. Two requirements for the latter
> +# format is that the key description must contain exactly 16 hexadecimal
> +# characters and that the encrypted key length must be equal to 64.
> +$ keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk-trusted 64" @u
> +782117972
> +
> +# Save the encrypted key
> +$ su -c 'keyctl pipe `keyctl search @u encrypted 1000100010001000` > /etc/keys/ecryptfs-trusted.blob'
> +
> +# The eCryptfs key path name can be set in one of the following ways (specified in
> +# the order in which the variable is overwritten):
> +
> +1) use the default value:
> +--------------------------------------------------------------------------
> +ECRYPTFSKEY="/etc/keys/ecryptfs-trusted.blob"
> +--------------------------------------------------------------------------
> +
> +2) create the configuration file '/etc/sysconfig/ecryptfs' and set the ECRYPTFSKEY
> +variable;
> +
> +3) specify the eCryptfs key path name in the 'ecryptfskey=' parameter of the kernel command
> +line.
> +
> +# The configuration file '/etc/sysconfig/ecryptfs' is also used to specify
> +# more options for mounting the eCryptfs filesystem:
> +
> +ECRYPTFSSRCDIR: existent directory in the lower root filesystem;
> +ECRYPTFSDSTDIR: mount point directory for the eCryptfs filesystem (the directory must be
> +                created in the root filesystem before rebooting the platform);
> +ECRYPTFS_EXTRA_MOUNT_OPTS: extra mount options for the eCryptfs filesystem (the 'ecryptfs_sig'
> +                           option is automatically added by the dracut script).
> +
> +# Example of the configuration file:
> +----------- '/etc/sysconfig/ecryptfs' (with default values) -----------
> +ECRYPTFS_KEY="/etc/keys/ecryptfs-trusted.blob"
> +ECRYPTFSSRCDIR="/secret"
> +ECRYPTFSDSTDIR="${ECRYPTFSSRCDIR}"
> +ECRYPTFS_EXTRA_MOUNT_OPTS=""
> +-----------------------------------------------------------------------
> +
> +# If the variable ECRYPTFSDSTDIR is not specified in the configuration file,
> +# its value will be equal to that of ECRYPTFSSRCDIR.
> diff --git a/modules.d/98ecryptfs/ecryptfs-mount.sh b/modules.d/98ecryptfs/ecryptfs-mount.sh
> new file mode 100755
> index 0000000..2f67716
> --- /dev/null
> +++ b/modules.d/98ecryptfs/ecryptfs-mount.sh
> @@ -0,0 +1,100 @@
> +#!/bin/sh
> +# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
> +# ex: ts=8 sw=4 sts=4 et filetype=sh
> +
> +# Licensed under the GPLv2
> +#
> +# Copyright (C) 2011 Politecnico di Torino, Italy
> +#                    TORSEC group -- http://security.polito.it
> +# Roberto Sassu <roberto.sassu@polito.it>
> +
> +ECRYPTFSCONFIG="${NEWROOT}/etc/sysconfig/ecryptfs"
> +ECRYPTFSKEYTYPE="encrypted"
> +ECRYPTFSKEYDESC="1000100010001000"
> +ECRYPTFSKEYID=""
> +ECRYPTFSSRCDIR="/secret"
> +ECRYPTFS_EXTRA_MOUNT_OPTS=""
> +
> +load_ecryptfs_key()
> +{
> +    # override the eCryptfs key path name from the 'ecryptfskey=' parameter in the kernel
> +    # command line
> +    ECRYPTFSKEYARG=$(getarg ecryptfskey=)
> +    [ $? -eq 0 ] && \
> +        ECRYPTFSKEY=${ECRYPTFSKEYARG}
> +
> +    # set the default value
> +    [ -z "${ECRYPTFSKEY}" ] && \
> +        ECRYPTFSKEY="/etc/keys/ecryptfs-trusted.blob";
> +
> +    # set the eCryptfs key path name
> +    ECRYPTFSKEYPATH="${NEWROOT}${ECRYPTFSKEY}"
> +
> +    # check for eCryptfs encrypted key's existence
> +    if [ ! -f "${ECRYPTFSKEYPATH}" ]; then
> +        if [ "${RD_DEBUG}" = "yes" ]; then
> +            info "eCryptfs: key file not found: ${ECRYPTFSKEYPATH}"
> +        fi
> +        return 1
> +    fi
> +
> +    # read the eCryptfs encrypted key blob
> +    KEYBLOB=$(cat ${ECRYPTFSKEYPATH})
> +
> +    # load the eCryptfs encrypted key blob
> +    ECRYPTFSKEYID=$(keyctl add ${ECRYPTFSKEYTYPE} ${ECRYPTFSKEYDESC} "load ${KEYBLOB}" @u)
> +    [ $? -eq 0 ] || {
> +        info "eCryptfs: failed to load the eCryptfs key: ${ECRYPTFSKEYDESC}";
> +        return 1;
> +    }
> +
> +    return 0
> +}
> +
> +unload_ecryptfs_key()
> +{
> +    # unlink the eCryptfs encrypted key
> +    keyctl unlink ${ECRYPTFSKEYID} @u || {
> +        info "eCryptfs: failed to unlink the eCryptfs key: ${ECRYPTFSKEYDESC}";
> +        return 1;
> +    }
> +
> +    return 0
> +}
> +
> +mount_ecryptfs()
> +{
> +    # read the configuration from the config file
> +    [ -f "${ECRYPTFSCONFIG}" ] && \
> +        . ${ECRYPTFSCONFIG}
> +
> +    # load the eCryptfs encrypted key
> +    load_ecryptfs_key || return 1
> +
> +    # set the default value for ECRYPTFSDSTDIR
> +    [ -z "${ECRYPTFSDSTDIR}" ] && \
> +        ECRYPTFSDSTDIR=${ECRYPTFSSRCDIR}
> +
> +    # set the eCryptfs filesystem mount point
> +    ECRYPTFSSRCMNT="${NEWROOT}${ECRYPTFSSRCDIR}"
> +    ECRYPTFSDSTMNT="${NEWROOT}${ECRYPTFSDSTDIR}"
> +
> +    # build the mount options variable
> +    ECRYPTFS_MOUNT_OPTS="ecryptfs_sig=${ECRYPTFSKEYDESC}"
> +    [ ! -z "${ECRYPTFS_EXTRA_MOUNT_OPTS}" ] && \
> +        ECRYPTFS_MOUNT_OPTS="${ECRYPTFS_MOUNT_OPTS},${ECRYPTFS_EXTRA_MOUNT_OPTS}"
> +
> +    # mount the eCryptfs filesystem
> +    info "Mounting the configured eCryptfs filesystem"
> +    mount -i -t ecryptfs -o${ECRYPTFS_MOUNT_OPTS} ${ECRYPTFSSRCMNT} ${ECRYPTFSDSTMNT} >/dev/null || {
> +        info "eCryptfs: mount of the eCryptfs filesystem failed";
> +        return 1;
> +    }
> +
> +    # unload the eCryptfs encrypted key
> +    unload_ecryptfs_key || return 1
> +
> +    return 0
> +}
> +
> +mount_ecryptfs
> diff --git a/modules.d/98ecryptfs/module-setup.sh b/modules.d/98ecryptfs/module-setup.sh
> new file mode 100755
> index 0000000..56c2d41
> --- /dev/null
> +++ b/modules.d/98ecryptfs/module-setup.sh
> @@ -0,0 +1,20 @@
> +#!/bin/bash
> +# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
> +# ex: ts=8 sw=4 sts=4 et filetype=sh
> +
> +check() {
> +    return 0
> +}
> +
> +depends() {
> +    echo masterkey
> +    return 0
> +}
> +
> +installkernel() {
> +    instmods ecryptfs
> +}
> +
> +install() {
> +    inst_hook pre-pivot 63 "$moddir/ecryptfs-mount.sh"
> +}
> -- 
> 1.7.4.4
> 


