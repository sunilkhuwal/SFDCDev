@isTest
public class SOQLAssignmentTest {
  
    @testSetup static void setup() {
      
        //Create a new Lead
        Lead newLead = new Lead();
        newLead.FirstName = 'TestLead First Name';
        newLead.LastName = 'TestLead Last Name';
        newLead.Company = 'TestLead Company';
        insert newLead;

        //Creat a teacher record in Contact object
        Contact newTeacher = new Contact();
         newTeacher.FirstName = 'FirstNameTeacher';
        newTeacher.LastName = 'LastNameTeacher';
        newTeacher.Subjects__c = 'English';
        insert newTeacher;

        //Create a new class
        Class__c newClass = new Class__c();
        newClass.Name__c = 'English';
        newClass.ClassTeacher__c = newTeacher.Id;
        insert newClass;
         
        //Create a student record
        Student__c newStudent = new Student__c();
        newStudent.DOB__c = System.today() - 1000;
        newStudent.Email__c = 'sunil.kumar@metacube.com';
        newStudent.First_Name__c = 'TestFirstName';
        newStudent.LastName__c = 'TestLastName';
        newStudent.Name = 'TestFirstName TestLastName';
        newStudent.Class__c = newClass.Id;
        insert newStudent;
    }
    
    //Verify the method getStudentListByLastName    
    @isTest
    private static void getStudentListByLastNameTest(){
        List<Student__c> studentList = SOQLAssignment.getStudentListByLastName('TestLastName');
        System.assertEquals(1, studentList.size());
        System.assertEquals('TestLastName', studentList.get(0).LastName__c);
    }

    //Verify the method getStudentListByClassName
    @isTest
    private static void getStudentListByClassNameTest(){
        List<Student__c> studentList = SOQLAssignment.getStudentListByClassName('English');
        System.assertEquals(1, studentList.size());
        System.assertEquals('English', studentList.get(0).Class__r.Name__c);
    }

    //Verify the method getStudentClasList
    @isTest
    private static void getStudentClassListTest(){
        List<Class__c> classList = SOQLAssignment.getStudentClassList();
        System.assertEquals(1, classList.size());
        System.assertEquals('TestFirstName', classList.get(0).Students__r.get(0).First_Name__c);
    }
    
    //Verify the method getClassWithStudentsList
    @isTest
    private static void getClassWithStudentsListTest(){
        List<Class__c> classList = SOQLAssignment.getClassWithStudentsList();
        
        //Assert that there should be only one class
        System.assertEquals(1, classList.size());
        
        //Assert thtat there should be one student present in the class and student name should be 'TestFirstName'
        System.assertEquals(1, classList.get(0).Students__r.size());
        System.assertEquals('TestFirstName', classList.get(0).Students__r.get(0).First_Name__c);
    }

    //Verify that the getStudentsByDOB who are born after 2014 year
    @isTest
    private static void getStudentsByDOBTest(){
        List<Student__c> studentList = SOQLAssignment.getStudentsByDOB((System.today() - 1000).year() -1);

        //Assert that there should be one student record
        System.assertEquals(1, studentList.size());        
    }

    //Verify the method getLeadListByLastModifiedDateInCurrentMonth
    @isTest
    private static void getLeadListByLastModifiedDateInCurrentMonthTest(){
        List<Lead> leadList = SOQLAssignment.getLeadListByLastModifiedDateInCurrentMonth();
        
        //Assert that there should be one lead created
         System.assertEquals(1, leadList.size());
        System.assertEquals(System.today(), leadList.get(0).LastModifiedDate.date());        
    }

    //Verify the method getClassesWithStudentsByStudentName
    @isTest
    private static void getClassesWithStudentsByStudentNameTest(){        
        List<Class__c> classList = SOQLAssignment.getClassesWithStudentsByStudentName('TestFirstName');
        
        //Assert that there should be one class with one student
        System.assertEquals(1, classList.size());
        System.assertEquals(1, classList.get(0).Students__r.size());
    }

    //Verify the method getTeacherListBySubjects
    @isTest
    private static void getTeacherListBySubjectsTest(){
        List<Contact> teacherList = SOQLAssignment.getTeacherListBySubjects('English');
        
        //Assert that there should be a teacher with Hindi and english subjects
        System.assertEquals(1, teacherList.size());
        System.assertEquals('FirstNameTeacher', teacherList.get(0).FirstName);
    }

    //Verify the method getStudentsWithSubjects
    @isTest
    private static void getStudentsWithSubjectsTest(){
        List<String> subjectList = new List<String>{'English'};
        List<Student__c> studentList = SOQLAssignment.getStudentsWithSubjects(subjectList);
        
        //Assert that there should be one student with english subject
        System.assertEquals(1, studentList.size());
        System.assertEquals('TestFirstName TestLastName', studentList.get(0).Name);
    }
}