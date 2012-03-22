From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [PATCH-v4 1/2] systemd: mount the securityfs
 filesystem at early stage
Date: Thu, 22 Mar 2012 09:50:27 +0100
Message-ID: <4F6AE7D3.40102@polito.it>
References: <1331834775-7188-1-git-send-email-roberto.sassu@polito.it>
	<20120321232542.GB14830@tango.0pointer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120321232542.GB14830@tango.0pointer.de>
List-Id: <initramfs.vger.kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>, 
	<mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Errors-To: systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lennart Poettering <lennart@poettering.net>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 03/22/2012 12:25 AM, Lennart Poettering wrote:
> On Thu, 15.03.12 19:06, Roberto Sassu (roberto.sassu@polito.it) wrote:
>
>> The mount of the securityfs filesystem is now performed in the main systemd
>> executable as it is used by IMA to provide the interface for loading custom
>> policies. The unit file 'units/sys-kernel-security.mount' has been removed
>> because it is not longer necessary.
>
> Applied both patches!
>

Hi Lennart

thanks for accepting them!

Regards

Roberto Sassu


> Thanks a lot for your work!
>
> Lennart
>
