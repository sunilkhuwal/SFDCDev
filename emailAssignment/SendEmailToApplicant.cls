public class SendEmailToApplicant {

    public static void sendEmailToApplicant(String[] emailRecipients, String subjectContent, String messageContent){
    	Messaging.SingleEmailMessage sndEmail = new Messaging.SingleEmailMessage();
        sndEmail.setToAddresses(emailRecipients);
        sndEmail.setPlainTextBody(messageContent);
        sndEmail.setSubject(subjectContent);
		
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{sndEmail}); 
    }
}