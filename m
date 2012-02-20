From: Lennart Poettering <lennart@poettering.net>
Subject: Re: [systemd-devel] [PATCH 2/2] main: added support for loading
 IMA  custom policies
Date: Mon, 20 Feb 2012 18:14:46 +0100
Message-ID: <20120220171446.GD26356@tango.0pointer.de>
References: <1329312229-11856-1-git-send-email-roberto.sassu@polito.it>
 <1329312229-11856-2-git-send-email-roberto.sassu@polito.it>
 <CAPdpN3DjJ05z7xKa1oTt2NQt9Gy2bDFBJ2qMk3pj27bQFrQw5w@mail.gmail.com>
 <4F3BDCAA.7040001@polito.it>
 <CAPdpN3C0xDeVBrbDxesPdEV+owf-q_wxUHTmr4YDCHw=NgPV1Q@mail.gmail.com>
 <4F3BE763.9060704@polito.it>
Mime-Version: 1.0
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F3BE763.9060704@polito.it>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: Gustavo Sverzut Barbieri <barbieri@profusion.mobi>, initramfs@vger.kernel.org, systemd-devel@lists.freedesktop.org, linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org, zohar@linux.vnet.ibm.com, harald@redhat.com, ramunno@polito.it

On Wed, 15.02.12 18:12, Roberto Sassu (roberto.sassu@polito.it) wrote:

> The location of the policy file is not IMA dependent. I chose that
> because it seemed to me the right place where to put this file.
> So, i can easily modify the location to be distribution independent
> but i don't known which directory would be appropriate.
> Any proposal?

/etc/ima.conf or /etc/ima/ima.conf sound like obvious candidates.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
