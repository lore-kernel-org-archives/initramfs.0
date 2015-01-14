From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 6/9] gen_initramfs_list.sh: include xattrs
Date: Wed, 14 Jan 2015 08:23:54 -0500
Message-ID: <1421241834.11716.11.camel@dhcp-9-2-203-236.watson.ibm.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1420663980-20842-7-git-send-email-zohar@linux.vnet.ibm.com>
	 <CA+5PVA77x2W9LyHMq1jSW3HKqNgFPz-gPVOH0QtEmmMBwzOx_Q@mail.gmail.com>
	 <1420729994.6338.52.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <54AECA32.6000304@landley.net>
	 <1420754931.6338.95.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <54B56881.30403@landley.net>
	 <1421180416.2119.73.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <54B5913C.5050109@landley.net>
	 <1421205803.2119.110.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <54B5F1C6.7040307@landley.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <54B5F1C6.7040307@landley.net>
Sender: linux-security-module-owner@vger.kernel.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rob Landley <rob@landley.net>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, initramfs <initramfs@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-ima-devel@lists.sourceforge.net, linux-security-module <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fionnuala Gunter <fin@linux.vnet.ibm.com>

On Tue, 2015-01-13 at 22:34 -0600, Rob Landley wrote: 
> 
> On 01/13/2015 09:23 PM, Mimi Zohar wrote:
> > On Tue, 2015-01-13 at 15:42 -0600, Rob Landley wrote:

> Then again if we add a new field right before the previous size then the
> "treat it as 64 bits vs 2 32 bit ones" is an implementation detail
> anyway. And for the moment we can just have it be padding that
> compresses away and wait for an actual >4g file.

Sounds good.

Mimi

