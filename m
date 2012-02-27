From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Use modinfo to gather module dependencies
Date: Mon, 27 Feb 2012 13:08:23 +0100
Message-ID: <4F4B7237.6070005@redhat.com>
References: <2369135.eJzU9GBXlg@ernie> <4F4B5A00.2060400@redhat.com> <jifpfl$hof$1@dough.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <jifpfl$hof$1@dough.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 27.02.2012 12:29, schrieb Colin Guthrie:
> 'Twas brillig, and Harald Hoyer at 27/02/12 10:25 did gyre and gimble:
>> Am 25.02.2012 22:09, schrieb Dennis Schridde:
>>> Hello!
>>
>>> I just switched from module-init-tools to kmod and found dracut broken, 
>>> because it uses modprobe --show-depends to find out about module locations
>>> and dependencies, which apparently is not implemented in kmod.
>>
>>> Hence I wrote attached patch, switching from modprobe to modinfo, which
>>> also seem to be the tool intended for the job. This method appears to work
>>> reliable in kmod-5, but I have not tested with module-init-tools.
>>
>>> Kind regards, Dennis
>>
>> You need this patch for kmod:
>>
>> http://git.profusion.mobi/cgit.cgi/kmod.git/commit/?id=269de2e0bf5011072da2f40f4f2d4023fad696b9
> 
> What does this patch add?
> 
> I seem to get modprobe working happily with kmod 5 even for non-loaded
> modules. With patch applied or not, the output was the same.
> 
> I'd just like to understand the issue :)

Have you replaced module-init-tools with kmod? If not, then this problem does
not affect you.
