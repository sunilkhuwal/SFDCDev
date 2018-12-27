public class PurchaseOrderLineItemSelector extends fflib_SObjectSelector implements IPurchaseOrderLineItemSelector
{

    public Schema.SObjectType getSObjectType(){
        return PurchaseOrderLineItem__c.SObjectType;
    }

	public static IPurchaseOrderLineItemSelector newInstance()
    {
        return (IPurchaseOrderLineItemSelector) Application.Selector.newInstance(PurchaseOrderLineItem__c.SObjectType);
    }
        
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            PurchaseOrderLineItem__c.Id,
            PurchaseOrderLineItem__c.PurchaseOrder__c,
            PurchaseOrderLineItem__c.Smart_Pack__c,
           	PurchaseOrderLineItem__c.Quantity__c,
           	PurchaseOrderLineItem__c.Total_Price__c,
            PurchaseOrderLineItem__c.Unit_Price__c,
            PurchaseOrderLineItem__c.Items__c
        };
    }
    
    public List<PurchaseOrderLineItem__c> selectById(Set<Id> idSet){
        return (List<PurchaseOrderLineItem__c>) selectSObjectsById(idSet);
    }
    
    public List<PurchaseOrderLineItem__c> selectByPOId(Set<Id> poIdSet)
    {
        fflib_QueryFactory poLineQueryFactory = newQueryFactory();
        poLineQueryFactory.selectFields(getSObjectFieldList());
        
        return (List<PurchaseOrderLineItem__c>) Database.query(
            poLineQueryFactory.setCondition('PurchaseOrder__c IN :poIdSet')
            .toSOQL());
    }
}