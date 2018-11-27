@isTest
public class ApexAssignmentTest {

    @isTest
    private static void getNamesOfStudentsInClassTest(){
        Contact newTeacher;
		Class__c newClass;
		Student__c newStudent;
        
        //Creat a teacher record in Contact object
        newTeacher = new Contact();
         newTeacher.FirstName = 'FirstNameTeacher';
        newTeacher.LastName = 'LastNameTeacher';
        newTeacher.Subjects__c = 'English';
        insert newTeacher;

        //Create a new class
        newClass = new Class__c();
        newClass.Name__c = 'English';
        newClass.ClassTeacher__c = newTeacher.Id;
        insert newClass;
         
        //Create a student record
        newStudent = new Student__c();
        newStudent.DOB__c = System.today() - 1000;
        newStudent.Email__c = 'sunil.kumar@metacube.com';
        newStudent.First_Name__c = 'TestFirstName';
        newStudent.LastName__c = 'TestLastName';
        newStudent.Name = 'TestFirstName TestLastName';
        newStudent.Class__c = newClass.Id;
        insert newStudent;

        //Creat a teacher record in Contact object
        Contact secondTeacher = new Contact();
         secondTeacher.FirstName = 'secondTeacher';
        secondTeacher.LastName = 'secondTeacherLast Name';
        secondTeacher.Subjects__c = 'Hindi';
        insert secondTeacher;
        
        //Creating second class
        Class__c secondClass = new Class__c();
        secondClass.Name__c = 'Hindi';
        secondClass.ClassTeacher__c = secondTeacher.Id;
        insert secondClass;
        
        //Assert that there should be one student present in the first class
        System.assertEquals(1, ApexAssignment.getNamesOfStudentsInClass(newClass.Id).size());
        
        //Assert that there should be No student present in the second class
        System.assertEquals(0, ApexAssignment.getNamesOfStudentsInClass(secondClass.Id).size());        
    }

  @isTest
    private static void getIdsOfStudentsInClass(){
        Contact newTeacher;
		Class__c newClass;
		Student__c newStudent;
        
        //Creat a teacher record in Contact object
        newTeacher = new Contact();
         newTeacher.FirstName = 'FirstNameTeacher';
        newTeacher.LastName = 'LastNameTeacher';
        newTeacher.Subjects__c = 'English';
        insert newTeacher;

        //Create a new class
        newClass = new Class__c();
        newClass.Name__c = 'English';
        newClass.ClassTeacher__c = newTeacher.Id;
        insert newClass;
         
        //Create a student record
        newStudent = new Student__c();
        newStudent.DOB__c = System.today() - 1000;
        newStudent.Email__c = 'sunil.kumar@metacube.com';
        newStudent.First_Name__c = 'TestFirstName';
        newStudent.LastName__c = 'TestLastName';
        newStudent.Name = 'TestFirstName TestLastName';
        newStudent.Class__c = newClass.Id;
        insert newStudent;

        //Creat a teacher record in Contact object
        Contact secondTeacher = new Contact();
         secondTeacher.FirstName = 'secondTeacher';
        secondTeacher.LastName = 'secondTeacherLast Name';
        secondTeacher.Subjects__c = 'Hindi';
        insert secondTeacher;
        
        //Creating second class
        Class__c secondClass = new Class__c();
        secondClass.Name__c = 'Hindi';
        secondClass.ClassTeacher__c = secondTeacher.Id;
        insert secondClass;
        
        //Assert that there should be one student present in the first class
        System.assertEquals(1, ApexAssignment.getMapOfClassStudent().size());
        
        //Assert that there should be No student present in the second class
        //System.assertEquals(0, ApexAssignment.getNamesOfStudentsInClass(secondClass.Id).size());        
    }
    
    @isTest
    private static void getWorkingDaysInBetweenTest(){
        //Asserting the working days
        System.assertEquals(20, ApexAssignment.getWorkingDaysInBetween(Date.newInstance(2018, 6, 1), Date.newInstance(2018, 6, 30)));
    }
}