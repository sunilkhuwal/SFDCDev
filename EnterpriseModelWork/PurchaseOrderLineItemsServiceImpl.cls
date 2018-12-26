public class PurchaseOrderLineItemsServiceImpl implements IPurchaseOrderLineItemsService
{
    public void addLineItem(Set<Id> polineItemIds, Id poId)
    {
        // Create unit of work to capture work and commit it under one transaction
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        
        // Query PurchaseOrder LineItem
        //List<PurchaseOrderLineItem__c> poLineRecords = 
          //  PurchaseOrderLineItemSelector.newInstance().selectByPOId(new Set<Id>{poId});
        
    }
    
}