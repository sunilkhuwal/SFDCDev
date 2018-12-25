public class PurchaseOrderLineItemSelector extends fflib_SObjectSelector{

    public Schema.SObjectType getSObjectType(){
        return PurchaseOrderLineItem__c.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            PurchaseOrderLineItem__c.Id,
            PurchaseOrderLineItem__c.PurchaseOrder__c,
            PurchaseOrderLineItem__c.Smart_Pack__c,
           	PurchaseOrderLineItem__c.Quantity__c,
           	PurchaseOrderLineItem__c.Total_Price__c,
            PurchaseOrderLineItem__c.Unit_Price__c,
            PurchaseOrderLineItem__c.Items__c.Name
        };
    }
    
    public List<PurchaseOrderLineItem__c> selectById(Set<Id> idSet){
        return (List<PurchaseOrderLineItem__c>) selectSObjectsById(idSet);
    }
}
