export default {
    "domain": "opencollective.com",
    "From": "OpenCollective <info@opencollective.com>",
<<<<<<< HEAD
    "X-Envelope-From": "<bounce+7cbbdd.1148dc-organizers=testcollective.opencollective.com@opencollective.com>",
    "To": "organizers@testcollective.opencollective.com",
=======
    "X-Envelope-From": "<bounce+7cbbdd.1148dc-members=testcollective.opencollective.com@opencollective.com>",
    "To": "members@testcollective.opencollective.com",
>>>>>>> a6dcf10925ab437ea9515f171c8abf2c7cd17b39
    "Dkim-Signature": "a=rsa-sha256; v=1; c=relaxed/relaxed; d=opencollective.com; q=dns/txt; s=krs; t=1492960562; h=Content-Transfer-Encoding: Mime-Version: Message-Id: Date: Subject: To: From: Content-Type: Sender; bh=dSCe1q2EaaUM2sLs88Gyqwm6zmmaOuio8rHvPUurBPg=; b=geYIbyYOy0X5q7w7SkUTEAgsVO2YU3RjFykFU3s8StoZB7BF6ohi1ETiWmmLbluyB0wKrmXi TyT77ZSlzXrZaqGKR2am2NWUruoWUhkq5+2+XBaMfnFz6sLxPD+2NWuzW/wiPG7wk6dzfKhJ r24Z/EGwPiK3K+AoAtYOFyjVFjQ=",
    "Domainkey-Signature": "a=rsa-sha1; c=nofws; d=opencollective.com; s=krs; q=dns; h=Sender: Content-Type: From: To: Subject: Date: Message-Id: Mime-Version: Content-Transfer-Encoding; b=bGTmpwu+s9uXbKY3/wukpz2EXKcC31wfObDsCwRjtM/WJTn8GR8RM7RB7IJiSwlYH9GKvH UKnU0hzibA8Ao1z0DxHX2pi1oEwGNR/nZYsiENNjhNGWOh1HVNzVHMtw6ocPp7zveDoi68w/ 7pAMmo2uBCwzxE7Ec9IaP71E6PCjQ=",
    "subject": "[TESTING] Please approve: test 3",
    "from": "OpenCollective <info@opencollective.com>",
    "Content-Transfer-Encoding": "quoted-printable",
    "Date": "Sun, 23 Apr 2017 15:16:00 +0000",
    "Message-Id": "<1492960561291-aef49534-02874219-3e32a412@opencollective.com>",
    "X-Mailer": "nodemailer (1.11.0; +http://www.nodemailer.com; SMTP/1.1.0[client:1.3.8])",
    "Mime-Version": "1.0",
    "X-Mailgun-Sid": "WyIxMjRmYSIsICJtZW1iZXJzQHRlc3Rjb2xsZWN0aXZlLm9wZW5jb2xsZWN0aXZlLmNvbSIsICIxMTQ4ZGMiXQ==",
    "Received": [
        "from mail-s89.mailgun.info (mail-s89.mailgun.info [184.173.153.217]) by mxa.mailgun.org with ESMTP id 58fcc532.7f69fc56f7f0-smtp-in-n02; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)",
        "from Xaviers-MacBook-Pro.local (cpe-68-173-154-69.nyc.res.rr.com [68.173.154.69]) by mxa.mailgun.org with ESMTP id 58fcc532.7f1c38513f30-smtp-out-n03; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)"
    ],
    "X-Mailgun-Sending-Ip": "184.173.153.217",
    "Sender": "info@opencollective.com",
    "message-url": "https://se.api.mailgun.net/v3/domains/opencollective.com/messages/eyJwIjpmYWxzZSwiayI6IjYyOTY3YzgzLWU3YzAtNDk2Mi1hM2ZhLWQ5ZjMxMDM0MjcxMiIsInMiOiJhOWU4NmRiZmIxIiwiYyI6InRhbmtiIn0=",
<<<<<<< HEAD
    "message-headers": "[[\"X-Mailgun-Incoming\", \"Yes\"], [\"X-Envelope-From\", \"<bounce+7cbbdd.1148dc-organizers=testcollective.opencollective.com@opencollective.com>\"], [\"Received\", \"from mail-s89.mailgun.info (mail-s89.mailgun.info [184.173.153.217]) by mxa.mailgun.org with ESMTP id 58fcc532.7f69fc56f7f0-smtp-in-n02; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)\"], [\"Dkim-Signature\", \"a=rsa-sha256; v=1; c=relaxed/relaxed; d=opencollective.com; q=dns/txt; s=krs; t=1492960562; h=Content-Transfer-Encoding: Mime-Version: Message-Id: Date: Subject: To: From: Content-Type: Sender; bh=dSCe1q2EaaUM2sLs88Gyqwm6zmmaOuio8rHvPUurBPg=; b=geYIbyYOy0X5q7w7SkUTEAgsVO2YU3RjFykFU3s8StoZB7BF6ohi1ETiWmmLbluyB0wKrmXi TyT77ZSlzXrZaqGKR2am2NWUruoWUhkq5+2+XBaMfnFz6sLxPD+2NWuzW/wiPG7wk6dzfKhJ r24Z/EGwPiK3K+AoAtYOFyjVFjQ=\"], [\"Domainkey-Signature\", \"a=rsa-sha1; c=nofws; d=opencollective.com; s=krs; q=dns; h=Sender: Content-Type: From: To: Subject: Date: Message-Id: Mime-Version: Content-Transfer-Encoding; b=bGTmpwu+s9uXbKY3/wukpz2EXKcC31wfObDsCwRjtM/WJTn8GR8RM7RB7IJiSwlYH9GKvH UKnU0hzibA8Ao1z0DxHX2pi1oEwGNR/nZYsiENNjhNGWOh1HVNzVHMtw6ocPp7zveDoi68w/ 7pAMmo2uBCwzxE7Ec9IaP71E6PCjQ=\"], [\"Sender\", \"info@opencollective.com\"], [\"X-Mailgun-Sending-Ip\", \"184.173.153.217\"], [\"X-Mailgun-Sid\", \"WyIxMjRmYSIsICJtZW1iZXJzQHRlc3Rjb2xsZWN0aXZlLm9wZW5jb2xsZWN0aXZlLmNvbSIsICIxMTQ4ZGMiXQ==\"], [\"Received\", \"from Xaviers-MacBook-Pro.local (cpe-68-173-154-69.nyc.res.rr.com [68.173.154.69]) by mxa.mailgun.org with ESMTP id 58fcc532.7f1c38513f30-smtp-out-n03; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)\"], [\"Content-Type\", \"text/html; charset=\\\"utf-8\\\"\"], [\"From\", \"OpenCollective <info@opencollective.com>\"], [\"To\", \"organizers@testcollective.opencollective.com\"], [\"Subject\", \"[TESTING] Please approve: test 3\"], [\"O\", \"tag: email.approve\"], [\"X-Mailgun-Dkim\", \"yes\"], [\"X-Mailer\", \"nodemailer (1.11.0; +http://www.nodemailer.com; SMTP/1.1.0[client:1.3.8])\"], [\"Date\", \"Sun, 23 Apr 2017 15:16:00 +0000\"], [\"Message-Id\", \"<1492960561291-aef49534-02874219-3e32a412@opencollective.com>\"], [\"Mime-Version\", \"1.0\"], [\"Content-Transfer-Encoding\", \"quoted-printable\"]]",
    "O": "tag: email.approve",
    "X-Mailgun-Dkim": "yes",
    "recipient": "organizers@testcollective.opencollective.com",
    "sender": "bounce+7cbbdd.1148dc-organizers=testcollective.opencollective.com@opencollective.com",
=======
    "message-headers": "[[\"X-Mailgun-Incoming\", \"Yes\"], [\"X-Envelope-From\", \"<bounce+7cbbdd.1148dc-members=testcollective.opencollective.com@opencollective.com>\"], [\"Received\", \"from mail-s89.mailgun.info (mail-s89.mailgun.info [184.173.153.217]) by mxa.mailgun.org with ESMTP id 58fcc532.7f69fc56f7f0-smtp-in-n02; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)\"], [\"Dkim-Signature\", \"a=rsa-sha256; v=1; c=relaxed/relaxed; d=opencollective.com; q=dns/txt; s=krs; t=1492960562; h=Content-Transfer-Encoding: Mime-Version: Message-Id: Date: Subject: To: From: Content-Type: Sender; bh=dSCe1q2EaaUM2sLs88Gyqwm6zmmaOuio8rHvPUurBPg=; b=geYIbyYOy0X5q7w7SkUTEAgsVO2YU3RjFykFU3s8StoZB7BF6ohi1ETiWmmLbluyB0wKrmXi TyT77ZSlzXrZaqGKR2am2NWUruoWUhkq5+2+XBaMfnFz6sLxPD+2NWuzW/wiPG7wk6dzfKhJ r24Z/EGwPiK3K+AoAtYOFyjVFjQ=\"], [\"Domainkey-Signature\", \"a=rsa-sha1; c=nofws; d=opencollective.com; s=krs; q=dns; h=Sender: Content-Type: From: To: Subject: Date: Message-Id: Mime-Version: Content-Transfer-Encoding; b=bGTmpwu+s9uXbKY3/wukpz2EXKcC31wfObDsCwRjtM/WJTn8GR8RM7RB7IJiSwlYH9GKvH UKnU0hzibA8Ao1z0DxHX2pi1oEwGNR/nZYsiENNjhNGWOh1HVNzVHMtw6ocPp7zveDoi68w/ 7pAMmo2uBCwzxE7Ec9IaP71E6PCjQ=\"], [\"Sender\", \"info@opencollective.com\"], [\"X-Mailgun-Sending-Ip\", \"184.173.153.217\"], [\"X-Mailgun-Sid\", \"WyIxMjRmYSIsICJtZW1iZXJzQHRlc3Rjb2xsZWN0aXZlLm9wZW5jb2xsZWN0aXZlLmNvbSIsICIxMTQ4ZGMiXQ==\"], [\"Received\", \"from Xaviers-MacBook-Pro.local (cpe-68-173-154-69.nyc.res.rr.com [68.173.154.69]) by mxa.mailgun.org with ESMTP id 58fcc532.7f1c38513f30-smtp-out-n03; Sun, 23 Apr 2017 15:16:02 -0000 (UTC)\"], [\"Content-Type\", \"text/html; charset=\\\"utf-8\\\"\"], [\"From\", \"OpenCollective <info@opencollective.com>\"], [\"To\", \"members@testcollective.opencollective.com\"], [\"Subject\", \"[TESTING] Please approve: test 3\"], [\"O\", \"tag: email.approve\"], [\"X-Mailgun-Dkim\", \"yes\"], [\"X-Mailer\", \"nodemailer (1.11.0; +http://www.nodemailer.com; SMTP/1.1.0[client:1.3.8])\"], [\"Date\", \"Sun, 23 Apr 2017 15:16:00 +0000\"], [\"Message-Id\", \"<1492960561291-aef49534-02874219-3e32a412@opencollective.com>\"], [\"Mime-Version\", \"1.0\"], [\"Content-Transfer-Encoding\", \"quoted-printable\"]]",
    "O": "tag: email.approve",
    "X-Mailgun-Dkim": "yes",
    "recipient": "members@testcollective.opencollective.com",
    "sender": "bounce+7cbbdd.1148dc-members=testcollective.opencollective.com@opencollective.com",
>>>>>>> a6dcf10925ab437ea9515f171c8abf2c7cd17b39
    "X-Mailgun-Incoming": "Yes",
    "Content-Type": "text/html; charset=\"utf-8\"",
    "Subject": "[TESTING] Please approve: test 3",
    "timestamp": "1492960563",
    "token": "3e2694007836b7c81af1096a72f18ce6850fbb8932499e380e",
    "signature": "359d55cebd916da030f7c8292f89c1ab0ba63ca63d079a272d1622836beeeb7c",
    "body-plain": "From: Xavier Damman <xdamman@brusselstogether.org>  \nTo: (2 recipients)  \n  (https://opencollective.com/xdamman)  (https://opencollective.com/AseemSood_)  \nSubject: test 3  \n  \n \ntest 3 :-))  \n  \n Approve (http://localhost:3000/api/services/email/approve?mailserver=se&messageId=eyJwIjpmYWxzZSwiayI6ImFkMzQ4ZTA0LTYyNjktNDcwZi1hNDZkLWUxOWYxNjRjOWFiMyIsInMiOiI5ZGYyMzBkNjFmIiwiYyI6InRhbmtiIn0=&approver=xdamman%40gmail.com)  \n \n  \n  (https://opencollective.com?utm_source=opencollective&utm_campaign=email.approve&utm_medium=email)   \nWe can do great things together \nFor questions or feedback just reply to this email. \nTo unsubscribe from notifications of new emails pending approval, \nclick here (http://localhost:3000/api/services/email/unsubscribe/xdamman%40gmail.com/undefined/email.approve/634e44c0b2219e2804279b670042efeb) \nYou can also follow us on \nTwitter or come chat with us on our public (https://twitter.com/OpenCollect) Slack channel. (https://slack.opencollective.com?utm_source=opencollective&utm_campaign=email.approve&utm_medium=email) \nMade with ❤️ in NYC, San Francisco, Guadalajara and Brussels",
    "body-html": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n  <title></title>\r\n  <style>\r\n@media only screen and (min-device-width: 601px) {\r\n  .content {\r\n    width: 600px !important;\r\n  }\r\n}\r\n</style>\r\n</head>\r\n<body margin=\"0\" padding=\"0\" yahoo=\"\" style=\"margin: 0; padding: 0; min-width: 100%;\">\r\n\r\n<table bgcolor=\"white\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;box-sizing:border-box;font-size:14px;\"><tr><td align=\"center\" valign=\"top\">\r\n  <!--[if (gte mso 9)|(IE)]>\r\n    <table width=\"600\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td>\r\n  <![endif]-->\r\n  <table class=\"content\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; max-width: 600px; padding: 0 10px;\">\r\n    <tr>\r\n      <td></td>\r\n      <td>\r\n\r\n\r\n\r\n<table width=\"100%\">\r\n  <tr>\r\n    <th align=\"left\" width=\"75\" height=\"25\">From:</th>\r\n    <td>Xavier Damman &lt;xdamman@brusselstogether.org&gt;</td>\r\n  </tr>\r\n  <tr>\r\n    <th valign=\"top\" align=\"left\" rowspan=\"2\" width=\"75\" height=\"25\">To:</th>\r\n    <td> (2 recipients)</td>\r\n  </tr>\r\n  <tr>\r\n    <td>\r\n        <a href=\"https://opencollective.com/xdamman\" style=\"text-decoration: none;\"><img alt=\"Xavier Damman\" src=\"https://res.cloudinary.com/opencollective/image/fetch/c_thumb,g_face,h_48,r_max,w_48,bo_3px_solid_white/c_thumb,h_48,r_max,w_48,bo_2px_solid_rgb:66C71A/e_trim/f_auto/https%3A%2F%2Fopencollective-production.s3-us-west-1.amazonaws.com%2F5c825534ad62223ae6a539f6a5076d3cjpeg_1699f6e0-917c-11e6-a567-3f53b7b5f95c.jpeg\" width=\"24\" height=\"24\" border=\"0\" class=\"avatar\" style=\"margin: 0px 1px;\"></a>\r\n        <a href=\"https://opencollective.com/AseemSood_\" style=\"text-decoration: none;\"><img alt=\"Aseem Sood\" src=\"https://res.cloudinary.com/opencollective/image/fetch/c_thumb,g_face,h_48,r_max,w_48,bo_3px_solid_white/c_thumb,h_48,r_max,w_48,bo_2px_solid_rgb:66C71A/e_trim/f_auto/https%3A%2F%2Fd1ts43dypk8bqh.cloudfront.net%2Fv1%2Favatars%2F2331ca6b-360a-4ead-aa83-598f311dedcf\" width=\"24\" height=\"24\" border=\"0\" class=\"avatar\" style=\"margin: 0px 1px;\"></a>\r\n    </td>\r\n  </tr>\r\n  <tr>\r\n    <th align=\"left\" height=\"25\">Subject:</th>\r\n    <td>test 3</td>\r\n  </tr>\r\n  <tr>\r\n    <td colspan=\"2\" height=\"20\"></td>\r\n  </tr>\r\n  <tr>\r\n    <td colspan=\"2\"><div dir=\"ltr\">test 3 :-))</div>\r\n</td>\r\n  </tr>\r\n  <tr>\r\n    <td colspan=\"2\" height=\"20\"></td>\r\n  </tr>\r\n  <tr>\r\n    <td colspan=\"2\" align=\"center\"><div class=\"btn\" style=\"text-transform: uppercase; color: #fff; border: 1px solid transparent; border-radius: 28px; display: inline-block; padding: .75rem 1rem; background: #dde1e4; text-align: center; font-weight: 700; min-width: 150px; box-sizing: border-box; vertical-align: middle; background-color: #80d823;\"><a href=\"http://localhost:3000/api/services/email/approve?mailserver&#x3D;se&amp;messageId&#x3D;eyJwIjpmYWxzZSwiayI6ImFkMzQ4ZTA0LTYyNjktNDcwZi1hNDZkLWUxOWYxNjRjOWFiMyIsInMiOiI5ZGYyMzBkNjFmIiwiYyI6InRhbmtiIn0&#x3D;&amp;approver&#x3D;xdamman%40gmail.com\" style=\"text-decoration: none; color: #fff;\">Approve</a></div></td>\r\n  </tr>\r\n</table>\r\n\r\n    </td>\r\n  </tr>\r\n  <tr><td colspan=\"3\" height=\"40\"></td></tr>\r\n  <tr>\r\n    <td colspan=\"3\" align=\"center\">\r\n      <table width=\"100%\"><tr><td></td><td width=\"200\">\r\n        <a href=\"https://opencollective.com?utm_source&#x3D;opencollective&amp;utm_campaign&#x3D;email.approve&amp;utm_medium&#x3D;email\" style=\"text-decoration: none;\">\r\n          <img width=\"220\" height=\"28\" src=\"https://opencollective.com/public/images/logo-email-footer@2x.png\">\r\n        </a>\r\n      </td><td></td></tr></table>\r\n    </td>\r\n  </tr>\r\n  <tr>\r\n    <td colspan=\"3\" align=\"center\" style=\"font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;box-sizing:border-box;font-size:12px;color:#999;\">\r\n      We can do great things together<br><br>\r\n      For questions or feedback just reply to this email.<br>\r\n      To unsubscribe from notifications of new emails pending approval, <a href=\"http://localhost:3000/api/services/email/unsubscribe/xdamman%40gmail.com/undefined/email.approve/634e44c0b2219e2804279b670042efeb\" style=\"text-decoration: none;\">click here</a><br><br>\r\n\r\n      You can also follow us on <a href=\"https://twitter.com/OpenCollect\" style=\"text-decoration: none;\">Twitter</a> or come chat with us on our public <a href=\"https://slack.opencollective.com?utm_source&#x3D;opencollective&amp;utm_campaign&#x3D;email.approve&amp;utm_medium&#x3D;email\" style=\"text-decoration: none;\">Slack channel</a>.\r\n      <br><br>\r\n      Made with ❤️ in NYC, San Francisco, Guadalajara and Brussels\r\n    </td>  \r\n  </tr>\r\n  <tr><td colspan=\"3\" height=\"10\"></td></tr>\r\n</table><!-- 600px width content table -->\r\n\r\n<!--[if (gte mso 9)|(IE)]>\r\n  </td></tr></table>\r\n<![endif]-->\r\n\r\n</td></tr></table><!-- 100% width table -->\r\n<!-- OpenCollective.com -->\r\n<img width=\"1px\" height=\"1px\" alt=\"\" src=\"http://email.opencollective.com/o/eJxlzMENwyAMAMBpyo8KGwPxg2GIMWqkUKoEZf7mWak3wNUMQEsVs2UgRo4uREAGW7QRB0_W4ZIIga1Xj4UAH-TGR98y9l1lbpc-ZXTzytVzUq9RUmkS2121UEkCqK7MCcyRu_ZVj_Mepp7zZ_gPv-h3L34\"></body>\r\n</html>",
    "stripped-html": "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n  <title></title>\n  <style>\n@media only screen and (min-device-width: 601px) {\n  .content {\n    width: 600px !important;\n  }\n}\n</style>\n</head>\n<body margin=\"0\" padding=\"0\" yahoo=\"\" style=\"margin: 0; padding: 0; min-width: 100%;\">\n\n<table bgcolor=\"white\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;box-sizing:border-box;font-size:14px;\"><tr><td align=\"center\" valign=\"top\">\n  <!--[if (gte mso 9)|(IE)]>\n    <table width=\"600\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td>\n  <![endif]-->\n  <table class=\"content\" border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; max-width: 600px; padding: 0 10px;\">\n    <tr>\n      <td></td>\n      <td>\n\n\n\n<table width=\"100%\">\n  <tr>\n    <th align=\"left\" width=\"75\" height=\"25\">From:</th>\n    <td>Xavier Damman &lt;xdamman@brusselstogether.org&gt;</td>\n  </tr>\n  <tr>\n    <th valign=\"top\" align=\"left\" rowspan=\"2\" width=\"75\" height=\"25\">To:</th>\n    <td> (2 recipients)</td>\n  </tr>\n  <tr>\n    <td>\n        <a href=\"https://opencollective.com/xdamman\" style=\"text-decoration: none;\"><img alt=\"Xavier Damman\" src=\"https://res.cloudinary.com/opencollective/image/fetch/c_thumb,g_face,h_48,r_max,w_48,bo_3px_solid_white/c_thumb,h_48,r_max,w_48,bo_2px_solid_rgb:66C71A/e_trim/f_auto/https%3A%2F%2Fopencollective-production.s3-us-west-1.amazonaws.com%2F5c825534ad62223ae6a539f6a5076d3cjpeg_1699f6e0-917c-11e6-a567-3f53b7b5f95c.jpeg\" width=\"24\" height=\"24\" border=\"0\" class=\"avatar\" style=\"margin: 0px 1px;\"></a>\n        <a href=\"https://opencollective.com/AseemSood_\" style=\"text-decoration: none;\"><img alt=\"Aseem Sood\" src=\"https://res.cloudinary.com/opencollective/image/fetch/c_thumb,g_face,h_48,r_max,w_48,bo_3px_solid_white/c_thumb,h_48,r_max,w_48,bo_2px_solid_rgb:66C71A/e_trim/f_auto/https%3A%2F%2Fd1ts43dypk8bqh.cloudfront.net%2Fv1%2Favatars%2F2331ca6b-360a-4ead-aa83-598f311dedcf\" width=\"24\" height=\"24\" border=\"0\" class=\"avatar\" style=\"margin: 0px 1px;\"></a>\n    </td>\n  </tr>\n  <tr>\n    <th align=\"left\" height=\"25\">Subject:</th>\n    <td>test 3</td>\n  </tr>\n  <tr>\n    <td colspan=\"2\" height=\"20\"></td>\n  </tr>\n  <tr>\n    <td colspan=\"2\"><div dir=\"ltr\">test 3 :-))</div>\n</td>\n  </tr>\n  <tr>\n    <td colspan=\"2\" height=\"20\"></td>\n  </tr>\n  <tr>\n    <td colspan=\"2\" align=\"center\"><div class=\"btn\" style=\"text-transform: uppercase; color: #fff; border: 1px solid transparent; border-radius: 28px; display: inline-block; padding: .75rem 1rem; background: #dde1e4; text-align: center; font-weight: 700; min-width: 150px; box-sizing: border-box; vertical-align: middle; background-color: #80d823;\"><a href=\"http://localhost:3000/api/services/email/approve?mailserver&#x3D;se&amp;messageId&#x3D;eyJwIjpmYWxzZSwiayI6ImFkMzQ4ZTA0LTYyNjktNDcwZi1hNDZkLWUxOWYxNjRjOWFiMyIsInMiOiI5ZGYyMzBkNjFmIiwiYyI6InRhbmtiIn0&#x3D;&amp;approver&#x3D;xdamman%40gmail.com\" style=\"text-decoration: none; color: #fff;\">Approve</a></div></td>\n  </tr>\n</table>\n\n    </td>\n  </tr>\n  <tr><td colspan=\"3\" height=\"40\"></td></tr>\n  <tr>\n    <td colspan=\"3\" align=\"center\">\n      <table width=\"100%\"><tr><td></td><td width=\"200\">\n        <a href=\"https://opencollective.com?utm_source&#x3D;opencollective&amp;utm_campaign&#x3D;email.approve&amp;utm_medium&#x3D;email\" style=\"text-decoration: none;\">\n          <img width=\"220\" height=\"28\" src=\"https://opencollective.com/public/images/logo-email-footer@2x.png\">\n        </a>\n      </td><td></td></tr></table>\n    </td>\n  </tr>\n  <tr>\n    <td colspan=\"3\" align=\"center\" style=\"font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;box-sizing:border-box;font-size:12px;color:#999;\">\n      We can do great things together<br><br>\n      For questions or feedback just reply to this email.<br>\n      To unsubscribe from notifications of new emails pending approval, <a href=\"http://localhost:3000/api/services/email/unsubscribe/xdamman%40gmail.com/undefined/email.approve/634e44c0b2219e2804279b670042efeb\" style=\"text-decoration: none;\">click here</a><br><br>\n\n      You can also follow us on <a href=\"https://twitter.com/OpenCollect\" style=\"text-decoration: none;\">Twitter</a> or come chat with us on our public <a href=\"https://slack.opencollective.com?utm_source&#x3D;opencollective&amp;utm_campaign&#x3D;email.approve&amp;utm_medium&#x3D;email\" style=\"text-decoration: none;\">Slack channel</a>.\n      <br><br>\n      Made with ❤️ in NYC, San Francisco, Guadalajara and Brussels\n    </td>  \n  </tr>\n  <tr><td colspan=\"3\" height=\"10\"></td></tr>\n</table><!-- 600px width content table -->\n\n<!--[if (gte mso 9)|(IE)]>\n  </td></tr></table>\n<![endif]-->\n\n</td></tr></table><!-- 100% width table -->\n<!-- OpenCollective.com -->\n<img width=\"1px\" height=\"1px\" alt=\"\" src=\"http://email.opencollective.com/o/eJxlzMENwyAMAMBpyo8KGwPxg2GIMWqkUKoEZf7mWak3wNUMQEsVs2UgRo4uREAGW7QRB0_W4ZIIga1Xj4UAH-TGR98y9l1lbpc-ZXTzytVzUq9RUmkS2121UEkCqK7MCcyRu_ZVj_Mepp7zZ_gPv-h3L34\"></body>\n</html>",
    "stripped-text": "",
    "stripped-signature": ""
}