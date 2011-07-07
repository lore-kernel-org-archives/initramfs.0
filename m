From: Tyler Hicks <tyhicks-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] dracut: added new module ecryptfs
Date: Thu, 7 Jul 2011 11:32:57 -0500
Message-ID: <20110707163256.GB12563@boyd.l.tihix.com>
References: <1309882990-2828-1-git-send-email-roberto.sassu@polito.it>
 <1309882990-2828-5-git-send-email-roberto.sassu@polito.it>
 <20110707155555.GA12563@boyd.l.tihix.com>
 <201107071809.12080.roberto.sassu@polito.it>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201107071809.12080.roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, safford-aZOuKsOsJu3MbYB6QlFGEg@public.gmane.org, ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org, kirkland-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, ecryptfs-devel-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org

On Thu Jul 07, 2011 at 06:09:11PM +0200, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org> wrote:
> Hi Tyler
> 
> thanks for comments. I'll implement them in
> the next version of patches.
> Just one improvement that i can see is to leave
> the ECRYPTFS_EXTRA_MOUNT_OPTS variable
> empty, so that we don't need to change the
> script if the default value of an eCryptfs mount
> parameter changes. What do you think about it?

That makes sense to me.

Tyler

> 
> Roberto Sassu
> 
> 
> On Thursday, July 07, 2011 05:55:56 PM Tyler Hicks wrote:
> > On Tue Jul 05, 2011 at 06:23:07PM +0200, Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org> wrote:
> > > This modules mounts an eCryptfs filesystem from the initial ramdisk using
> > > an encrypted key.
> > 
> > Thanks Roberto - this is very useful. This patch looks pretty good, but
> > I do have a few comments below.
> > 
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> > > Acked-by: Gianluca Ramunno <ramunno-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> > > ---
> > >  dracut.kernel.7.xml                    |    6 ++
> > >  modules.d/98ecryptfs/README            |   45 +++++++++++++++
> > >  modules.d/98ecryptfs/ecryptfs-mount.sh |   95 ++++++++++++++++++++++++++++++++
> > >  modules.d/98ecryptfs/module-setup.sh   |   20 +++++++
> > >  4 files changed, 166 insertions(+), 0 deletions(-)
> > >  create mode 100644 modules.d/98ecryptfs/README
> > >  create mode 100755 modules.d/98ecryptfs/ecryptfs-mount.sh
> > >  create mode 100755 modules.d/98ecryptfs/module-setup.sh
> > > 
> > > diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
> > > index 759871b..c5d74d0 100644
> > > --- a/dracut.kernel.7.xml
> > > +++ b/dracut.kernel.7.xml
> > > @@ -724,6 +724,12 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
> > >              <para>Set the path name of the EVM key. e.g.: <programlisting>evmkey=/etc/keys/evm-trusted.blob</programlisting></para>
> > >            </listitem>
> > >          </varlistentry>
> > > +        <varlistentry>
> > > +          <term><envar>ecryptfskey=</envar><replaceable>&lt;eCryptfs key path name&gt;</replaceable></term>
> > > +          <listitem>
> > > +            <para>Set the path name of the eCryptfs key. e.g.: <programlisting>ecryptfskey=/etc/keys/ecryptfs-trusted.blob</programlisting></para>
> > > +          </listitem>
> > > +        </varlistentry>
> > >        </variablelist>
> > >      </refsect2>
> > >      <refsect2>
> > > diff --git a/modules.d/98ecryptfs/README b/modules.d/98ecryptfs/README
> > > new file mode 100644
> > > index 0000000..c592d8d
> > > --- /dev/null
> > > +++ b/modules.d/98ecryptfs/README
> > > @@ -0,0 +1,45 @@
> > > +# Directions for creating the encrypted key that will be used to mount an
> > > +# eCryptfs filesystem
> > > +
> > > +# Create the eCryptfs key (encrypted key type)
> > > +#
> > > +# The encrypted key type supports two formats: the 'default' format allows
> > > +# to generate a random symmetric key of the length specified, the 'ecryptfs'
> > > +# format generates an authentication token for the eCryptfs filesystem,
> > > +# which contains a randomly generated key. Two requirements for the latter
> > > +# format is that the key description must contain exactly 16 hexadecimal
> > > +# characters and that the encrypted key length must be equal to 64.
> > > +$ keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk-trusted 64" @u
> > > +782117972
> > > +
> > > +# Save the encrypted key
> > > +$ su -c 'keyctl pipe `keyctl search @u encrypted 1000100010001000` > /etc/keys/ecryptfs-trusted.blob'
> > > +
> > > +# The eCryptfs key path name can be set in one of the following ways (specified in
> > > +# the order in which the variable is overwritten):
> > > +
> > > +1) use the default value:
> > > +--------------------------------------------------------------------------
> > > +ECRYPTFSKEY=/etc/keys/ecryptfs-trusted.blob
> > > +--------------------------------------------------------------------------
> > > +
> > > +2) create the configuration file '/etc/sysconfig/ecryptfs' and set the ECRYPTFSKEY
> > > +variable;
> > > +
> > > +3) specify the eCryptfs key path name in the 'ecryptfskey=' parameter of the kernel command
> > > +line.
> > > +
> > > +# The configuration file '/etc/sysconfig/ecryptfs' is also used to specify
> > > +# more options for mounting the eCryptfs filesystem:
> > > +
> > > +ECRYPTFSDIR: mount point directory for the eCryptfs filesystem (the directory must be
> > > +             created in the root filesystem before rebooting the system);
> > 
> > I'd like to see an ECRYPTFSSRCDIR and ECRYPTFSDSTDIR defined to allow
> > different source and destination directories. You can default both of
> > those variables to "/secret" and still keep the same functionality that
> > is in this patch.
> > 
> > > +ECRYPTFS_EXTRA_MOUNT_OPTS: extra mount options for the eCryptfs filesystem (the 'ecryptfs_sig'
> > > +                           option is automatically added by the dracut script) 
> > > +
> > > +# Example of the configuration file:
> > > +----------- '/etc/sysconfig/ecryptfs' (with default values) -----------
> > > +ECRYPTFS_KEY=/etc/keys/ecryptfs-trusted.blob
> > > +ECRYPTFSDIR="/secret"
> > > +ECRYPTFS_EXTRA_MOUNT_OPTS="ecryptfs_cipher=aes,ecryptfs_key_bytes=32"
> > > +-----------------------------------------------------------------------
> > > diff --git a/modules.d/98ecryptfs/ecryptfs-mount.sh b/modules.d/98ecryptfs/ecryptfs-mount.sh
> > > new file mode 100755
> > > index 0000000..b1abfc2
> > > --- /dev/null
> > > +++ b/modules.d/98ecryptfs/ecryptfs-mount.sh
> > > @@ -0,0 +1,95 @@
> > > +#!/bin/sh
> > > +# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
> > > +# ex: ts=8 sw=4 sts=4 et filetype=sh
> > > +
> > > +# Licensed under the GPLv2
> > > +#
> > > +# Copyright (C) 2011 Politecnico di Torino, Italy
> > > +#                    TORSEC group -- http://security.polito.it
> > > +# Roberto Sassu <roberto.sassu-8RLafaVCWuNeoWH0uzbU5w@public.gmane.org>
> > > +
> > > +ECRYPTFSCONFIG="${NEWROOT}/etc/sysconfig/ecryptfs"
> > > +ECRYPTFSKEYTYPE="encrypted"
> > > +ECRYPTFSKEYDESC="1000100010001000"
> > > +ECRYPTFSKEYID=""
> > > +ECRYPTFSDIR="/secret"
> > > +ECRYPTFS_EXTRA_MOUNT_OPTS="ecryptfs_cipher=aes,ecryptfs_key_bytes=32"
> > 
> > The default in both eCryptfs mount helpers is
> > "ecryptfs_cipher=aes,ecryptfs_key_bytes=16"
> > 
> > I'd prefer that you didn't bump the ecryptfs_key_bytes default up to 32
> > here.
> > 
> > > +
> > > +load_ecryptfs_key()
> > > +{
> > > +    # override the eCryptfs key path name from the 'ecryptfskey=' parameter in the kernel
> > > +    # command line
> > > +    ECRYPTFSKEYARG=$(getarg ecryptfskey=)
> > > +    [ $? -eq 0 ] && \
> > > +        ECRYPTFSKEY=$ECRYPTFSKEYARG
> > > +
> > > +    # set the default value
> > > +    [ -z "$ECRYPTFSKEY" ] && \
> > > +        ECRYPTFSKEY="/etc/keys/ecryptfs-trusted.blob";
> > > +
> > > +    # set the eCryptfs key path name
> > > +    ECRYPTFSKEYPATH="${NEWROOT}${ECRYPTFSKEY}"
> > > +
> > > +    # check for eCryptfs encrypted key's existence
> > > +    if [ ! -f "${ECRYPTFSKEYPATH}" ]; then
> > > +        if [ "${RD_DEBUG}" = "yes" ]; then
> > > +            info "eCryptfs: missing the eCryptfs key: ${ECRYPTFSKEYDESC}"
> > 
> > This debug message seems potentially confusing. How about something
> > along the lines of, "eCryptfs: key file not found: ${ECRYPTFSKEYPATH}"?
> > 
> > Tyler
> > 
> > > +        fi
> > > +        return 1
> > > +    fi
> > > +
> > > +    # read the eCryptfs encrypted key blob
> > > +    KEYBLOB=$(cat ${ECRYPTFSKEYPATH})
> > > +
> > > +    # load the eCryptfs encrypted key blob
> > > +    ECRYPTFSKEYID=`keyctl add ${ECRYPTFSKEYTYPE} ${ECRYPTFSKEYDESC} "load ${KEYBLOB}" @u`
> > > +    [ $? -eq 0 ] || {
> > > +        info "eCryptfs: failed to load the eCryptfs key: ${ECRYPTFSKEYDESC}";
> > > +        return 1;
> > > +    }
> > > +
> > > +    return 0
> > > +}
> > > +
> > > +unload_ecryptfs_key()
> > > +{
> > > +    # unlink the eCryptfs encrypted key
> > > +    keyctl unlink ${ECRYPTFSKEYID} @u || {
> > > +        info "eCryptfs: failed to unlink the eCryptfs key: ${ECRYPTFSKEYDESC}";
> > > +        return 1;
> > > +    }
> > > +
> > > +    return 0
> > > +}
> > > +
> > > +mount_ecryptfs()
> > > +{
> > > +    # read the configuration from the config file
> > > +    [ -f "${ECRYPTFSCONFIG}" ] && \
> > > +        . ${ECRYPTFSCONFIG}
> > > +
> > > +    # load the eCryptfs encrypted key
> > > +    load_ecryptfs_key || return 1
> > > +
> > > +    # set the eCryptfs filesystem mount point
> > > +    ECRYPTFSMNT="${NEWROOT}${ECRYPTFSDIR}"
> > > +
> > > +    # build the mount options variable
> > > +    ECRYPTFS_MOUNT_OPTS="ecryptfs_sig=${ECRYPTFSKEYDESC}"
> > > +    [ ! -z ${ECRYPTFS_EXTRA_MOUNT_OPTS} ] && \
> > > +        ECRYPTFS_MOUNT_OPTS="${ECRYPTFS_MOUNT_OPTS},${ECRYPTFS_EXTRA_MOUNT_OPTS}"
> > > +
> > > +    # mount the eCryptfs filesystem
> > > +    info "Mounting the configured eCryptfs filesystem"
> > > +    mount -i -t ecryptfs -o${ECRYPTFS_MOUNT_OPTS} ${ECRYPTFSMNT} ${ECRYPTFSMNT} >/dev/null || {
> > > +        info "eCryptfs: mount of the eCryptfs filesystem failed";
> > > +        return 1;
> > > +    }
> > > +
> > > +    # unload the eCryptfs encrypted key
> > > +    unload_ecryptfs_key || return 1
> > > +
> > > +    return 0
> > > +}
> > > +
> > > +mount_ecryptfs
> > > diff --git a/modules.d/98ecryptfs/module-setup.sh b/modules.d/98ecryptfs/module-setup.sh
> > > new file mode 100755
> > > index 0000000..56c2d41
> > > --- /dev/null
> > > +++ b/modules.d/98ecryptfs/module-setup.sh
> > > @@ -0,0 +1,20 @@
> > > +#!/bin/bash
> > > +# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
> > > +# ex: ts=8 sw=4 sts=4 et filetype=sh
> > > +
> > > +check() {
> > > +    return 0
> > > +}
> > > +
> > > +depends() {
> > > +    echo masterkey
> > > +    return 0
> > > +}
> > > +
> > > +installkernel() {
> > > +    instmods ecryptfs
> > > +}
> > > +
> > > +install() {
> > > +    inst_hook pre-pivot 63 "$moddir/ecryptfs-mount.sh"
> > > +}
> > 
> > 
> > 
