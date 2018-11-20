@isTest
public class TestClassExtController {

    static testMethod void verifyEditFunction(){
        Class__c cls1 = new Class__c(Name__c='Cls1', MaxSize__c=1); insert cls1;
        Class__c cls2 = new Class__c(Name__c='Cls2', MaxSize__c=1); insert cls2;
        Class__c cls3 = new Class__c(Name__c='Cls3', MaxSize__c=1); insert cls3;

        ClassExtController con = new ClassExtController(new ApexPages.StandardSetController(new List<Class__c>{cls1}));
        con.classId = cls1.Id;
        con.editClass();
        cls1.DetailedDescription__c = 'Test1';
        con.saveData();
        
        Class__c cls = [SELECT Id, DetailedDescription__c FROM Class__c WHERE Id = :cls1.Id];
        System.assertEquals('Test1', cls1.DetailedDescription__c);        
    }
    
    static testMethod void verifyDeleteFunction(){
        Class__c cls1 = new Class__c(Name__c='Cls1', MaxSize__c=1); insert cls1;
        Class__c cls2 = new Class__c(Name__c='Cls2', MaxSize__c=1); insert cls2;
        Class__c cls3 = new Class__c(Name__c='Cls3', MaxSize__c=1); insert cls3;

        List<Class__c> addClsLst = [SELECT Id From Class__c WHERE Id IN (:cls1.Id, :cls2.Id, :cls3.Id)];
        System.assertEquals(3, addClsLst.size());

        ClassExtController con = new ClassExtController(new ApexPages.StandardSetController(new List<Class__c>{cls1}));
        con.classId = cls1.Id;
        con.deleteClass();
        
        List<Class__c> clsLst = [SELECT Id, DetailedDescription__c FROM Class__c WHERE Id = :cls1.Id];
        System.assertEquals(0, clsLst.size()); 
    }
}