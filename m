From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: Re: [ANNOUNCE] dracut 034
Date: Tue, 29 Oct 2013 00:40:59 +0400
Message-ID: <1382992859.2678.6.camel@Nokia-N900>
References: <5253DD0C.7050506@redhat.com>	<l4dk8e$fv8$1@ger.gmane.org>
	 <526A7412.8030804@redhat.com> <20131028134216.049c6a01@work.puleglot>
	 <l4lvht$4jh$1@ger.gmane.org> <526E8E99.2020702@redhat.com>
	  <526E93B2.9030408@colin.guthr.ie>
Reply-To: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Content-Transfer-Encoding:Mime-Version:Message-Id:Date:Content-ID:Content-Type:In-Reply-To:References:Subject:To:Reply-To:From; bh=AmoUrhhzI93YuUTvQcY5Scz5D63SGaKlpI00IqlMduw=;
	b=hgLv8yTB4wISntt2q7B8Cf48tfLb0xl2wyMvCLf5JAmoJMvyUIULHsYuzt+1NPSYOXnj7tabcsAif9gqMrnfYenJQXwyVn2FuWBoKwJBqMz4DZhLsVMLGlS55JkPGEQSNiDEJcHf6gQNiq+LBZkGgcl+fRTsnPd560cY4+nqHgo=;
In-Reply-To: <526E93B2.9030408-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>
Content-ID: <1382992859.2678.5.camel@Nokia-N900>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon Oct 28 20:41:22 2013 Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org> wrote:
> Hi,
> 
> 'Twas brillig, and Harald Hoyer at 28/10/13 16:19 did gyre and gimble:
> > On 10/28/2013 04:23 PM, Colin Guthrie wrote:
> > 
> > > That being the case, I would propose that the usrmount module be
> > > automatically included when /usr is a mount point regardless of on
> > > which partition init lives?
> > 
> > Might be the safest option to include it in all non-systemd setups.
> 
> Yeah I didn't actually read Alexander's second email which enumerates
> the possibilities better:
> 
> > Same applies to systemd installed in "/". I think there are only 2
> > cases when usrmount module can be omitted:
> > 1. systemd module is included
> > 2. hostonly + non-separate /usr
> 
> But I guess for 2. it doesn't do much harm including it anyway - it's
> just a bit of a no-op.

I agree. Reverting the commit 1a1c80f would be enough.

> 
> (sorry for not included the original CC's but GMane messes up the email
> addresses - would be nice if someone could ping them to turn the
> obfuscation off)
> 
> Col
> 

-- 
Alexander Tsoy
