package com.chengxusheji.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class MailTools {


    //发送一封只包含文本的简单邮件
   public void sendMail() throws Exception {
       Properties prop = new Properties();
       prop.setProperty("mail.host", "smtp.163.com");
       prop.setProperty("mail.transport.protocol", "smtp");
       prop.setProperty("mail.smtp.auth", "true");
       //使用JavaMail发送邮件的5个步骤
                //1、创建session
                Session session = Session.getInstance(prop);
                //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
                session.setDebug(true);
                //2、通过session得到transport对象
                Transport ts = session.getTransport();
                //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
                ts.connect("smtp.163.com", "15696049710@163.com", "yyy19961118");
                //4、创建邮件
                Message message = createSimpleMail(session);
                //5、发送邮件
                ts.sendMessage(message, message.getAllRecipients());
                ts.close();
    }
    /**
     46     * @Method: createSimpleMail
     47     * @Description: 创建一封只包含文本的邮件
     50     * @param session
     51     * @return
     52     * @throws Exception
     53     */
    private Message createSimpleMail(Session session)throws Exception {
                     //创建邮件对象
                     MimeMessage message = new MimeMessage(session);
                     //指明邮件的发件人
                     message.setFrom(new InternetAddress("15696049710@163.com"));
                     //指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
                     message.setRecipient(Message.RecipientType.TO, new InternetAddress("1475556814@qq.com"));
                     //邮件的标题
                     message.setSubject("草街人民医院预约成功通知");
                     //邮件的文本内容
                     message.setContent("你好啊！", "text/html;charset=UTF-8");
                     //返回创建好的邮件对象
                     return message;
    }
}
