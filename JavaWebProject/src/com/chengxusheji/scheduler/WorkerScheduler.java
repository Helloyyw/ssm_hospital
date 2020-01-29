package com.chengxusheji.scheduler;

import com.chengxusheji.mapper.OrderInfoMapper;
import com.chengxusheji.po.Doctor;
import com.chengxusheji.po.OrderInfo;
import com.chengxusheji.po.UserInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.List;
import java.util.Properties;


@Component
public class WorkerScheduler{

	private static Logger log = LoggerFactory.getLogger(WorkerScheduler.class);
	@Autowired
	OrderInfoMapper orderInfoMapper;

	@Scheduled(cron="*/60 * * * * *")    // 间隔30秒执行
	public void createWorkTime() throws Exception {
		// 查找需要发送通知的订单
		final List<OrderInfo> orderRecords = orderInfoMapper.findOrderInfoListByStatus("无");
		log.info("开始发送邮件");

		// 循环订单
		for (int i = 0; i < orderRecords.size(); i++) {
			final OrderInfo orderInfo = orderRecords.get(i);
//			final UserInfo userInfo = orderRecords.get(i).getUserObj();
//			final Doctor doctor = orderRecords.get(i).getDoctorObj();
			// 单独开启线程发送邮件，防止用户等待时间过长，成功日志输出，失败也输出。
			new Thread(new Runnable() {
				public void run() {
					try {
						sendMail(orderInfo);
						log.info("发成功，开始修改订单信息");
						OrderInfo orderInfo1 = new OrderInfo();
						orderInfo1 = orderInfo;
						orderInfo1.setReplyContent("已发送邮件");
						orderInfo1.setCheckState("已通知");
						orderInfoMapper.updateOrderInfo(orderInfo1);
					} catch (Exception e) {
						log.info("发送失败");
						e.printStackTrace();
					}
				}
			}).start();
		}

	}

	//发送一封只包含文本的简单邮件 并修改订单的状态
	public void sendMail(OrderInfo orderInfo) throws Exception {
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
		Message message = createSimpleMail(session,orderInfo);
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
	private Message createSimpleMail(Session session, OrderInfo orderInfo)throws Exception {
		//创建邮件对象
		MimeMessage message = new MimeMessage(session);
		//指明邮件的发件人
		message.setFrom(new InternetAddress("15696049710@163.com"));
		//指明邮件的收件人，现在发件人和收件人是一样的，那就是自己给自己发
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(orderInfo.getUserObj().getEmail()));
		//邮件的标题
		message.setSubject("草街人民医院预约挂号【预约通知提醒】");
		//邮件的文本内容
		String contentInfo = orderInfo.getUserObj().getName()+ "您好：" + "\n<br>您预约的" + orderInfo.getOrderDate() + "-"
				+ orderInfo.getTimeInterval() + "-" + orderInfo.getDoctorObj().getDoctorName() + "医生的订单已成功通过审核" + "\n<br>请您持有效证件于"
				+ orderInfo.getOrderTime() + "之前前往！";
		message.setContent(contentInfo, "text/html;charset=UTF-8");
		//返回创建好的邮件对象
		return message;
	}
}
