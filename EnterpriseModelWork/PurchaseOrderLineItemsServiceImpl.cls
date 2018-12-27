public class PurchaseOrderLineItemsServiceImpl implements IPurchaseOrderLineItemsService
{
    public void addLineItem(Set<Id> polineItemIds, Id poId)
    {
        // Create unit of work to capture work and commit it under one transaction
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        
        // Query Opportunities
        //List<PurchaseOrderLineItem__c> poLineRecords = 
          //  PurchaseOrderLineItemSelector.newInstance().selectByPOId(new Set<Id>{poId});
        
        // Apply discount via Opportunties domain class behaviour
        //IOpportunities opps = Opportunities.newInstance(oppRecords);				
        //opps.applyDiscount(discountPercentage, uow);
        
        // Commit updates to opportunities		
        uow.commitWork();
        
    }
    
    public List<PurchaseOrderLineItem__c> getPOLineItemsByPO(Set<Id> poLineItemIdSet)
    {        
		List<PurchaseOrderLineItem__c> poLineList = PurchaseOrderLineItemSelector.newInstance().selectByPOId(poLineItemIdSet);
        
        return poLineList;
    }
}