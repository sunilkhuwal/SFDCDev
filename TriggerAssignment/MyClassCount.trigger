trigger MyClassCount on Student__c (after insert, after update, after delete) {
    Class__c cls;
    List<Student__c> stdLst;
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Student__c s : Trigger.Old){
            cls = [SELECT Id, MyCount__c FROM Class__c WHERE Id = :s.Class__c];
            stdLst = [SELECT Id FROM Student__c WHERE Class__c = :cls.Id];
            cls.MyCount__c = stdLst.size();
            update cls;
        }
        if(Trigger.isUpdate){
            for(Student__c s : Trigger.New){
                cls = [SELECT Id, MyCount__c FROM Class__c WHERE Id = :s.Class__c];
                stdLst = [SELECT Id FROM Student__c WHERE Class__c = :cls.Id];
                cls.MyCount__c = stdLst.size();   
                update cls;
            }
        }
    } else{
        for(Student__c s : Trigger.New){
            cls = [SELECT Id, MyCount__c FROM Class__c WHERE Id = :s.Class__c];
            stdLst = [SELECT Id FROM Student__c WHERE Class__c = :cls.Id];
            cls.MyCount__c = stdLst.size();  
            update cls;
        }
    }
}