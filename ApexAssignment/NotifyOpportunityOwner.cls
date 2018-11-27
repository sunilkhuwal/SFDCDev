global class NotifyOpportunityOwner implements Schedulable{
    public List<Opportunity> Opportunitylist;
    
	//Get the list of Opportunities whos modification is older than 30 days 
       	public NotifyOpportunityOwner(){
         Opportunitylist = [SELECT Id, Name, LastModifiedDate, CloseDate,
                                      Account.name, owner.email, owner.name FROM Opportunity 
                                      WHERE  LastModifiedDate < :System.today()-30];
    }

    //Notify the Owners of Opportunities
    global void execute(System.SchedulableContext sc){
		list<String> FirstRemainderEmails = new list<string>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        list<Opportunity> OpportunityToUpdate = new list<Opportunity>();
        System.debug('Opportunitylist ******** ' + Opportunitylist);
        for(Opportunity opp : Opportunitylist){
            String OwnerName = opp.Owner.name;
            FirstRemainderEmails.add(opp.owner.email);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { opp.owner.email})  ;               
            mail.setSubject('Your opportunity record is not updated from last 30 days');
            String messageBody ='<html><body><p>Dear '+ OwnerName +',<br/><br/>'+
                '</body></html>';
            mail.setHtmlBody(messageBody);    
            mails.add(mail);
            if(!mails.isEmpty()){
                if(mails.size()<10)
                	Messaging.SendEmail(mails);
            }
        }
    }
}