From: Mr Dash Four <mr.dash.four-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] 90crypt: keys on external devices support
Date: Wed, 20 Oct 2010 02:24:35 +0100
Message-ID: <4CBE44D3.6070000@googlemail.com>
References: <4CBDA328.40401@googlemail.com> <1287497223-sup-3606@etiriah> <4CBDAC3D.7050906@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wiiIfVB4qspfM6scypfcp7i6AK3u/qiGYtYiGqJNA0E=;
        b=W/L5Z3UDfEIbQ1SYobp3aedmJINYwpGJ2Xt4NK7C+5K9M0hVRwhPH36tntxtZs3ZHl
         iiFKfuALZ6bIuw+0hjUe2Qgu0i7kQqbqh66DwrrFglNzlXp8xvQdlftYaXGFeeplUJVR
         rKJuu/72FJM8koghKYj3zXktdUMbL7elbTA7Y=
In-Reply-To: <4CBDAC3D.7050906-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

OK, I've had a bit of time to look through the available dracut docs and 
have a couple of queries and a few ideas (below):

1. 'dracut -I' option 'installs' the files specified, but does it 
install all dependencies? For e.g. if I want to install 
'/usr/bin/pkcs11-tool' does it install all other libraries/files on 
which this program depends (i do not mean just .ko files!)?

2. Currently the proposed rd_LUKS_KEYPATH and rd_LUKS_KEYDEV_UUID allow 
me to specify key path and device to look for the key with which to open 
the LUKS-encrypted drive/partition. If I want to open another LUKS disk 
with a different key located in a different path/file how is this 
handled? By specifying another pair of rd_LUKS_KEYDEV_UUID and 
rd_LUKS_KEYPATH?

3. Following from 2 above: if smartcard module/enhancements are going to 
be implemented then there is a possibility that there may be a conflict 
(for example if I want to open drive A with keypath/file and drive B 
with a token - how does dracut know which is which?).

So, I have an idea: instead of using rd_LUKS_UUID, rd_LUKS_KEYDEV_UUID & 
rd_LUKS_KEYPATH (and possibly also rd_LUKS_TOKEN for reading keys from 
tokens) why can't we have one unified and much simpler format:

  a) for LUKS-encrypted drives (file/path keys): 
rd.luks.<luks_uuid>=<keypath_uuid>:<fs>:<path>

For example 
rd.luks.def0269e-424b-4752-acf3-1077bf96ad2c=3de247f3-5de4-4a44-afc5-1fe179750cf7:ext3:/crypto/key_file 
opens LUKS drive with UUID=def0269e-424b-4752-acf3-1077bf96ad2c, using 
key drive UUID 3de247f3-5de4-4a44-afc5-1fe179750cf7, mounting ext3 file 
system and looking for file /crypto/key_file.

  b) for LUKS-encrypted drives (using token keys): 
rd.luks.<luks_uuid>=<reader_id>:<slot_id>:<token_id>:<token_status>

For example rd.luks.def0269e-424b-4752-acf3-1077bf96ad2c=0:0:12:private 
opens LUKS drive with UUID=def0269e-424b-4752-acf3-1077bf96ad2c, reading 
key token using reader=0, slot=0 and looking for token data stored with 
application_id=12, where:
     - reader_id: reader ID to use (not mandatory - if omitted the 
'default' reader is used);
     - slot_id: slot ID to look for when reading the token (it could 
also be omitted in which case the first available slot will be used);
     - token_id: the (application) ID of the token as stored in the 
smartcard;
     - token_status: 'public' if the token is stored in the smartcard as 
'public' (i.e. no PIN login required - similar to the key path scenario 
above); or 'private' if the key token is stored as a private token and 
smartcard PIN is required to read the token data;

What do you think?

My main concern is handling of all dependencies when installing the core 
programs, which are going to do the 'dirty work': pkcs15-tool and 
pkcs11-tool (possibly pkcs15-init also, though this program may have to 
be used in extremely rare circumstances, if at all).

I've looked through the dependencies and the package scripts though 
there are, among other things, udev rules and config files, which could 
complicate matters. Following this I have another query: Does dracut 
have (at least read) access to the /boot partition where the initramfs 
image is?
