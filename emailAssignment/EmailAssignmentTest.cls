@isTest
public class EmailAssignmentTest {
    
    @isTest static void testSendEmailToApplicant(){
        
        //When
        Test.StartTest();
        SendEmailToApplicant.sendEmailToApplicant(new String[]{'abc.text@gmail.com'}, 'Test Email', 'Email message content');
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        //Then
        System.assertEquals(1, invocations, 'An email has not been sent');
    }
    
    @isTest static void testTrigger_sendEmailOnLoanStatusUpdate(){
        //Given
        Loan__c ln = new Loan__c(Name__c='applicant 1', amount__c=1000, applicant_email__c='abc.text@gmail.com'); insert ln;
        Loan__c ln2 = new Loan__c(Name__c='applicant 1', amount__c=1000, applicant_email__c='abc.text@gmail.com'); insert ln2;
        
        //When
        Test.startTest();
        ln.Status__c='Approved';
       	ln2.Status__c='Reject';
        List<Loan__c> lnLst = new List<Loan__c>{ln, ln2};
        update lnLst;
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        //Then
        System.assertEquals(2, invocations, 'An email has not been sent');
    }
    
    @isTest static void testTrigger_SendEmailOnOpportunityUpdate(){
        //Given
        Opportunity oppr = new Opportunity(Name='op1', StageName='New', CloseDate=System.today()+10); insert oppr;

        //When
        Test.StartTest();
        oppr.Custom_Status__c='Open';
        update oppr;
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        //Then
        System.assertEquals(1, invocations, 'An email has not been sent');
    }
}