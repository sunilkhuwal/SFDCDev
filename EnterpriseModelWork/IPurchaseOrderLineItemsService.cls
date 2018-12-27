public interface IPurchaseOrderLineItemsService {

    void addLineItem(Set<Id> polineItemIds, Id poId);
    List<PurchaseOrderLineItem__c> getPOLineItemsByPO(Set<Id> poLineItemIdSet);
}