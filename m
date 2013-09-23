From: The Lee-Man <leeman.duncan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration
 effort
Date: Mon, 23 Sep 2013 10:40:11 -0700 (PDT)
Message-ID: <13ac33d7-4a9f-4a1f-aeff-dcc753ef6892@googlegroups.com>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
 <50C67697.7020208@gmail.com>
 <20121211232646.GC5307@straylight.hirudinean.org>
 <b993ef26-ea4e-4dbe-8d9a-d86ad50c9fbc@googlegroups.com>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3890_25296603.1379958011015"
Return-path: <open-iscsi+bncBC755V5RXMKBB7PZQGJAKGQEMUS5F3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Pd9YZTgM5bPu41nhfSLIDOMD4JBbse6Z6e6TeERkPkk=;
        b=eCsRvz2eycRFHdzOLGBx+NCsNw6mFB5UzUBV3qXvyOBbiWBq7BKty/VOPlIqcFLrGn
         df1e6pJqD86fCVAZPVo4TmkcIKgemF4xX/wCNTRTcTxi1kuG6s5MASzsPoSijKExXtgo
         f8xdn65DH5rlIpfqtzzMcilZ8l0XfXHXMH9ixImZAZlkJ6oomsIwMakinC/MLWz0t5lR
         jaPoSI+iva2q+z04+hy/AjPLF4XrHSQddgpuUA7UwJS7MVbyh3Y6GZXst6ik0b2juHnT
         wZ1pQqhuUDwFoorkjUDiagyS/g9h7DXdfN1lvXQZzGYHSCgBRGZDkunXUD4aAIgW+6Wl
         IPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Pd9YZTgM5bPu41nhfSLIDOMD4JBbse6Z6e6TeERkPkk=;
        b=K0DJX7SGOCWkJpgxVFy1pmzzM+bvay7TM0YdkbY0BxQsQwmiwlJTUOFh7Y6954wkAj
         PlaaSF16oPzdk+LB7+SgKy0l0bedePCAL+MiQKN8gdZPyIXj4jpADVF8EWQpMUI2VZHe
         9i3Y22Suvoijaiy/XRrVrvgwxJMX+l3SZgJb0TT8+nFsaK5/ThtJHNcJeew5Ipld6+8l
         b7rHiosePWueum8omROXbHrIVIatNmLP6hutouDZl41d0aorqwtWJ3e+s7DDkpGHJ2Hu
         ut3vx7HqPxbm3Cezs7kUVqZy/i57aIPnJqIyFUnTj3/eMAtzgGWPllswv2V5h9IeZ8bq
         w86g==
In-Reply-To: <b993ef26-ea4e-4dbe-8d9a-d86ad50c9fbc-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-ID: <initramfs.vger.kernel.org>
List-Post: <http://groups.google.com/group/open-iscsi/post>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/open-iscsi>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/open-iscsi/subscribe>, <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/open-iscsi/subscribe>, <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: =?UTF-8?Q?J=C3=B3hann_B=2E_Gu=C3=B0mundsson?= <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

------=_Part_3890_25296603.1379958011015
Content-Type: text/plain; charset=ISO-8859-1

On Monday, September 23, 2013 10:33:36 AM UTC-7, The Lee-Man wrote:
>
> ...
> I just wanted to post a thank you for all of this work, as I was 
> attempting to do some of it myself and making slow progress.
>
> ...
>


Wanted to mention I also had to port back a couple of systemd-support 
patches for iscsid scoket use, as well.

-- 
You received this message because you are subscribed to the Google Groups "open-iscsi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
Visit this group at http://groups.google.com/group/open-iscsi.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_3890_25296603.1379958011015
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Monday, September 23, 2013 10:33:36 AM UTC-7, The Lee-M=
an wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: =
0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr">...<=
br><div>I just wanted to post a thank you for all of this work, as I was at=
tempting to do some of it myself and making slow progress.<br><br>...<br></=
div></div></blockquote><div><br><br>Wanted to mention I also had to port ba=
ck a couple of systemd-support patches for iscsid scoket use, as well.<br><=
/div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;open-iscsi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To post to this group, send email to open-iscsi-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
Visit this group at <a href=3D"http://groups.google.com/group/open-iscsi">h=
ttp://groups.google.com/group/open-iscsi</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_3890_25296603.1379958011015--
