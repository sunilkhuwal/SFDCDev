@isTest
public class WebsiteControllerTest {
    
    @isTest static void testSelectOptions(){
        
        //Given
        List<Student__c> stdLst = new List<Student__c>();        
        Class__c cls1 = new Class__c(Name__c='Cls1', MaxSize__c=5); insert cls1;
        Class__c cls2 = new Class__c(Name__c='Cls2', MaxSize__c=5); insert cls2;
        
        Student__c std = new Student__c(LastName__c='Student', Sex__c='Female',Class__c=cls1.Id); insert std;
        Student__c std1 = new Student__c(LastName__c='Student1', Sex__c='Female',Class__c=cls2.Id); stdLst.add(std1);
        Student__c std2 = new Student__c(LastName__c='Student2', Sex__c='Female',Class__c=cls1.Id); stdLst.add(std2);        
        insert stdLst;

        //When
        Test.startTest();
        WebsiteController wc = new WebsiteController(new ApexPages.StandardController(std));
        wc.stdName=std1.LastName__c;
        wc.fetchData();
        Test.stopTest();
        
        //Then
        System.assertEquals(std1.LastName__c, wc.stdData.LastName__c);
        
    }    
    

}