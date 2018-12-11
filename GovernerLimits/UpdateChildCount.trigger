trigger UpdateChildCount on Account (After Insert, After delete, After update) {
    if(Trigger.isInsert){
        UpdateChildCountAccount.updateChildAccountCount(UpdateChildCountAccount.getAccountIds(Trigger.New));   
    }
    else if(Trigger.isUpdate || Trigger.isDelete){
        for(Account acc : Trigger.Old){
            UpdateChildCountAccount.updateChildAccountCount(UpdateChildCountAccount.getAccountIds(Trigger.Old));
        }
        if(Trigger.isUpdate){
            UpdateChildCountAccount.updateChildAccountCount(UpdateChildCountAccount.getAccountIds(Trigger.New));  
        }
    }    
    
}