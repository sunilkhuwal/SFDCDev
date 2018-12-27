public interface IPurchaseOrderLineItemSelector extends fflib_ISObjectSelector {

    List<PurchaseOrderLineItem__c> selectByPOId(Set<Id> poLineIdSet);
}