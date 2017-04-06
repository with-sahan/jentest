package com.mdl.mdlrestapi.util;
import com.mdl.mdlrestapi.psm.utils.ConfigUtil;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
@Deprecated
public class EmailSender {

	@Deprecated
	public static void SendEmail(String mailTo,String subject,String emailMessage)
	   {    
	      // Recipient's email ID needs to be mentioned.
	      String to = mailTo;

	      // Sender's email ID needs to be mentioned
	      String from = ConfigUtil.EMAIL_FROM;

	      // Assuming you are sending email from localhost
	      String host = ConfigUtil.SMTP_HOST;

	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);

	      // Get the default Session object.
	      Session session = Session.getDefaultInstance(properties);

	      try{
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject(subject);

	         // Now set the actual message
	         message.setText(emailMessage);

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      }catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
	   }
}
