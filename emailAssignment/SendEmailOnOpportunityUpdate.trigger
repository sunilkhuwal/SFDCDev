trigger SendEmailOnOpportunityUpdate on Opportunity (after update) {

    for(Opportunity op : Trigger.New){
        if(Trigger.oldMap.get(op.Id).Custom_Status__c != Trigger.newMap.get(op.Id).Custom_Status__c){
            SendEmailToApplicant.sendEmailToApplicant(new String[]{'abc.text@gmail.com'}, 'Test Email', 'Email message content', 'OpportunityUpdated');
        }
    }
}