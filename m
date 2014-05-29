From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] network: add static route support
Date: Thu, 29 May 2014 14:20:59 +0800
Message-ID: <20140529062059.GH2068@darkstar.nay.redhat.com>
References: <1398678111-13601-1-git-send-email-bhe@redhat.com>
 <1398678111-13601-2-git-send-email-bhe@redhat.com>
 <20140505071214.GA24097@dhcp-16-116.nay.redhat.com>
 <20140522073359.GD1859@darkstar.nay.redhat.com>
 <20140527062512.GA1951@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140527062512.GA1951-je1gSBvt1Tcx0jIIkfS+Ph/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mmilgram-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On 05/27/14 at 02:25pm, Baoquan He wrote:
> On 05/22/14 at 03:33pm, Dave Young wrote:
> > On 05/05/14 at 03:12pm, Baoquan He wrote:
> 
> > Hi, Baoquan
> > 
> > The route-$netif is supposed in 1st kernel filesystem. Can we passing the
> > detail ip/netmask/gw for specific nic in kernel cmdline instead of copy
> > the route file in initramfs? In that way we can avoid this dracut fix.
> > 
> > I'm not sure if it works for the complicate route setup though.
> 
> I am not sure, it had better handle the route during setup net. I want
> to hear what Harald will say. He is more familiar with this.

Ok, the route table item must be a line like "192.168.100.1 via 127.0.0.1 dev lo  metric 203"

If passing them via cmdline we need quote it with some special character and append
it to the ip= cmdline param

The other way is copy the route file to /etc/ in initramfs like you are doing.
But we did need the functions to handle the static route.

So leave to Harald about the interface. 
> 
> 
> > 
> > > +    if [ -e "$f" ]; then
> > > +        if grep -Eq '^[[:space:]]*ADDRESS[0-9]+=' $f ; then
> > > +            handle_file $f $netif
> > > +        else
> > > +            handle_ip_file $f
> > > +        fi
> > > +    fi
> > > +
> > >      # Handle STP Timeout: arping the default gateway.
> > >      # (or the root server, if a) it's local or b) there's no gateway.)
> > >      # Note: This assumes that if no router is present the
> > > @@ -517,6 +527,35 @@ find_iface_with_link() {
> > >      return 1
> > >  }
> > >  
> > > +handle_file () {
> > > +    . $1
> > > +    routenum=0
> > > +    while [ "x$(eval echo '$'ADDRESS$routenum)x" != "xx" ]; do
> > > +        eval $(ipcalc -p $(eval echo '$'ADDRESS$routenum) $(eval echo '$'NETMASK$routenum))
> > > +        line="$(eval echo '$'ADDRESS$routenum)/$PREFIX"
> > > +        if [ "x$(eval echo '$'GATEWAY$routenum)x" != "xx" ]; then
> > > +            line="$line via $(eval echo '$'GATEWAY$routenum)"
> > > +        fi
> > > +        line="$line dev $2"
> > > +        /sbin/ip route add $line
> > > +        routenum=$(($routenum+1))
> > > +    done
> > > +}
> > > +
> > > +handle_ip_file() {
> > > +    local f t type= file=$1 proto="-4"
> > > +    f=${file##*/}
> > > +    t=${f%%-*}
> > > +    type=${t%%6}
> > > +    if [ "$type" != "$t" ]; then
> > > +        proto="-6"
> > > +    fi
> > > +
> > > +    while read line; do
> > > +        /sbin/ip $proto $type add $line
> > > +    done < $file
> > > +}
> > > +
> > >  is_persistent_ethernet_name() {
> > >      case "$1" in
> > >          # udev persistent interface names
> > > -- 
> > > 1.9.0
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe initramfs" in
> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe initramfs" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
