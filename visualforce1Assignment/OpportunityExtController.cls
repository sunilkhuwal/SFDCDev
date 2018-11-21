public class OpportunityExtController
{
    public Id selectedValue {get; set;}
    public List<Contact> conList {get; set;}
    public Opportunity opp ;
    public Id oppId;
    
    public OpportunityExtController(ApexPages.StandardController controller){
        oppId = ApexPages.currentPage().getParameters().get('oppId');
        opp = [SELECT Id, Manager__c FROM Opportunity WHERE Id = :oppId];
        conList = [SELECT Id, Name, Account.Name, Subjects__c FROM Contact WHERE Account.Id = :opp.Manager__c];
    }
    
    public void getSelected(){
        selectedValue = ApexPages.currentPage().getParameters().get('conId');
        System.debug('OpportunityExtController Controller=====selectedValue - ' + selectedValue);
    }
    
    public PageReference saveData(){
        opp.BillToContact__c = selectedValue;
        update opp;
        PageReference pageRef = new PageReference('/'+oppId+'?a='+selectedValue);
        pageRef.setredirect(true);
        return pageRef;
    }
    
    public PageReference clearData(){
        opp.BillToContact__c = NULL;
        update opp;
        
        PageReference pageRef = new PageReference('/'+oppId);
        pageRef.setredirect(true);
        return pageRef;
    }
    
    public PageReference cancelData(){
        PageReference pageRef = new PageReference('/'+oppId);
        pageRef.setredirect(true);
        return pageRef;
    }
}