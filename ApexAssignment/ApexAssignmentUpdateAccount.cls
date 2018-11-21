public class ApexAssignmentUpdateAccount {

    public static void checkContact(Id conId){
        String str = '';
        Contact con = [SELECT Id, AccountId FROM Contact WHERE Id = :conId];
        Account account = [SELECT Id, ContactIDs__c FROM Account WHERE Id = :con.AccountId];

        if(account.ContactIDs__c == null){
            for(Contact innerCon : [SELECT Id, AccountId FROM Contact WHERE accountId = :account.Id]){
                str =  innerCon.Id + ',' + str;
            }
            account.ContactIDs__c = str;
        }else{
            if(!account.ContactIDs__c.contains(conId)){
                account.ContactIDs__c = account.ContactIDs__c + ',' + conId;
            }
        }
        update account;        
    }
  
    public static void updateOpportunity(List<Opportunity> oppLst){
    	for(Opportunity op :oppLst){
        	if(op.BillToContact__c!= NULL && op.Manager__c == NULL){
            	Contact con = [SELECT AccountId FROM Contact WHERE Id  = :op.BillToContact__c];
                if(con.AccountId != null){
                    op.Manager__c = con.AccountId;
                    update op;
                }
        	}
        }
    }
}