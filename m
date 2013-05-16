From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: Unable to boot with encrypted swap
Date: Thu, 16 May 2013 09:17:30 +0100
Message-ID: <kn24ml$2s6$1@ger.gmane.org>
References: <alpine.LFD.2.03.1305141241010.30473@beren.home> <5191AA29.3010107@josephdwagner.info>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5191AA29.3010107-d25e1lPyJDacX41WfeyM6aHonnlKzd3f@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Joseph D. Wagner at 14/05/13 04:06 did gyre and gimble:
> 
> On 05/13/2013 07:43 PM, Michael Chapman wrote:
>> Hello,
>>
>> I am using Fedora 19's dracut-027-45.git20130430.
>>
>> I have what is possibly an unusual configuration: my swap and /home
>> are encrypted, however my root filesystem is not. In /etc/crypttab I
>> have configured LUKS to take the swap volume's password from
>> /dev/urandom; it also has the "swap" flag so that it is mkswap'ed
>> during boot.
>>
>> The problem I am experiencing is that my initramfs hangs waiting for
>> the swap device to appear.
>>
>> As of commit dd5875499ece9dbc90e10eafd0073ee15d0c86a4, it looks like
>> Dracut adds discovered swap partitions to the list of devices to wait
>> for. However since my root filesystem itself is not encrypted, no
>> crypto components are actually installed into the initramfs. The end
>> result is that this volume never appears, and so the initramfs never
>> continues on.
>>
>> I am not sure of the background behind this commit. Is there a real
>> need to wait for swap during initramfs? Won't this just be picked up
>> later by systemd?
>>
>> Should Dracut just skip swap partitions that are encrypted? Or should
>> it detect the existence of an encrypted swap partition and treat it as
>> it would an encrypted root?
>>
>> For now, I've had to revert that commit on my system for it to be able
>> to boot.
>>
>> Regards,
>> Michael
>>
> 
> I'm pretty sure this is needed for resume-from-suspend.  My money is on
> a configuration problem.  I'd be happy to take a look.

Yeah it's almost certainly only for resume from suspend. Sadly this is
controlled by the resume= kernel command line and when the initrd is
generated it doesn't really know if it'll be needed or not.

I think you're right when you say that it should also include the
necessary bits to init swap and it should simply not do that at run time
if no resume= is detected. Sadly such a complex swap setup is likely not
on the radar as of now (will need a few patches).

What I can't understand is why it actually waits. It should timeout can
carry on (I remember writing patches to remove the wait_for_device job
but my memory is fuzzy) if the swap doesn't appear.

It would be interesting to get the /etc/fstab and /etc/cmdline.d/* files
from the initrd itself. Possibly the hooks folder too. That way we can
see exactly what it's waiting for. Assuming there is nothing sensitive
on it, perhaps you can just upload the initrd somewhere?

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
