trigger MaxLimitClass on Student__c (before insert, before update) {

    for(Student__c std : Trigger.new){
       //List<Student__c> stdLst = [select id, Class__r.maxSize__c from student__c WHERE Class__r.maxSize__c = 50 AND Id = :std.Id];
        List<Student__c> stdLst = [SELECT Id, Class__c FROM Student__c WHERE Class__c = :std.Class__c];
        Class__c cls = [SELECT Id, MaxSize__c FROM Class__c WHERE Id = :std.Class__c];
        if(stdLst.size() >= cls.MaxSize__c){
            std.addError('Cannot add more students to the same class, MaxSize limit reached !');
        }
    }
}