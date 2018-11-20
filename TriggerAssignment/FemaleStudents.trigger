trigger FemaleStudents on Class__c (before delete) {
	
    for(Class__c cls : Trigger.old){
        List<Student__c> stdntLst = [SELECT Id FROM Student__c WHERE Sex__c = 'Female' AND Class__c = :cls.Id];
        if(stdntLst.size()>0){
            cls.addError('Class cannot be deleted there are female students still present in it.');
        }
    }
}