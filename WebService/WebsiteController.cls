public class WebsiteController {
    
    public List<SelectOption> stdOptions {get;set;}
    public Student__c stdData {get;set;}
    public String stdName {get;set;}

    public WebsiteController(ApexPages.StandardController controller)
    {
        stdData = [SELECT Id, Name, First_Name__c, LastName__c, Dob__c, Sex__c, Email__c FROM Student__c LIMIT 1];
        stdOptions = new List<SelectOption>{};

        for(Student__c s : [SELECT LastName__c FROM Student__c])
        {
            stdOptions.add(new SelectOption(s.LastName__c, s.LastName__c));
        }
    }
    
    public void fetchData()
    {   
        stdData = [SELECT Id, Name, First_Name__c, LastName__c, Dob__c, Sex__c, Email__c FROM Student__c WHERE LastName__c = :stdName LIMIT 1];
    }
}