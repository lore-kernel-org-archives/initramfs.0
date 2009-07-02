From: Harald Hoyer <harald@redhat.com>
Subject: Re: RFC: writing kernel cmdline options to grub.conf for dracut
Date: Thu, 02 Jul 2009 17:09:31 +0200
Message-ID: <4A4CCDAB.60102@redhat.com>
References: <4A4B4443.50503@redhat.com> <4A4CC19F.9020906@bfh.ch>
Reply-To: Discussion of Development and Customization of the Red Hat Linux
	Installer <anaconda-devel-list@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <anaconda-devel-list-bounces@redhat.com>
In-Reply-To: <4A4CC19F.9020906@bfh.ch>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/anaconda-devel-list>, 
	<mailto:anaconda-devel-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/anaconda-devel-list>
List-Post: <mailto:anaconda-devel-list@redhat.com>
List-Help: <mailto:anaconda-devel-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/anaconda-devel-list>, 
	<mailto:anaconda-devel-list-request@redhat.com?subject=subscribe>
Sender: anaconda-devel-list-bounces@redhat.com
Errors-To: anaconda-devel-list-bounces@redhat.com
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Seewer Philippe <philippe.seewer@bfh.ch>
Cc: initramfs@vger.kernel.org, Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list@redhat.com>

On 07/02/2009 04:18 PM, Seewer Philippe wrote:
> Hans de Goede wrote:
>> 3) chmod /proc/cmdline 400, so that it cannot be read by ordinary
>> users, plugging
>> the passwork leak problem
>
> This does not really plug the leak. Just boot until initramfs is loaded,
> pull the network plug and wait until dracut drops us to a (root-)shell.

Ah, which reminds me, that we should have an option to turn that off.

>
>>
>> Now the remaining question is how to implement the adding of the needed
>> cmdline options to grub.conf.
>
> Question: Is it really necessary to provide username/password to dracut?
> Wouldn't it be better to ask the user? I mean if a mount is password
> protected, be it cryptroot, nfs4 or whatever, shouldn't the user enter
> the data?
>

username/password for iSCSI disks entered by a normal user every day he boots 
his diskless client?
