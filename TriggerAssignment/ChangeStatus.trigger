trigger ChangeStatus on Opportunity (before update, after update) {
    if(Trigger.isBefore){
        for(Opportunity opp : Trigger.New){
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
            if(opp.StageName != oldOpp.StageName && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')){
                opp.CloseDate = System.today();
            }
        }
    }
}