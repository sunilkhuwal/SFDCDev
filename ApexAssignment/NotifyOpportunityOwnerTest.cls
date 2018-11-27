@isTest(seealldata=true)
public class NotifyOpportunityOwnerTest {

    @isTest
    static void validateSingleOpportunity(){
 		Opportunity op = new Opportunity();
        op.Name = 'op1';
        op.StageName = 'New';
        op.CloseDate = System.today() + 30;
        insert op;
        Test.StartTest();
        NotifyOpportunityOwner opOwner = new NotifyOpportunityOwner();
        String sch = '0 0 16 * * ?';
        System.schedule('Test Territory Check', sch, opOwner);        
        Test.stopTest();
        
        System.assertEquals(0, opOwner.Opportunitylist.size());
        
    }

    @isTest
    static void validateNotifyOpportunityOwner(){
        Test.StartTest();
        NotifyOpportunityOwner opOwner = new NotifyOpportunityOwner();
        String sch = '0 0 16 * * ?';
        System.schedule('Test Territory Check', sch, opOwner);
        Test.stopTest();
        
        System.assertEquals(0, opOwner.Opportunitylist.size());
    }
}