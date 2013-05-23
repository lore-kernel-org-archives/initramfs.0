From: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Subject: Re: why not install selinux with systemd being used
Date: Thu, 23 May 2013 16:45:16 +0100
Message-ID: <knldi6$b78$1@ger.gmane.org>
References: <519C9A2E.2080100@redhat.com> <519C9A7C.7080904@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <519C9A7C.7080904-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

'Twas brillig, and Dave Young at 22/05/13 11:14 did gyre and gimble:
> On 05/22/2013 06:13 PM, Dave Young wrote:
>> Hi, Harald
>>
>> I have a question about selinux module.
>>
>> In dracut.spec there's below code:
>>
>> %if %{defined _unitdir}
>> # with systemd IMA and selinux modules do not make sense
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/96securityfs
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/97masterkey
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98integrity
>> rm -fr $RPM_BUILD_ROOT/%{dracutlibdir}/modules.d/98selinux
>> %endif
>>
>> I'm confused why they are excluded for systemd?
>>
>> And how can we load selinux policy in initramfs without 98selinux now?
>>
>>
> CC Vivek and Baoquan

Harald is on vacation just now I believe.

However, assuming the systemd module is being used in dracut than I
suspect that the selinux support in systemd itself is what will be used
in the initrd to ensure selinux stuff is supported.

(I would reply-all but replying via gmane which mangles email addresses
so I can't easily do so).

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
