public class UpdateChildCountAccount {
    
    public static Set<Id> getAccountIds(List<Account> records){
        Set<Id> accIds = new Set<Id>();
        for(Account ac : records){
            accIds.add(ac.Parent_Account__c);
        }
		return accIds;  
    }
    
    public static void updateChildAccountCount(Set<Id> idSets){
        List<Account> accLst = [SELECT Id, Child_Count__c FROM Account WHERE Id IN :idSets];
        Map<Id, Account> accMap = new Map<Id, Account>();
        for(Account a : accLst){
            accMap.put(a.Id, a);
        }

        List<AggregateResult> aggrgRslt = [SELECT COUNT(Parent_Account__c) childSum, Parent.Id FROM Account WHERE Parent_Account__c IN :idSets GROUP BY Parent.Id];
        for(AggregateResult result: aggrgRslt){
            System.debug('Parent Id: ' + result.get('parent.Id'));
            Integer childSum = (Integer)result.get('childSum');
            Account tempAcc = accMap.get((Id)result.get('parent.Id'));
            tempAcc.Child_Count__c = (Integer)result.get('childSum');
            accMap.put((Id)result.get('parent.Id'), tempAcc);
        }
        
        try{
            update accMap;
        }
        catch(DMLException e){
            System.debug('All Accounts :-'+accounts);
        }
    }
}