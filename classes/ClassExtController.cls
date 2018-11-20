public class ClassExtController {
    
    public Id classId {get; set;}
    public Boolean showGrid {get; set;}
    public Class__c classRecord {get; set;}
    
    public ClassExtController(ApexPages.StandardSetController controller){
        showGrid = false;
    }

    public void editClass(){
        showGrid = true;
        System.debug('classId======'+ classId);
        classRecord = [SELECT Id, Name__c, ClassTeacher__c, DetailedDescription__c, Board__c, MyCount__c, Fee__c, MaxSize__c FROM Class__c WHERE Id = :classId];
    }

    public PageReference deleteClass(){
        delete [SELECT Id, Name, Name__c, ClassTeacher__c, DetailedDescription__c, Board__c, MyCount__c, Fee__c, MaxSize__c FROM Class__c WHERE Id = :classId];

        pageReference pageRef = new PageReference('/apex/ManageClass');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference saveData(){
        update classRecord;
        
        PageReference pageRef = new PageReference('/apex/ManageClass');
        pageRef.setredirect(true);
        return pageRef;
    }
}