public class ApexAssignment {

    //This function will return the list of names of students for a particular class id provided
    public static List<String> getNamesOfStudentsInClass(Id classId){
		List<String> studentNameList = new List<String>();
        
        for(Student__c stud : [SELECT Id, Name, Class__c FROM Student__c WHERE Class__c = :classId]){
            studentNameList.add(stud.Name);            
        }
        return studentNameList;
    }
    
    public static Map<Class__c, Set<Id>> getMapOfClassStudent(){
        Map<Class__c, Set<Id>> classMap = new Map<Class__c, Set<Id>>();
        for(Class__c classKey : [SELECT Id, Name, (SELECT Id, Name FROM Students__r) FROM Class__c]){
            Set<Id> studentIdSet = new Set<Id>();
            for(Student__c student : classKey.Students__r){
              studentIdSet.add(student.Id);    
            }
            if(studentIdSet.size()>0)
              classMap.put(classKey, studentIdSet);
        }
        return classMap;
  }
  
    //This function will return the count of working days in between the two dates provide
    public static Integer getWorkingDaysInBetween(Date startDateValue, Date endDateValue){
        DateTime startDateTime = Datetime.newInstance(startDateValue.year(), startDateValue.month(),startDateValue.day()) + 1;
        DateTime endDateTime = Datetime.newInstance(endDateValue.year(), endDateValue.month(),endDateValue.day());
        Integer weekdayCounter = 0;
        Datetime dateTimeKey = startDateTime;
        String whichDay='';
        
        while(startDateTime < endDateTime && dateTimeKey < endDateTime){
            whichDay = dateTimeKey.format('EEEE');
            //Adding the day that is not falling on saturday or sunday
            if(!(whichDay == 'Saturday' || whichDay == 'Sunday')){
                weekdayCounter += 1;                
            }
            dateTimeKey += 1;
        }
        
    System.debug('Weekdays in between: ' + weekdayCounter + ' StartDate: ' + startDateValue + ' EndDate: ' + endDateValue);
        return weekdayCounter;
    }
}