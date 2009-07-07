From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [RFC ONLY 5/5] PROOF-OF-CONCEPT: wait for spanning tree
 timeout via arping
Date: Tue, 07 Jul 2009 11:09:32 -0400
Message-ID: <1246979372.22613.30.camel@obelisk.thedillows.org>
References: <cover.1246656269.git.dave@thedillows.org>
	 <8cf3d034e4611fbe661d4585fbfd1a03a6fd094b.1246656269.git.dave@thedillows.org>
	 <4A530297.1020906@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A530297.1020906-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2009-07-07 at 10:08 +0200, Seewer Philippe wrote:
> David Dillow wrote:
> > +    echo mynet=$ip/$mask > /tmp/net.$netif.up
> > +
> 
> Please don't do this. $ip/$mask is in .override so we don't need
> more variables.

This is why it is proof-of-concept, I don't like $mynet either. But, not
having it means that we have to parse both .override and .dhcpopts and
figure out which one applies in this case.

I think the real solution is to not use scriptlets in the net.$netif.up
files and move to a /tmp/net.$netif.cfg that has all the variables we
need for configuration, which we can then source. This gets rid of the
$netif.gw and $netif.hostname files as well, since we can pick the one
we want in netroot then.



> > +# FIXME make 120 configurable
> > +TIMEOUT=$(( $(date +%s) + 120 ))
> 
> Is 120 seconds really necessary? I've worked with 60 seconds and haven't
> had any problems, even when specifically provoking STP with ip down/up 
> before issuing arping.

Someone said that the STP timeout could be up to 100 seconds, so I added
a bit for safety. If I made it configurable, we could default to
something like 45-60 seconds and those that run a larger blocking time
could bump it up.

> Something else: If we really have to use 120 seconds and/or do this on 
> multiple interface we might run into the default udev event timeout of 
> 180 seconds. Netroot should be moved into the new initqueue in that case.
> 
> > +while [ -z "$proceed" -a $(date +%s) -lt $TIMEOUT ]; do
> > +    for iface in $IFACES; do
> > +	arping -q -f -c 1 -I $iface $target && proceed=1 && break
> > +    done
> > +done
> 
> Just so that I understand you correctly: You're trying to arping on all
> interfaces until one says OK? 
> 
> If we have multiple interface to up before mount/login, we should take care 
> to try and enable all interfaces:

Good point.

> > +if [ -n "$proceed" ]; then
> >      warn "Mounting root via '$netif' failed"
> > -    # If we're trying with multiple interfaces, put that one down.
> > -    # ip down/flush ensures that routeing info goes away as well
> > -    if [ -z "$BOOTDEV" ] ; then
> > -	ip link set $netif down
> > -	ip addr flush dev $netif
> > -	echo "#empty" > /etc/resolv.conf
> > -    fi
> > +else
> > +    warn "Unable to ARP ping $target via $netif"
> > +fi
> > +
> > +# If we're trying with multiple interfaces, put that one down.
> > +# ip down/flush ensures that routeing info goes away as well
> > +if [ -z "$BOOTDEV" ] ; then
> > +    ip link set $netif down
> > +    ip addr flush dev $netif
> > +    echo "#empty" > /etc/resolv.conf
> >  fi
> >  exit 0
> 
> I'd suggest to move [ -n "$proceed" ] to before mount/login and just do 
> [ -z "$proceed" ] && die "..."
> 
> that way loose the if/else.

But then you leave the interface configured.

Thanks for reviewing and the good comments on this series.

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
