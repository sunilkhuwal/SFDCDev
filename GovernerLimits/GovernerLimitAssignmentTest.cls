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
        Account acc = new Account(Name='TestAccount'); insert acc;

        //Inserting account making the first account having one child account
        Account acc1 = new Account(Name='TestAccount3', Parent_Account__c=acc.Id); accList.add(acc1);
        Account acc2 = new Account(Name='TestAccount4', Parent_Account__c=acc.Id); accList.add(acc2);
        insert accList;
        
        Account verifyAccount = [SELECT Id, Child_Count__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(acc1.Parent_Account__c, verifyAccount.Id);        
        System.assertEquals(2, verifyAccount.Child_Count__c);
        System.assertEquals(acc2.Parent_Account__c, verifyAccount.Id);
        System.assertEquals(2, verifyAccount.Child_Count__c);
        
        //When
        Test.startTest();
        List<Account> updatingAccount = new List<Account>();
        acc1 = [SELECT Id, Parent_Account__c FROM Account WHERE Id = :acc1.Id];
        acc1.Parent_Account__c = NULL;
		update acc1;        
        Test.stopTest();
        
        //Then
        Account checkingAcc = [SELECT Id, Child_Count__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, checkingAcc.Child_Count__c);
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
   
    @isTest static void testAccountListDisplay(){
        //Given
        List<Account> accList = new List<Account>();
        Account acc = new Account(Name='TestAccount'); accList.add(acc);
        Account acc1 = new Account(Name='TestAccount1'); accList.add(acc1);
        Account acc2 = new Account(Name='TestAccount2'); accList.add(acc2);
        insert accList;
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1; i<=10; i++){
            oppList.add(new Opportunity(Name='opAcc'+i, StageName='New', CloseDate=System.today() + 30, accountId=acc.Id, amount=200));
            oppList.add(new Opportunity(Name='opAcc1'+i, StageName='New', CloseDate=System.today() + 30, accountId=acc1.Id, amount=100));
        }
        insert oppList;
        
        //When
        Test.startTest();
        OppExtController controller = new OppExtController(new ApexPages.StandardSetController(accList));
        Test.stopTest();
        
        //Then       
        System.assertEquals(2, controller.oppLst.size());
        System.assertEquals('TestAccount', controller.oppLst.get(0).get('act'));
        System.assertEquals(2000, controller.oppLst.get(0).get('amount'));
        System.assertEquals('TestAccount1', controller.oppLst.get(1).get('act'));
        System.assertEquals(1000, controller.oppLst.get(1).get('amount'));
    }
}