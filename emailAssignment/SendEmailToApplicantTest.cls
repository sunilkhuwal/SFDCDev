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
}