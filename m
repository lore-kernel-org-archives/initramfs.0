Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020103.outbound.protection.outlook.com [52.101.69.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072726F292
	for <initramfs@vger.kernel.org>; Fri, 17 Oct 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688626; cv=fail; b=FDLFAxS35ozIh8hI7KS5eXYSHkIRubaqLhqQfOptqK+yq/TAnAmTUPlqmHS9+u64VF4ht0dnHhofiQDseZWTnWkAvgcUBfABRI2UT7vR3Xk4FhvnTT35lPayijn5hMq3R2Ylb2Lm3HWlnXXNHIaXQcSvK0MJ1Tag8G3fvZSntm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688626; c=relaxed/simple;
	bh=SaNpKZMgczsgt0advWBYhhbwZs1v09pY4H9roQkXIR0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UBs24x7UbS81bQDLZzBbZFl1n1kq+pg6vvjwhsuMAZPewD3eUYzS0Ysak0FKDrT1eiPfLpI8KwQlzpW2IUbX+9N8pTK9sNSToIi27wNK5fm1vUxiwR0t8JkzC2qRPfXlZ1EF9cf7J2nm1KnXRik7VqhOt19zWls3aHuN80LoNHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dalco.ch; spf=pass smtp.mailfrom=dalco.ch; dkim=pass (1024-bit key) header.d=dalcoch.onmicrosoft.com header.i=@dalcoch.onmicrosoft.com header.b=epMJsfpM; arc=fail smtp.client-ip=52.101.69.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dalco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dalco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dalcoch.onmicrosoft.com header.i=@dalcoch.onmicrosoft.com header.b="epMJsfpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRLMUF+xoOgKrIoW3bmTUUMEfdayZyRmWXczxhKoU+4SfYMO1QW98ngmXcQORix6zuUDtaAWitcXSxRMqpF6gQbuMXoONFMkyKvZb3Sjvdj2aoCgNYfacDdESqAa91DQHC3hguWhcupMiRVrt+cmy/JpKkny/M+Z6v5Vgr6MUiApcuK9fkDwFus6UVbjFmD4jKmJU0X/Nmj5BLDWIHUabKggakNFg/tbMuBse+OFBi8XJUvomArGrpzeohlzold+z9XaMY59KWSXt39bxrd4GMtuvUFfb+hTxeWUQaytiEd2b79PFzbxAdGZGyCOzps9bsuibRVxoUe5EK6lKBWa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaNpKZMgczsgt0advWBYhhbwZs1v09pY4H9roQkXIR0=;
 b=MQ+81WFf4B6CKvjrWwqTU4FcGXhB+9p0MQKkXrXFKF6/YWYoXrCV5okvVBERiPuNJhIbQAayaqYToC1u2HGYOmH48kmCE/vVY34yIPdQbmbvc/6S4K+bnP/KmuVfFpGz0Ock5p2ptBKq0qBK9V0l0ztiXZnzhK8Rwnj++aPkS7QkzcloxMHBssCN2EQbT4b4Ow7sn284CDZS35IfVvULnPkbVMQpto5c78ykct8Inxsl4E1o5vwNnZEvAENza2LcrjY1U61ct0b4qxeCCPkUMI7yjBDIkIblbD67ChKQR86LxWKoZZbr6v1wvDhmT56RKUk2h8ADlxl/+5jVD180AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.242.140.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=dalco.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=dalco.ch;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dalcoch.onmicrosoft.com; s=selector1-dalcoch-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaNpKZMgczsgt0advWBYhhbwZs1v09pY4H9roQkXIR0=;
 b=epMJsfpMiOqdjEQWlx6zFjSJSTPpoSmXtjWEeHy3bImGZhdNHMZ6yToK0mbaoB+Luu0RJwdVZtxnUA8yK5jomFLTTGgu6KG6ZxUHfww87ZXwJqpOogBia2ETz9YYAZMyCXQUzO9aNl8D5OnxHQyDXMOTLeGWfsj3cnLcfzvfwAw=
Received: from GV0P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::24)
 by AM9P193MB0821.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:10:18 +0000
