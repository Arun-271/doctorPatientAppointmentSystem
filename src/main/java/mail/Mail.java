package mail;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;


public class Mail {
    public static void Message(String email,String message){
        send("arunpersonal57@gmail.com","qomiyfulwdktngea",email,"Appoint Status updated",message);
    }
    public static void send(String from,String password,String to,String sub,String msg){
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // Host for gmail is smtp.gmail
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true"); // We have to set it true as gmail requires authentication
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from,password);
                    }
                });
        try {
            MimeMessage message = new MimeMessage(session);
            message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
            message.setSubject(sub);
            message.setText(msg);
            Transport.send(message);
            System.out.println("message sent successfully");
        } catch (MessagingException e) {
        	throw new RuntimeException(e);
        	}
    }
} 