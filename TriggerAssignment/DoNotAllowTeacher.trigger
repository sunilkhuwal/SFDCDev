trigger DoNotAllowTeacher on Contact (before insert, before update) {

    for(Contact c : Trigger.new){
        if(c.Subjects__c!=Null && c.Subjects__c.contains('Hindi')){
			c.addError('Cannot insert/update a teacher with Maths');
        }
    }    
}