Received: from GV1PEPF000006FB.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::5d) by GV0P278CA0014.outlook.office365.com
 (2603:10a6:710:26::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.242.140.30)
 smtp.mailfrom=dalco.ch; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=dalco.ch;
Received-SPF: Pass (protection.outlook.com: domain of dalco.ch designates
 195.242.140.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.242.140.30; helo=mail.dalco.ch; pr=C
Received: from mail.dalco.ch (195.242.140.30) by
 GV1PEPF000006FB.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:10:17 +0000
Received: from mail1.corp.dalco.ch (172.16.16.32) by mail1.corp.dalco.ch
 (172.16.16.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 17 Oct
 2025 10:09:50 +0200
Received: from mail1.corp.dalco.ch ([fe80::cfbb:174:8a8b:44ee]) by
 mail1.corp.dalco.ch ([fe80::cfbb:174:8a8b:44ee%7]) with mapi id
 15.02.2562.029; Fri, 17 Oct 2025 10:09:50 +0200
From: Matteo Guglielmi <Matteo.Guglielmi@dalco.ch>
To: "initramfs@vger.kernel.org" <initramfs@vger.kernel.org>
Subject: unsubscribe
Thread-Topic: unsubscribe
Thread-Index: AQHcPz1oR+EJTTr7qECGy3ubhx35sw==
Date: Fri, 17 Oct 2025 08:09:50 +0000
Message-ID: <23d7c43089eb4a259b0b5548ab67ad6e@dalco.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: initramfs@vger.kernel.org
List-Id: <initramfs.vger.kernel.org>
List-Subscribe: <mailto:initramfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:initramfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PEPF000006FB:EE_|AM9P193MB0821:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d2c57e-4119-41a5-8e03-08de0d549ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|4022899009|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?XByMcCYnh7YxdpuEufl/8SlIW0ucrIpWhQ8bYnhgnDqAeTRSx/lfQ7N+ZU?=
 =?iso-8859-1?Q?a2WUnnMM/7tAGxZONNyDZ6MHmaI3p9Y7AV9vGxPt/VbFjSnHOXbgumsJbW?=
 =?iso-8859-1?Q?/pgpyvOvEJqaUAQbGoVbXCFyKN/L2TPYKsTlRCQ6WJimY5x3XSHVGsxDq3?=
 =?iso-8859-1?Q?WktXKH7nVIRjmfZmuMChiO4PdaRRQUjx37kIV17Fyp8Uf4M3pxLccUwXfd?=
 =?iso-8859-1?Q?pplH66fdu3Etq0yqwRbyxqJW+iJjaWONlk5HGS2sEnIs9jAlTXAxXigeEx?=
 =?iso-8859-1?Q?OMkfDN9yGbb4oahPGHXAX67S3Swn+G065dJqBOxwrB3kq8TV2qBvGCyeWw?=
 =?iso-8859-1?Q?bnBxS7g/7DGOiy6blNcFGF6Ti+P+Nv3YHhqpgkCU05l1qL4kBXmOjGp/mP?=
 =?iso-8859-1?Q?Yqzk5GbMI0W7TGF7HQA9FPPTA4R6ljNn8VK3NEDWXkZ3eSZbQkIX0w6gLg?=
 =?iso-8859-1?Q?eipw41X0o2QMPed8UwKdTqDlDyfQmYE2R/bL1SgMSTtILpgD4RDBrPl0Y6?=
 =?iso-8859-1?Q?qO/9178jWo1GseDOF7kX2nUGYFATtcgL0CjYFy+rpF9ZxQGM2L0oK85UKb?=
 =?iso-8859-1?Q?1fwSfAof3MQJhBIfbSBz1AK7hkFmb7o1WhPBu3EdKp6lXVNYqFjIJQSHfv?=
 =?iso-8859-1?Q?i7QOYPAGVhClxruzHm24vKIBqMmZcspK9b8W85wNJx1mGIfhnc75ua8OI1?=
 =?iso-8859-1?Q?/TQwlPYNBBggzCbHUbaExhRD++39FGwQu7Zv6+HE5//pKPI1426MBBEmbr?=
 =?iso-8859-1?Q?XmWQTdebCaBpmMQD1Fvy3TkwQY2QsNLKe1DJHIbuCtTLyZWmQhF55i5HZ/?=
 =?iso-8859-1?Q?Qoh1QmooJdP8i+lfPtLKn7vmm6RJ+73noJoY05xQBip4CerEd5rd5xuTiZ?=
 =?iso-8859-1?Q?nIx8cZL99t0AdzbmdKLj/hiR0uHUCMiwOtITQl7WP7ZhOSSsvmWJov6rYg?=
 =?iso-8859-1?Q?QY3CLX4j7ZQphTRqv0etGVNbrkVgjaEHyuyRmopueOQ/pJ4c+gw1s6CRlS?=
 =?iso-8859-1?Q?WPKoJ/vuhJlWewr+S4NA2avVmCI2y61RwyZVScgUdrmENr51rEu7NcnPbQ?=
 =?iso-8859-1?Q?P1VeJkwD1yABAzp7R82a45FQVYaeAE0Ngqk7KJno23Q6m7uTllC4GqVs74?=
 =?iso-8859-1?Q?gXz9Uwt2HjF5ZmSgDVuU02+yVkOlreczY8tj/9gFe5rCksJk8KMGb/mjrh?=
 =?iso-8859-1?Q?OZ8b2lXLbTmy2FNhupUURzizPYcWr5OrFWsQv93TrgF9CSWo0B/L+rzXS7?=
 =?iso-8859-1?Q?+R58DkxcIOFtgRs/EOml6N92dnYsxzLwu0wvJe29jLjg9Icl5/1iSzOi0r?=
 =?iso-8859-1?Q?YDY/hnPDsygpTcAm5sbIAZr7cQX9F2WV+XGkrKbnnkqEqAA9C1+u8lk6yi?=
 =?iso-8859-1?Q?Xi+RAMNFN/IolW/lcICDboU9wd13LQik33zL+wceUYf7b17+dKtPZI+fcx?=
 =?iso-8859-1?Q?KDDyOBbj15Yy4J3CppqaOyEbhP+MK9GCNM5zoFoL3qwLd4Y3AGvcnmXD+h?=
 =?iso-8859-1?Q?w24Ik37j3gNG89rd1Iyer2BCcwI31YAj0Lkq3PDp7CKCpNlpfddnUWtrwC?=
 =?iso-8859-1?Q?asOXYYOH/L0rlAstauZtbXUKoqZ7inYJvkIk9SXMDgQBPug4hOEI/Jjnl7?=
 =?iso-8859-1?Q?psn9oSEZq1CVU=3D?=
X-Forefront-Antispam-Report:
	CIP:195.242.140.30;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.dalco.ch;PTR:mail.dalco.ch;CAT:NONE;SFS:(13230040)(376014)(4022899009)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: dalco.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:10:17.2337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d2c57e-4119-41a5-8e03-08de0d549ba3
X-MS-Exchange-CrossTenant-Id: d06af698-620a-41dc-a250-98f7b8431cf6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d06af698-620a-41dc-a250-98f7b8431cf6;Ip=[195.242.140.30];Helo=[mail.dalco.ch]
X-MS-Exchange-CrossTenant-AuthSource: GV1PEPF000006FB.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0821

unsubscribe

--------
Matteo Guglielmi | DALCO AG | Industriestr. 28 | 8604 Volketswil | Switzerl=
and | T: +41 44 908 38 38 | D: +41 44 908 38 37
