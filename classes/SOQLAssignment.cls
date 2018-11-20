public class SOQLAssignment{
  
    //Get the Student list by last name
    public static List<Student__c> getStudentListByLastName(String lastName){
        List<Student__c> studentList = new List<Student__c>();
        if(!String.isEmpty(lastName)){
          String firstLetter = lastName.substring(0, 1);            
            studentList = [SELECT Id, Name, First_Name__c, LastName__c, DOB__c, Sex__c 
                           FROM Student__c WHERE LastName__c LIKE :firstLetter + '%']; 
        }
        return studentList;
    }
    
    //Get the Student list by class name
    public static List<Student__c> getStudentListByClassName(String className){
        List<Student__c> studentList = new List<Student__c>();
        if(!String.isEmpty(className)){
          String firstLetter = className.substring(0, 1);            
            studentList = [SELECT Id, Name, First_Name__c, LastName__c, DOB__c, Sex__c, Class__c, Class__r.Name__c 
                           FROM Student__c WHERE Class__c IN 
                           (SELECT Id FROM Class__c WHERE Name__c LIKE :firstLetter + '%')]; 
        }
        return studentList;
    }
    
    //Get all the students and classes
    public static List<Class__c> getStudentClassList(){
        List<Class__c> classesList = new List<Class__c>();        
        classesList = [SELECT Id, Name, (SELECT Id, Name, First_Name__c from Students__r ) FROM Class__c];
        return classesList;
    }
    
    //Get all the classes with students in it
    public static List<Class__c> getClassWithStudentsList(){
        List<Class__c> classesList = new List<Class__c>();        
        classesList = [SELECT Id, Name, NumberOfStudents__c, (SELECT Id, Name, First_Name__c from Students__r ) FROM Class__c WHERE NumberOfStudents__c > 0];
        return classesList;
    }
    
    //Get the Students list who's age is greater than startYear like 2000
    public static List<Student__c> getStudentsByDOB(Integer startYear){
        List<Student__c> studentList = new List<Student__c>();
        Date startYearDate = Date.parse('12/31/' + String.valueOf(startYear));
        Date abc = Date.newInstance(2000, 1, 1);
        studentList = [SELECT Id, Name, DOB__c FROM Student__c WHERE  DOB__c > :startYearDate];
        System.debug('Students with date of birth: ' + studentList.size());
        return studentList;
    }
   
    //Get the list of Leads modified in the current month
    public static List<Lead> getLeadListByLastModifiedDateInCurrentMonth(){
        List<Lead> leadList = new List<Lead>();
      leadList = [SELECT Id, LastModifiedDate FROM Lead WHERE LastModifiedDate = THIS_MONTH];
        return leadList;
    }

  //Get the list of Classes with child students whos name start with given Name      
    public static List<Class__c> getClassesWithStudentsByStudentName(String studentName){
      List<Class__c> classList = new List<Class__c>();
        List<Student__c> studentList = new List<Student__c>();
        if(!String.isEmpty(studentName)){
            String firstLetter = studentName.substring(0, 1);
            classList = [SELECT Id, Name, (SELECT Id, Name FROM Students__r WHERE Name LIKE :firstLetter + '%') FROM Class__c];
        }
        return classList;
    }

    //Get list of Teachers by subject like Hindi and English
    //Ex. subjects = 'English;Hindi'
    public static List<Contact> getTeacherListBySubjects(String subjects){
        List<Contact> contactList = new List<Contact>();
        if(!String.isEmpty(subjects)){
            contactList = [SELECT Id, FirstName, LastName, Subjects__c FROM Contact WHERE Subjects__c = :subjects];                
            System.debug('List of Teachers with Subjects:  ' + contactList);
        }
        return contactList;
    }
    
    //Get the list of Students by subject names
    //Ex. Put subjects in list and send as paramater 'Hindi', 'English'
    public static List<Student__c> getStudentsWithSubjects(List<String> subjectList){
        List<Student__c> studentList = new List<Student__c>();
        if(!subjectList.isEmpty()){
          studentList = [SELECT Id, Name, Class__r.ClassTeacher__r.Subjects__c FROM Student__c WHERE Class__r.ClassTeacher__r.Subjects__c IN :subjectList];            
            System.debug('List of Students with Subjects: ' + studentList);
        }
        return studentList;
    }
}