From: Roberto Sassu <roberto.sassu@polito.it>
Subject: Re: [PATCH 2/2] main: added support for loading IMA
 custom policies
Date: Wed, 15 Feb 2012 17:26:18 +0100
Message-ID: <4F3BDCAA.7040001@polito.it>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
	<1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
	<CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces+gcssd-systemd-devel=m.gmane.org@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=sender:message-id:date:from:organization:user-agent:mime-version:to
	:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding;
	bh=z/eWMD9r9kMs8j2G4W9uU8e/b1sgfgBbhHIc4YtNtOQ=;
	b=bcAHeDIEnyyA5VdgIST5ZbOQole2CDZagJQNDjz/1x5JtRKXYBeKbEGD2BIzxLQeZX
	wWUxjxt1bpupAM1fYpSN3TtEOepC2i2HdIGj6k3RQcnjqQlaO+EWMsrH0eAEoafOHqHr
	RqdWzqbQVYRPoKwj8fnuJrFjbdYhIOlRx5H3k=
In-Reply-To: <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
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
To: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
Cc: initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, mzerqung@0pointer.de, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On 02/15/2012 03:30 PM, Gustavo Sverzut Barbieri wrote:
> On Wed, Feb 15, 2012 at 11:23 AM, Roberto Sassu<roberto.sassu@polito.it>  wrote:
>> The new function ima_setup() loads an IMA custom policy from a file in the
>> default location '/etc/sysconfig/ima-policy', if present, and writes it to
>
> isn't /etc/sysconfig too specific to Fedora?
>

Hi Gustavo

probably yes. I see the code in 'src/locale-setup.c' where the
the configuration directory depends on the target distribution.
I can implement something like that in my patch.


> Also, I certainly have no such things in my system and see no point in
> calling ima_setup() on it. Or even compiling the source file in such
> case.
>

Ok. I can enclose the code in ima-setup.c within an 'ifdef HAVE_IMA'
statement, as it happens for SELinux. However an issue is that there is 
no a specific package for IMA that can be checked to set the HAVE_IMA
definition to yes. Instead, the code can be enabled for example by
adding the parameter '--enable_ima' in the configure script.

Regards

Roberto Sassu
