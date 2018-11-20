public class AccountExtController{
    
    public List<Account> accLst {get; set;}
    public Account acc {get; set;}
    public String billCity {get; set;}
    public String billState {get; set;}
    public String billCountry {get; set;}
    public Integer size {get; set;}
    public ApexPages.StandardSetController setCon {get; set;}

    public AccountExtController(ApexPages.StandardController con) {
        String sSOQL = 'SELECT Name, BillingCity, BillingState, BillingCountry FROM Account';
        fetchRecords(sSOQL);
    }
    
    public void fetchRecords(String soqlString){
        size=5;
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(soqlString));
        setCon.setPageSize(size);
        accLst = (List<Account>) setCon.getRecords();        
    }
    
    public void filter(){
        String sSOQL = 'SELECT Name, BillingCity, BillingState, BillingCountry FROM Account WHERE Name != NULL ';
        
        if(String.isNotEmpty(billCity)){
            sSOQL += ' AND BillingCity = :billCity';
            System.debug(sSOQL);
        }
        if(String.isNotEmpty(billCountry)){
            sSOQL += ' AND BillingCountry = :billCountry';
        }
        if(String.isNotEmpty(billState)){
            sSOQL += ' AND BillingState = :billState';
        }        
        sSOQL += ' LIMIT 100';
        
        fetchRecords(sSOQL);
    }

    public void previous(){
      setCon.previous();
        accLst = (List<Account>)setCon.getRecords();
    }

    public void next(){
     setCon.next();
        accLst = (List<Account>)setCon.getRecords();
    }

    public void first(){
        setCon.first();
        accLst = (List<Account>)setCon.getRecords();
    }    

    public void last(){
        setCon.last();
        accLst = (List<Account>)setCon.getRecords();
    }
    public List<Account> getAllAccountRecords(){
        return accLst;
    }
}