public class DeleteStudentController {
    public List<Student__c> stdList {get;set;}
    public String serialisedList {get;set;}
    
    public DeleteStudentController(ApexPages.StandardSetController setCon){
        setCon.addFields(new List<String>{'Id', 'First_Name__c', 'LastName__c', 'Age__c'});
        stdList = (List<Student__c>)setCon.getSelected();
        serialisedList = JSON.serialize(stdList);

        if(stdList.isEmpty()){
            ApexPages.Message myMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Records Found.');
            Apexpages.addMessage(myMessage);
        }
    }
}