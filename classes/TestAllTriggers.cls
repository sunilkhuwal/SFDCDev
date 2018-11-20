@isTest
public class TestAllTriggers {
    
    static testMethod void MaxLimitClass()
    {
        List<Student__c> stdLst = new List<Student__c>();
        
        Class__c cls1 = new Class__c(Name__c='Cls1', MaxSize__c=1); insert cls1;
        Class__c cls2 = new Class__c(Name__c='Cls2', MaxSize__c=1); insert cls2;
        Class__c cls3 = new Class__c(Name__c='Cls3', MaxSize__c=1); insert cls3;
        
        Student__c std = new Student__c(LastName__c='Student', Sex__c='Female',Class__c=cls1.Id); insert std;
        Student__c std1 = new Student__c(LastName__c='Student1', Sex__c='Female',Class__c=cls2.Id); stdLst.add(std1);
        Student__c std2 = new Student__c(LastName__c='Student2', Sex__c='Female',Class__c=cls1.Id); stdLst.add(std2);
        
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(stdLst, false);
        Test.stopTest();
        
        System.assert(result[0].isSuccess());
        System.assert(result[0].getErrors().size() == 0);
        
        System.assert(!result[1].isSuccess());
        System.assert(result[1].getErrors().size() > 0);
        System.assertEquals('Cannot add more students to the same class, MaxSize limit reached !', result[1].getErrors()[0].getMessage());
        
        std.Class__c=cls3.Id;
        std1.Class__c=cls1.Id;
        stdLst.clear(); stdLst.add(std); stdLst.add(std1);
        
        result = Database.update(stdLst, false);
        
        System.assert(result[0].isSuccess());
        System.assert(result[0].getErrors().size() == 0);
        
        System.assert(!result[1].isSuccess());
        System.assert(result[1].getErrors().size() > 0);
        System.assertEquals('Cannot add more students to the same class, MaxSize limit reached !', result[1].getErrors()[0].getMessage());
    }
    
    static testMethod void MyClassCount(){
        List<Class__c> clsLst = new List<Class__c>();
        List<Student__c> stdLst = new List<Student__c>();
        
        Class__c cls1 = new Class__c(Name__c='Cls1',MaxSize__c=10,MyCount__c=0); clsLst.add(cls1);
        Class__c cls2 = new Class__c(Name__c='Cls2',MaxSize__c=10,MyCount__c=0); clsLst.add(cls2);
        insert clsLst;
        
        System.assertEquals(0, cls1.MyCount__c);
        System.assertEquals(0, cls2.MyCount__c);
        
        for(Integer i=1; i<=5; i++)
        {
            Student__c std = new Student__c(LastName__c='TStudent'+i, Class__c=cls1.Id); stdLst.add(std);
        }
        
        Test.startTest();
        insert stdLst;
        Test.stopTest();
        
        cls1 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls1'];
        cls2 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls2'];
        System.assertEquals(5, cls1.MyCount__c);
        System.assertEquals(0, cls2.MyCount__c);
        
        for(Student__c st : stdLst)
        {
            st.Class__c = cls2.Id;
        }
        
        update stdLst;
        
        cls1 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls1'];
        cls2 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls2'];
        System.assertEquals(0, cls1.MyCount__c);
        System.assertEquals(5, cls2.MyCount__c);
        
        delete stdLst;
        
        cls1 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls1'];
        cls2 = [SELECT Id, MyCount__c FROM Class__c WHERE Name__c = 'Cls2'];
        System.assertEquals(0, cls1.MyCount__c);
        System.assertEquals(0, cls2.MyCount__c);
    }

    static testmethod void ChangeStatus(){
        List<Opportunity> oppLst = new List<Opportunity>();
        
        for(Integer i=1; i<=5; i++){
            Opportunity opp = new Opportunity(Name = 'Testopp'+i, CloseDate = Date.newInstance(2018, 11, 11), StageName = 'Qualification', Custom_Status__c = 'Open');
            oppLst.add(opp);
        }
        
        Test.startTest();
        insert oppLst;
        Test.stopTest();
        
        oppLst = [SELECT Id, CloseDate, StageName, Custom_Status__c FROM Opportunity WHERE Name LIKE 'Testopp%'];
        System.assertEquals(oppLst.size(), 5);
        System.assertEquals(oppLst[0].CloseDate, Date.newInstance(2018, 11, 11));
        System.assertEquals(oppLst[0].StageName, 'Qualification');
        
        for(Opportunity op : oppLst){
            op.StageName = 'Closed Won';
            op.Custom_Status__c = 'Close';
        }
        
        update oppLst;
        
        oppLst = [SELECT Id, CloseDate, StageName, Custom_Status__c FROM Opportunity WHERE Name LIKE 'Testopp%'];
        System.assertEquals(oppLst[0].CloseDate, System.today());
        System.assertEquals(oppLst[0].StageName, 'Closed Won');
        System.assertEquals(oppLst[0].Custom_Status__c, 'Close');
        
        for(Opportunity op : oppLst){
            op.CloseDate = Date.newInstance(2018, 11, 12);
        }
        
        update oppLst;
        
        oppLst = [SELECT Id, CloseDate, StageName FROM Opportunity WHERE Name LIKE 'Testopp%'];
        System.assertEquals(oppLst[0].CloseDate, Date.newInstance(2018, 11, 12));
        System.assertEquals(oppLst[0].StageName, 'Closed Won');    
        
        Product2 pr = new Product2(Name='Op Product'); insert pr;
        OpportunityLineItem opLine = new OpportunityLineItem(Product2=pr); insert opLine;
        
        for(Opportunity op :oppLst){
            
        }
        
        oppLst = [SELECT Id, CloseDate, StageName FROM Opportunity WHERE Name LIKE 'Testopp%'];
        System.assertEquals(oppLst[0].CloseDate, Date.newInstance(2018, 11, 12));
        System.assertEquals(oppLst[0].StageName, 'Closed Won');
    }
}