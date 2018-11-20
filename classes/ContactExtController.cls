public class ContactExtController{
    
    public Contact con {get; set;}
    public String jsonString {get; set;}
    public Id conId;
   
    public ContactExtController(ApexPages.StandardController controller){
        conId = ApexPages.currentPage().getParameters().get('conId');
        con = [SELECT Id, Name, Account.Name, Subjects__c FROM Contact WHERE Id = :conId];
        jsonString = JSON.serialize(con);
    }
}