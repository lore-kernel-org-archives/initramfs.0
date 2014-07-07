From: <Praveen_Paladugu-DYMqY+WieiM@public.gmane.org>
Subject: RE: Installing an OS with VLAN enabled to an ISCSI LUN (from ibft)
Date: Mon, 7 Jul 2014 15:34:58 -0500
Message-ID: <ABF506AF5815F54BB6579628C0CD9F995687F54356@AUSX7MCPS310.AMER.DELL.COM>
References: <ABF506AF5815F54BB6579628C0CD9F9956345880E3@AUSX7MCPS310.AMER.DELL.COM>
 <53B549C5.50500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53B549C5.50500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


With the current version of Dracut, the below command for all the cases: with vlan populated/not, numerical/not, zero/non-zero.
echo $mac > /tmp/net.${dev}.has_ibft_config



The intent of the patch was to run the below command for all the cases, except when there is a valid numerical vlan detected. 
echo $mac > /tmp/net.${vlan}.has_ibft_config. As long as that happens, I am fine.


Not sure how/why vlan 0 has to be handled differently. 


Thank you
Praveen K Paladugu
Dell Linux Engineering
