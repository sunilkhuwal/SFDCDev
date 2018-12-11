public class OppExtController {

    public List<AggregateResult> oppLst {get; set;}
    
    public OppExtController(ApexPages.StandardSetController controller){
        oppLst = [SELECT SUM(Amount) amount, Account.Name act FROM Opportunity GROUP BY Account.Name LIMIT 10];
    }
}