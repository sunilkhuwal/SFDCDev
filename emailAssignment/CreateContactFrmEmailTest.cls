@isTest(isParallel=true)
public class CreateContactFrmEmailTest {
    
    static String createAttachment(){
        String contactAttachment = '';
        contactAttachment += '<contacts>';
        contactAttachment += '<contact>';
        contactAttachment += '<fname>hoya</fname>';
        contactAttachment += '<lname>Maya</lname>';
        contactAttachment += '<email>abc@xyzc.com</email>';
        contactAttachment += '<phonenumber>8989898980</phonenumber>';
        contactAttachment += '<experience>2.5</experience>';
        contactAttachment += '</contact>';
        contactAttachment += '<contact>';
        contactAttachment += '<fname>Dhunda</fname>';
        contactAttachment += '<lname>Cilla</lname>';
        contactAttachment += '<email>abc@xyzb.com</email>';
        contactAttachment += '<phonenumber>8189898980</phonenumber>';
        contactAttachment += '<experience>10.5</experience>';
        contactAttachment += '</contact>';
        contactAttachment += '<contact>';
        contactAttachment += '<fname>Anaaa</fname>';
        contactAttachment += '<lname>Taaaanaa</lname>';
        contactAttachment += '<email>abc@xyza.com</email>';
        contactAttachment += '<phonenumber>8989898980</phonenumber>';
        contactAttachment += '<experience>11.5</experience>';
        contactAttachment += '</contact>';
        contactAttachment += '</contacts>';
        return contactAttachment;
    }
    
    static String createOtherFormatAttachment(){
        String contactAttachment = '';
        contactAttachment += '<contacts>';
        contactAttachment += '<contact>';
        contactAttachment += '<fname>hoya</fname>';
        contactAttachment += '<lname>Bhaaya</lname>';
        contactAttachment += '<email>abc@xyzc.com</email>';
        contactAttachment += '<phonenumbers>8989898980</phonenumbers>';
        contactAttachment += '<experience>2.5</experience>';
        contactAttachment += '<subject>English</subject>';
        contactAttachment += '</contact>';
        contactAttachment += '<contact>';
        contactAttachment += '<fname>Dhunda</fname>';
        contactAttachment += '<lname>Billa</lname>';
        contactAttachment += '<email>abc@xyzb.com</email>';
        contactAttachment += '<phonenumber>8189898980</phonenumber>';
        contactAttachment += '<experience>10.5</experience>';
        contactAttachment += '</contact>';
        contactAttachment += '</contacts>';
        return contactAttachment;
    }
    
    @isTest static void testCreateContact_BymultipleContactsAttachment(){
        //Given
        Messaging.InboundEmail.TextAttachment inbTextAttachmment = new Messaging.InboundEmail.TextAttachment();
        inbTextAttachmment.body = createAttachment();
        inbTextAttachmment.fileName = 'CreationOfContact.xml';        
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();
        email.subject = 'Create Contact';
        email.plainTextBody = 'FromEmail';
        email.textAttachments = new List<Messaging.InboundEmail.TextAttachment>{inbTextAttachmment};
		env.fromAddress = 'abcxyz@gmail.com';
        
        //When        
        Test.startTest();
        CreateContactFrmEmail creatC = new CreateContactFrmEmail();
        creatC.handleInboundEmail(email, env);
        Test.stopTest();
        
        //Then
        List<Contact> conLst = [SELECT Id FROM Contact WHERE LastName IN ('Maya','Cilla', 'Taaaanaa')];
        System.assertEquals(3, conLst.size());
    }
    
    @isTest static void testCreateContact_ByInvalidContactFormatAttachment(){
        
        //Given
        Messaging.InboundEmail.TextAttachment inbTextAttachmment = new Messaging.InboundEmail.TextAttachment();
        inbTextAttachmment.body = createOtherFormatAttachment();
        inbTextAttachmment.fileName = 'CreationOfContact.xml';        
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();
        email.subject = 'Create Contact';
        email.plainTextBody = 'FromEmail';
        email.textAttachments = new List<Messaging.InboundEmail.TextAttachment>{inbTextAttachmment};
        env.fromAddress = 'abcxyz@gmail.com';
        
        //When
        try{
        	Test.startTest();
            CreateContactFrmEmail creatC = new CreateContactFrmEmail();
            creatC.handleInboundEmail(email, env);            
            Test.stopTest();    
        }
        //Then
        catch(Exception c){
            System.assertEquals('Invalid format is not allowed', c.getMessage());
        }
    }    
}