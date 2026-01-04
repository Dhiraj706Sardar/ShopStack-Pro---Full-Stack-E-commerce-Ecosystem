package com.ecommerce.service.impl;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.service.EmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private TemplateEngine templateEngine;

    @Value("${spring.mail.from}")
    private String fromEmail;

    @Override
    public void sendOrderConfirmationEmail(OrderDTO order) {
        try {
            Context context = new Context();
            context.setVariable("order", order);
            String process = templateEngine.process("order-confirmation", context);

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setSubject("Order Confirmation - #" + order.getId());
            helper.setFrom(fromEmail);
            helper.setTo(order.getUserEmail()); // Assuming OrderDTO has userEmail
            helper.setText(process, true);

            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            // Log the error or handle it appropriately
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }

    @Override
    public void sendPasswordResetEmail(String to, String token) {
        try {
            Context context = new Context();
            context.setVariable("token", token);
            context.setVariable("resetUrl", "http://localhost:3000/reset-password?token=" + token);
            String process = templateEngine.process("password-reset", context);

            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setSubject("Password Reset Request");
            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setText(process, true);

            mailSender.send(mimeMessage);
        } catch (MessagingException | org.springframework.mail.MailException e) {
            System.err.println("Failed to send password reset email: " + e.getMessage());
            throw new com.ecommerce.exception.APIException("Failed to send email. Please try again later.");
        }
    }
}
