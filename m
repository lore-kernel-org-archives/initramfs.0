From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Re: [dracut] Loading of modules that don't have a uevent or pci
	device: ideas?
Date: Wed, 13 Jan 2010 08:39:11 +0100
Message-ID: <20100113073911.GB13730@maude.comedia.it>
References: <20091221212600.GA7132@phenom.dumpdata.com> <4B30D79F.9080506@redhat.com> <20091222152221.GC2785@phenom.dumpdata.com> <4B4B465E.4000308@suse.de>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=comedia.it; h=
	user-agent:in-reply-to:content-disposition:content-type
	:mime-version:references:message-id:subject:from:date:received:
	x-virus-scanned; s=200808; t=1263368351; bh=dL8m+1xIFnnYE4ipl429
	fNY5XLSI2ZPA2c9R5vOuNNM=; b=ZiDaxi7hY8F5BO1rp/xc98R6eRQBjZn4X/8J
	I8tzaqvpQMetUEshINMnfkjsk4J+AiNFM6n81p01a6B5T3VwKu4KgGcEUYMqzkmh
	ct09wZeksOdRnBXlHNaXPFB3dlQ8r5lAd3YHqXZ4iEPG7mDNwuf+UDF0+mFb7I4f
	ShgdYrQ=
Content-Disposition: inline
In-Reply-To: <4B4B465E.4000308-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jan 11, 2010 at 04:40:14PM +0100, Hannes Reinecke wrote:
>
>Konrad Rzeszutek Wilk wrote:
>>>> b) Or utilize xen-detect and load the appropiate modules if we are
>>>> running in Xen PV land. The second is by far much simpler but I don't
>>>> know if more appropiate. I am attaching an example patch to demonstrate
>>>> what I had in mind. (Caveat: I didn't include the pre-requisite for
>>>> xen-tools yet).
>>>>
>>>> c). Another way? Any ideas would be much appreciated.
>>>>
>>> I would favor "modalias" files in /sys, which will be used to modprobe 
>>> the modules with the modalias.
>>> Have a look at this:
>>> $ find /sys -name modalias
>> 
>> I think I did not explain the problem quite well. The modalias values
>> appear after the modules have been loaded. I am at the situation where I am
>> trying to figure out if I should load the modules or not - so the modalias
>> values are not present.
>> 
>D'oh.
>
>But that's exactly the wrong way round.
>The sole reason for having a modalias attribute (in the device) is to facilitate
>module autoloading.
>If the modalias attribute appears _after_ the module has been loaded you might
>want to redesign the module ...

Actually the whole module directory appears _after_ the module is
loaded.

>> The one option that exists right now to detect whether we are running
>> under Xen is to use 'xen-detect', which I think you are OK with?
>> 
>>> I am sure this could be automated in the kernel without the need of extra 
>>> special xen handling with scripts.
>>>
>>>> +xen-detect
>>>> +RC=$?
>>>> +if [ "$RC" = "1" ] ; then
>>> why not?
>>>
>>> if xen-detect ; then ...; fi
>> 
>> Ooh, the patches I've for xen-detect return three different return values.
>> 1 for PV Xen, 2 for HVM Xen, and 0 if no Xen.
>> 
>> Also xen-detect prints this out (depending on the scenario):
>> 
>> Running in HVM context on Xen v4.0.
>> Running in PV context on Xen v4.0.
>> Not running on Xen.
>> 
>> And it looks that 'if xen-detect', the if clause takes under consideration
>> the output - which means that on machines not running Xen it would still jump in the
>> "then" clause.

"if xen-detect" looks at the return code of xen-detect
so it should be
if ! xen-detect; then echo we are running xen;else echo no xen;done

>> I think I am going to modify the xen-detect to accept another flag that would
>> just print a string if it is running in a PV context and nothing else- that
>> should make it easier.
Please don't. return code are much better to parse than text strings

>Easiest bit would be if there were some bits of (virtual) devices, to which the Xen
>drivers could attach to. Doesn't Xen already provide something here?
>
>What does xen-detect do?
>If it's just looking at some sysfs attributes then we can easily build up a udev rule.



-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \
