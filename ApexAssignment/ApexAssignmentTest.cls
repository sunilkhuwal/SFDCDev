@isTest(isParallel=true)
public class ApexAssignmentTest {
    
    @isTest
    private static void getNamesOfStudentsInClassTest(){
        //Given
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
        secondTeacher.Subjects__c = 'Science';
        insert secondTeacher;
        
        //Creating second class
        Class__c secondClass = new Class__c();
        secondClass.Name__c = 'Science';
        secondClass.ClassTeacher__c = secondTeacher.Id;
        insert secondClass;

		//When
		Integer firstClassStudentSize = ApexAssignment.getNamesOfStudentsInClass(newClass.Id).size();
        Integer secondClassStudentSize = ApexAssignment.getNamesOfStudentsInClass(secondClass.Id).size();
        
        //Then
        //Assert that there should be one student present in the first class
        System.assertEquals(1, firstClassStudentSize);
        
        //Assert that there should be No student present in the second class
        System.assertEquals(0, secondClassStudentSize);        
    }
    
    @isTest
    private static void getIdsOfStudentsInClass(){
        //Given
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
        secondTeacher.Subjects__c = 'Science';
        insert secondTeacher;
        
        //Creating second class
        Class__c secondClass = new Class__c();
        secondClass.Name__c = 'Science';
        secondClass.ClassTeacher__c = secondTeacher.Id;
        insert secondClass;

        //When
		Integer firstClassStudentSize = ApexAssignment.getMapOfClassStudent().size();
        Integer secondClassStudentSize =  ApexAssignment.getNamesOfStudentsInClass(secondClass.Id).size();
        
        //Assert that there should be one student present in the first class
        System.assertEquals(1, firstClassStudentSize);
        
        //Assert that there should be No student present in the second class
        System.assertEquals(0, secondClassStudentSize);        
    }
    
    @isTest
    private static void getWorkingDaysInBetweenTest(){
        //Given
        Date startDate = Date.newInstance(2018, 6, 1);
        Date endDate = Date.newInstance(2018, 6, 30);
        
        //When
        Test.startTest();
        Integer workDays = ApexAssignment.getWorkingDaysInBetween(startDate, endDate);
        Test.stopTest();
        
        //Then
        System.assertEquals(20, workDays);
    }
    
    @isTest
    private static void getWorkingDaysInBetweenInvalidTest(){
        //Given
        Date startDate = Date.newInstance(2018, 6, 30);
        Date endDate = Date.newInstance(2018, 6, 1);
        String expectedErrorMessage = 'Start Date cannot be greater than End Date';
        String errorMessage = '';
        
        //When
        try{
            Test.startTest();
            ApexAssignment.getWorkingDaysInBetween(startDate, endDate);
            Test.stopTest();    
        }
        catch(Exception e){
            errorMessage =  e.getMessage();
        }
        
        //Then
        System.assertEquals(expectedErrorMessage, errorMessage);
    }
}