trigger UpdateOpp on Opportunity (after update) {
	List<Opportunity> oppLst = [SELECT Id, Manager__c, BillToContact__c FROM Opportunity WHERE Id IN :trigger.newMap.keySet()];
     ApexAssignmentUpdateAccount.updateOpportunity(oppLst);    
}