@isTest(seeAllData = true)
public class TestApexAssignmentUpdateAccount {

    public static testMethod void updateAccount(){
        Contact con = [SELECT Id, AccountId FROM Contact WHERE FirstName = 'Prateek'];
        Account acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'Acme Corporation'];
        
        acc.ContactIDs__c = NULL;
        update acc;
        acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'Acme Corporation'];
        
        System.assert(acc.ContactIDs__c == NULL);        
        System.assertEquals(1, (new List<Contact>{con}).size());
        System.assertEquals(1, (new List<Account>{acc}).size());

        ApexAssignmentUpdateAccount.checkContact(con.Id);
        acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'Acme Corporation'];
        System.assert(acc.ContactIDs__c.contains(con.Id));
       
        //Case two new Contact
    Contact con2 = new Contact(FirstName = 'PrashantRai', LastName = 'Sharmaji', AccountId = acc.Id);
        insert con2;
       
        ApexAssignmentUpdateAccount.checkContact(con2.Id);
        acc = [SELECT Id, ContactIDs__c FROM Account WHERE Name = 'Acme Corporation'];
        System.assert(acc.ContactIDs__c.contains(con2.Id));
        
    }
 
    static testMethod void updateOpp(){
        Contact con = [SELECT Id FROM Contact WHERE FirstName = 'Prateek'];
        Opportunity opp = new Opportunity(Name = 'updateOpp1', BillToContact__c = con.Id, CloseDate = System.today(), StageName = 'Closed Won');
        
        insert opp;
        
        opp.Amount = 1000;
        update opp;
    }
}