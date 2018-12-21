public class UpdateChildCountAccount {
    
    public static Set<Id> getAccountIds(List<Account> records){
        Set<Id> accIds = new Set<Id>();
        for(Account ac : records){
            accIds.add(ac.Parent_Account__c);
        }
        return accIds;  
    }
    
    public static void updateChildAccountCount(Set<Id> idSet){
        
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
    
    public static void updateChildCountField(Set<Id> accIdSet){
        
        AggregateResult[] results = [SELECT COUNT(Id) childCount, Parent_Account__c parentAccount FROM Account  WHERE Parent_Account__c IN :accIdSet GROUP BY parent_account__c];
        List<Account> accLst = new List<Account>();
        List<Account> accUpdateLst = [SELECT Id, Child_Count__c FROM Account WHERE Id IN :accIdSet];
        
        for(AggregateResult a : results){
            Account tempAccount = new Account(); 
            if(a.get('parentAccount') != NULL){
                tempAccount.Id = (Id)a.get('parentAccount');
                System.debug('Child Count - ' + a.get('childCount'));
                tempAccount.Child_Count__c = (Decimal)a.get('childCount');
                accLst.add(tempAccount);    
            }            
        }
        
        if(accLst.size()>0){
            update accLst;    
        }
    }
    
    public static void updateChildAccountCountByMap(List<Account> records, Boolean isRecordNew){
        Set<Id> accIds = new Set<Id>();
        for(Account ac : records){
            accIds.add(ac.Id);
        }
        
        List<Account> accountLst = new List<Account>();
        
        Map<Id, List<Account>> accountWiseCountMap = new Map<Id, List<Account>>();
        List<Account> accountsList = [SELECT Id, Name, Parent_Account__c, Child_Count__c FROM Account WHERE Id IN :accIds];
        
        for(Account ac : accountsList){
            if(accountWiseCountMap.containsKey(ac.Parent_Account__c)){
                System.debug('Existing --> Account name -> ' + ac.Name + ' Parent Id: '  + ac.Parent_Account__c);
                List<Account> accAddList = accountWiseCountMap.get(ac.Parent_Account__c);
                accAddList.add(ac);
                accountWiseCountMap.put(ac.Parent_Account__c, accAddList);
            } else {
                System.debug('New --> Account name -> ' + ac.Name + ' Parent Id: '  + ac.Parent_Account__c);
                accountWiseCountMap.put(ac.Parent_Account__c, new List<Account>{ac});
            }
        }  
        
        List<Account> accountretrieveFromMapList = [SELECT Id, Child_Count__c FROM Account WHERE Id IN :accountWiseCountMap.keySet()]; 
        for(Account accc : accountretrieveFromMapList){
            if(accountWiseCountMap.containsKey(accc.Id)){
                List<Account> updatingAccountList = new List<Account>();
                updatingAccountList = accountWiseCountMap.get(accc.Id);
                System.debug('Child count ->' + updatingAccountList.size());
                if(isRecordNew){
                    accc.Child_Count__c += updatingAccountList.size();    
                }
                else{
                    accc.Child_Count__c -= updatingAccountList.size();
                }
                
                
                accountLst.add(accc);
            }
        }
        
        if(accountLst.size()>0){
            update accountLst;    
        }
    }
}