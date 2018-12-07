global class CreateContactFrmEmail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelop){
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        if(email.textAttachments != null  && email.textAttachments.size()>0){
            for(Messaging.InboundEmail.TextAttachment file : email.textAttachments){
                List<Contact> conList = new List<Contact>();				
                Dom.Document doc = new Dom.document();
                doc.load(file.body);                
                Dom.XmlNode rootNode = doc.getRootElement();
                for(Dom.XmlNode contact : rootNode.getChildElements()){
                    try{
                        Contact c = new Contact();
                        c.FirstName = contact.getChildElement('fname', null).getText();
                        c.LastName = contact.getChildElement('lname', null).getText();
                        c.Email = contact.getChildElement('email', null).getText();
                        c.Phone = contact.getChildElement('phonenumber', null).getText();
                        c.Experience__c = Decimal.valueOf(contact.getChildElement('experience', null).getText());
                        conList.add(c);
                    }
                    catch(Exception e){
                        throw new CreateContactFrmEmailException('Invalid format is not allowed');
                    }
                }
                insert conList;
            }    
        }
        result.success = true;
        return result;
    }
    
    public class CreateContactFrmEmailException extends Exception{}
}