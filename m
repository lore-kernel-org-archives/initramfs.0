From: Tomasz Torcz <tomek-e+FrjxkDqoI/dUmziOgvOQ@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration
 effort
Date: Wed, 12 Dec 2012 21:45:46 +0100
Message-ID: <20121212204545.GA23313@mother.jarsat.pl>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
 <50C67697.7020208@gmail.com>
 <20121211232646.GC5307@straylight.hirudinean.org>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Return-path: <open-iscsi+bncBDRLB3EU6IJRB66ZUODAKGQEFLKBH7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-disposition;
        bh=F1EdJcfeqGc7Vrry5M+FGD6fs4t5SNMPdoX4fgqrlSM=;
        b=Z+Oezb1V4CTdBlFSp2YdRLwfx5ABgA5sUvjMStAPGYWUyzPx58oyngSGfCdjG3fzrW
         sE7gCmjKUyFBd43lKe76rKnHtRRuYaCybOrHzTlYm6Jt5efJuwYOIX/1+XSE0pUMyxa/
         D1pDA+1FpNQgfUtfjm2qI/ZrF0LRYTnd3y5+sH8hx2Ru+OTGb/VBklwLWINKkO2DQC/K
         dEW2HyNdm4CalG8wXGOzUfBCz/z7L4GiN/XrEfL6mMTKmWfbFYOUzhZZDD1CySfcI7Fi
         RVhR5x/ujUBoD8dMExqW3asihP4a 
In-Reply-To: <20121211232646.GC5307-r8IHplWLGbA5tHQWs+pTeqPFFGjUI2lm2LY78lusg7I@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post?hl=en_US>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi?hl=en_US>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?utf-8?B?IkrDs2hhbm4gQi4gR3XDsG11bmRzc29uIg==?= <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Tue, Dec 11, 2012 at 03:26:46PM -0800, Chris Leech wrote:
> Thanks, this got me going in the right direction.  These unit files
> seems to be working much better for me, with the startup and shutdown
> ordering between iscsi, iscsid, and remote-fs mounts sorted out.  I'm
> not sure about the tgtd/targetcli stuff, not sure what the original need
> there was.

  "After tgtd" was added in Fedora for cases when system accesses targets
exported by the same system. So targets would be configured first, and
only then accessed by iscsid.  "after tgtd" was added, "after targetcli" is natural
expansion of it.

-- 
Tomasz Torcz                 Morality must always be based on practicality.
xmpp: zdzichubg-veJsmC5npURmR6Xm/wNWPw@public.gmane.org                -- Baron Vladimir Harkonnen

-- 
You received this message because you are subscribed to the Google Groups "open-iscsi" group.
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/open-iscsi?hl=en.

