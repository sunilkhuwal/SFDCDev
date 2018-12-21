trigger UpdateChildCount on Account (After Insert, After delete, After update) {
    if(Trigger.isInsert){
        UpdateChildCountAccount.updateChildCountField(UpdateChildCountAccount.getAccountIds(Trigger.New));
    }
    else if(Trigger.isUpdate || Trigger.isDelete){
        UpdateChildCountAccount.updateChildCountField(UpdateChildCountAccount.getAccountIds(Trigger.Old));
        if(Trigger.isUpdate){
			UpdateChildCountAccount.updateChildCountField(UpdateChildCountAccount.getAccountIds(Trigger.New));
        }
    }
}
