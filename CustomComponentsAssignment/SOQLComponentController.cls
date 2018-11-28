public class SOQLComponentController {
    
    public String stdQuery {get; set;}
    public String stdRecords {get; set;}
    public List<Student__c> stdLst {get; set;}
    public List<Student__c> stdLst2 {get{fetchRecord(); return stdLst;}set;}
    public String orderByLiteral = '';
    public Integer recordSize = 5;
    private String sortOrder = 'CreatedDate';
    public String ascendingOrDescending = ' ASC ';
    public Integer noOfRecords {get; set;}
    
    public ApexPages.StandardSetController setCon {get; set;}
    
    public SOQLComponentController(){
        this.orderByLiteral = ' ORDER BY ';
        this.sortOrder = 'CreatedDate'; 
    }    
    
    public void fetchRecord(){
        stdRecords = stdQuery + orderByLiteral + sortOrder + ascendingOrDescending;
        System.debug('query -> ' + stdRecords);
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(stdRecords));
        setCon.setPageSize(recordSize);
        noOfRecords = setCon.getResultSize();
        stdLst = (List<Student__c>)setCon.getRecords();
    }
    
    public void sortByID(){
        this.sortOrder = 'Id';
        this.ascendingOrDescending = ascendingOrDescending==' ASC '? ' DESC ': ' ASC ';
    }
    
    public void sortByFirstName(){
        this.sortOrder = 'First_Name__c';
        this.ascendingOrDescending = ascendingOrDescending==' ASC '? ' DESC ': ' ASC ';
    }
    
    public void sortByLastName(){
        this.sortOrder = 'LastName__c';
        this.ascendingOrDescending = ascendingOrDescending==' ASC '? ' DESC ': ' ASC ';
    }
    
    public void sortByAge(){
        this.sortOrder = 'Age__c'; 
        this.ascendingOrDescending = ascendingOrDescending==' ASC '? ' DESC ': ' ASC ';
    }
    
    
    public void sortBySex(){
        this.sortOrder = 'Sex__c';
        this.ascendingOrDescending = ascendingOrDescending==' ASC '? ' DESC ': ' ASC ';
    }
    
    public void next(){
        setCon.next();
        stdLst = (List<Student__c>)setCon.getRecords();
    }
    
    public void first(){
        setCon.first();
        stdLst = (List<Student__c>)setCon.getRecords();
    }
    
    public void previous(){
        setCon.previous();
        stdLst = (List<Student__c>)setCon.getRecords();
    }
    
    public void last(){
        setCon.last();
        stdLst = (List<Student__c>)setCon.getRecords();
    }

    public PageReference gotoStudent(){
        Id stdRecordId = ApexPages.currentPage().getParameters().get('rId');
        PageReference pgRef = new PageReference('/' + stdRecordId);
        pgRef.setRedirect(true);
        return pgRef;
    }
}