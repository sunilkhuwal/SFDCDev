public class SendEmailToApplicant {
    
    public static void sendEmailToApplicant(String[] emailRecipients, String subjectContent, String messageContent){
        sendEmailToApplicant(emailRecipients, subjectContent, messageContent, '');
    }

    public static void sendEmailToApplicant(String[] emailRecipients, String subjectContent, String messageContent, String emailTemplate){
        Messaging.SingleEmailMessage sndEmail = new Messaging.SingleEmailMessage();
        sndEmail.setToAddresses(emailRecipients);
        if(String.isEmpty(emailTemplate)){
            System.debug('String is empty ');
            sndEmail.setPlainTextBody(messageContent);  
        }else{
            EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName = :emailTemplate];
            sndEmail.setTemplateId(et.Id);
        }
        sndEmail.setSubject(subjectContent);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{sndEmail}); 
    }
}