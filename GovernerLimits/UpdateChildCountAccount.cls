public class UpdateChildCountAccount {
    
    public static Set<Id> getAccountIds(List<Account> records){
        Set<Id> accIds = new Set<Id>();
        for(Account ac : records){
            accIds.add(ac.Parent_Account__c);
        }
		return accIds;  
    }
    
    public static void updateChildAccountCount(Set<Id> idSet){
        List<Account> updateList = new List<Account>();
        List<Account> accounts = [SELECT Id, Parent_Account__c, Parent_Account__r.Name, Child_Count__c FROM Account WHERE Id IN :idSet];
        for(Account a : accounts){
            List<Account> act = [SELECT Id FROM Account WHERE Parent_Account__c = :a.Id];
            a.Child_Count__c = act.size();            
        }
        try{
            update accounts;
        }
        catch (DmlException d){
            System.debug('All Accounts :-'+accounts);
        }
    }
}