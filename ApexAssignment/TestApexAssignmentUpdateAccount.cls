@isTest
public class TestApexAssignmentUpdateAccount {
    
    static List<Contact> createTestdata()
    {
        Account acc = new Account(Name='TestAccount'); insert acc;
        List<Contact> conLst = new List<Contact>();
        RecordType tgtRcrd = [SELECT Id FROM RecordType WHERE Name = 'TGT'];
        Contact con1 = new Contact(RecordTypeId=tgtRcrd.Id, LastName = 'Contact1', AccountId=acc.Id); conLst.add(con1);
        Contact con2 = new Contact(RecordTypeId=tgtRcrd.Id, LastName = 'Contact2', AccountId=acc.Id); conLst.add(con2);
        insert conLst;
        return conLst;
    }
    
    @isTest static void testUpdateAccountWhen_ContactIdsIsNull(){
        //Given
        List<Contact> conLst = createTestData();
        Account acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'TestAccount'];
        acc.ContactIDs__c=NULL;
        update acc;        
        System.assert(acc.ContactIDs__c == NULL); 
        
        //When
        Test.startTest();
        ApexAssignmentUpdateAccount.checkContact(conLst.get(0).Id);
        Test.stopTest();
        
        //Then
        acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'TestAccount'];
        System.assertEquals(true, acc.ContactIDs__c.contains(conLst.get(0).Id));
    }   
    
    @isTest static void testUpdateAccountWhen_ContactIdsIsNotPresentForContact(){
        //Given
        List<Contact> conLst = createTestData();
        Account acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'TestAccount'];
        acc.ContactIDs__c=conLst.get(0).Id;
        update acc;
        //Ensure that already a contactid is present in account        
        System.assertEquals(conLst.get(0).Id, acc.ContactIDs__c); 
        
        //When
        Test.startTest();
        ApexAssignmentUpdateAccount.checkContact(conLst.get(1).Id);
        Test.stopTest();
        
        //Then
        acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'TestAccount'];
        System.assertEquals(true, acc.ContactIDs__c.contains(conLst.get(0).Id));
        System.assertEquals(true, acc.ContactIDs__c.contains(conLst.get(1).Id));
        String[] contArr = acc.ContactIDs__c.split(',');
        System.assertEquals(2, contArr.size());
    }     
    
    static testMethod void testupdateOpportunityWhen_BillToContactIsPresentAndManagerisNull(){        
        //Given
        List<Contact> conLst = createTestData();
        Opportunity opp = new Opportunity(Name = 'updateOpp1', BillToContact__c = conLst.get(0).Id, CloseDate = System.today(), StageName = 'Closed Won');
        insert opp;
        
        //When
        Test.startTest();
        ApexAssignmentUpdateAccount.updateOpportunity(new List<Opportunity>{opp});
        Test.stopTest();
        
        //Then
        Opportunity oppResult = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(conLst.get(0).AccountId, oppResult.Manager__c);
    }
}