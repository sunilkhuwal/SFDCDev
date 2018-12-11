@isTest
public class GovernerLimitAssignmentTest {

    @isTest static void testUpdateChildCountAccount_onAddingParentToTheAccounts(){
        
        //Given
        List<Account> accList = new List<Account>();
        Account acc = new Account(Name='TestAccount'); accList.add(acc);
        Account acc1 = new Account(Name='TestAccount1'); accList.add(acc1);
        Account acc2 = new Account(Name='TestAccount2'); accList.add(acc2);
        insert accList;
        
        //When
        Test.startTest();
        accList.get(1).Parent_Account__c = accList.get(0).Id;
       	accList.get(2).Parent_Account__c = accList.get(0).Id;
        update accList;
        Test.stopTest();
        
        //Then
        Account checkingAcc = [SELECT Id, Child_Count__c FROM Account WHERE Id = :accList.get(0).Id];
        System.assertEquals(2, checkingAcc.Child_Count__c);
    }
    
    @isTest static void testUpdateChildCountAccount_onRemovingParentToTheAccounts(){
        
        //Given
        List<Account> accList = new List<Account>();
        Account acc = new Account(Name='TestAccount'); accList.add(acc);
        Account acc1 = new Account(Name='TestAccount1'); accList.add(acc1);
        Account acc2 = new Account(Name='TestAccount2'); accList.add(acc2);
        insert accList;
        //Inserting account making the first account having one child account
        Account acc3 = new Account(Name='TestAccount2', Parent_Account__c=accList.get(0).Id); insert acc3;
        System.assertEquals(acc3.Parent_Account__c, accList.get(0).Id);
        System.assertEquals(NULL, accList.get(0).Child_Count__c);
        
        //When
        Test.startTest();
        acc3.Parent_Account__c = NULL;
        update acc3;
        Test.stopTest();
        
        //Then
        Account checkingAcc = [SELECT Id, Child_Count__c FROM Account WHERE Id = :accList.get(0).Id];
        System.assertEquals(0, checkingAcc.Child_Count__c);
    }

    @isTest static void testUpdateChildCountAccount_onAddingRemovingParentToTheAccounts(){
        
        //Given
        List<Account> accList = new List<Account>();
        Account acc = new Account(Name='TestAccount'); accList.add(acc);
        Account acc1 = new Account(Name='TestAccount1'); accList.add(acc1);
        Account acc2 = new Account(Name='TestAccount2'); accList.add(acc2);
        insert accList;
        //Inserting account making the first account having one child account
        Account acc3 = new Account(Name='TestAccount2', Parent_Account__c=accList.get(0).Id); insert acc3;
        System.assertEquals(acc3.Parent_Account__c, accList.get(0).Id);
        System.assertEquals(NULL, accList.get(0).Child_Count__c);
        
        //When
        Test.startTest();
        acc3.Parent_Account__c = NULL;
        accList.get(1).Parent_Account__c = accList.get(0).Id;
       	accList.get(2).Parent_Account__c = accList.get(0).Id;
        accList.add(acc3);
        update accList;
        Test.stopTest();
        
        //Then
        Account checkingAcc = [SELECT Id, Child_Count__c FROM Account WHERE Id = :accList.get(0).Id];
        System.assertEquals(2, checkingAcc.Child_Count__c);
    }
}