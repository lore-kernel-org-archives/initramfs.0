Received: from mail2.eggplant.pro (mail2.eggplant.pro [172.232.2.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942E2989B5
	for <initramfs@vger.kernel.org>; Sat, 11 Jul 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.232.2.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783789513; cv=none; b=ijWNhhv/5amL/44FVyFrNyVS4qT2GNpmlvHeedhZKYKzeg7Umz30/fLX9Oy0ApAjaRAtVOng3OV+yueqnnFQ1YMzkl8Tgtg+UHkaReLaGM5DCVZb7MD76CAkVFev1reVW3EjgXijaKGwgUcVemv5ecFL/5IFZFwdkykzGdYD2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783789513; c=relaxed/simple;
	bh=RhkAgvSh+x9kPGALnwm1PxRf+UVDNCo0EsAFEL4F2hQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YYQ++25wp+Y7y08OgYseocidhOSaY30017lPJr1D/We4+UNDhgp8Hs2v+pbfSQfuZKgM0nU47NpyjlJDLDu+IWSr9LqE4r7611zjK7uHQ5E1tZox0VjAgVM9Xnb531ret3nb5tQO58y0tjZZ8wFz1jwMMT+pv4orhalBIOeVgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eggplantsd.com; spf=pass smtp.mailfrom=eggplantsd.com; dkim=pass (2048-bit key) header.d=eggplantsd.com header.i=@eggplantsd.com header.b=02739YsN; arc=none smtp.client-ip=172.232.2.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eggplantsd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eggplantsd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eggplantsd.com header.i=@eggplantsd.com header.b="02739YsN"
Received: from mail2.eggplant.pro (mail2.eggplant.pro [127.0.0.1])
	by mail2.eggplant.pro (Postfix) with ESMTP id 4gyFSR0f57z3PDj
	for <initramfs@vger.kernel.org>; Sat, 11 Jul 2026 13:05:11 -0400 (EDT)
Authentication-Results: mail2.eggplant.pro (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=eggplantsd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eggplantsd.com;
	 h=content-disposition:content-type:mime-version:message-id
	:subject:to:from:date; s=dkim; t=1783789510; x=1786381511; bh=Rh
	kAgvSh+x9kPGALnwm1PxRf+UVDNCo0EsAFEL4F2hQ=; b=02739YsNVVZgJ39i++
	2bBv4GWmVin8PKzN76+oLH6MYtj2SZN8092y34N/Vnmm4XwoHIEYuhnqyq27W3+p
	4rnFAc92JZYnrgZJ9z5om811NgiHjQQrxyBX3jKvNfpGkdOPO5nrRaIzkQJ2UO95
	qHAlQ5qcg61VpG88HQANJyoBeV1s7OgFRreioW+0esLyERNsB/K7utyTKcCRAnu1
	117FysdHOc8JjIr/fzm3/s9y8suBqNDZRk1psjoE/XmCW3kUS5pbHS0ipqdiTDV6
	r68c3VUGKJfgRvBMk5UVSQXj3wS1vWothb/KrGwJ9l4tK9BH40qC0jnMDFT9ZTUT
	123g==
X-Virus-Scanned: Debian amavis at mail2.eggplant.pro
Received: from mail2.eggplant.pro ([127.0.0.1])
 by mail2.eggplant.pro (mail2.eggplant.pro [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jS4b56LeH-Lo for <initramfs@vger.kernel.org>;
 Sat, 11 Jul 2026 13:05:10 -0400 (EDT)
Received: from newcore.egp2.pro (unknown [IPv6:2603:6013:c900:d5ba:6097:d6ff:fe21:8399])
	by mail2.eggplant.pro (Postfix) with ESMTPSA id 4gyFSQ3nQfz3Mjr
	for <initramfs@vger.kernel.org>; Sat, 11 Jul 2026 13:05:10 -0400 (EDT)
Date: Sat, 11 Jul 2026 13:05:10 -0400
From: Jason Stewart <support@eggplantsd.com>
To: initramfs@vger.kernel.org
Subject: fsck to RAM?
Message-ID: <alJ3xij28IW6tfkS@newcore.egp2.pro>
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Does anyone know what the obstacles are to putting fsck for common 
filesystems into RAM before the rest of fstab is mounted?

I'm dealing with a number of older persons dipping their toes into 
Linux, and whenever there is a power event, they all get the dreaded 
root prompt requesting an fsck on their mounted root partition.  
Everything on the internet points to booting from a live cd/usb, and 
fsck-ing it from there, but that is kinda terrible.  If it were in the 
initramfs, then they could unmount root & do the fsck without having to 
reach for a livecd.

js
