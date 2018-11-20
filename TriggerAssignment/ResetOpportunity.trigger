trigger ResetOpportunity on Opportunity (after update) {
    String oppStatusReset = 'Reset';
    for(Opportunity opp : Trigger.Old){
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        Boolean oldOppStatus = oldOpp.Custom_Status__c == oppStatusReset;
        Boolean newOppStatus = opp.Custom_Status__c == oppStatusReset;
        
        if(!oldOppStatus && newOppStatus)
            delete [SELECT Id FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];
    }
}