From: "Carl D. Roth" <roth-xf5kL+kFV/5eoWH0uzbU5w@public.gmane.org>
Subject: Re: AOE (ATA over Ethernet) boot support?
Date: Fri, 4 Feb 2011 22:49:17 +0000 (UTC)
Message-ID: <iihvpc$hu6$1@dough.gmane.org>
References: <ihpndo$kvk$1@dough.gmane.org> <4D415151.1020600@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 27 Jan 2011 12:04:49 +0100, Harald Hoyer wrote:

> Am 26.01.2011 18:59, schrieb Carl D. Roth:
>> Is anyone working on this?  I have some homebrewed dracut modules to
>> accomplish this and didn't want to duplicate any effort.
>> 
>> Thanks!
>> C

> 
> Care to share it? Haven't heard of anyone doing it.

Here's a first draft at AOE support in dracut.  Sorry for the kludgy 
posting method, I'm not sure what the best way is to contribute files 
here.

http://dl.dropbox.com/u/18000815/dracut/95aoe/aoeroot
http://dl.dropbox.com/u/18000815/dracut/95aoe/check
http://dl.dropbox.com/u/18000815/dracut/95aoe/install
http://dl.dropbox.com/u/18000815/dracut/95aoe/installkernel
http://dl.dropbox.com/u/18000815/dracut/95aoe/parse-aoeroot.sh

C
