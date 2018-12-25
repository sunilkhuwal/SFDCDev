public class PurchaseOrderSelector extends fflib_SObjectSelector {
    
    public Schema.SObjectType getSObjectType(){
        return PurchaseOrder__c.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            PurchaseOrder__c.Id,
            PurchaseOrder__c.Name };     
	}
    
    //Seleting Purchase order only
    public List<PurchaseOrder__c> selectById(Set<Id> idSet){
        return (List<PurchaseOrder__c>) selectSObjectsById(idSet);
    }

    //Selecting the Purchase Order along with purchase order line items
    public List<PurchaseOrder__c> selectByIdsWithChildren(Set<Id> idSet){
        
        fflib_QueryFactory poQueryFactory = newQueryFactory();        
        poQueryFactory.subselectQuery('PurchaseOrderLineItems__r', true)
            .selectFields(new PurchaseOrderLineItemSelector().getSObjectFieldList());        
        
		return (List<PurchaseOrder__c>) Database.query(
            poQueryFactory.setCondition('id in :idSet').toSOQL());
    }    
}

/*
        qf.selectFields(new List<String>{
            'PurchaseOrderLineItems__r.Smart_Pack__c',
            'PurchaseOrderLineItems__r.Quantity__c',
            'PurchaseOrderLineItems__r.Unit_Price__c',
            'PurchaseOrderLineItems__r.Total_Price__c',
            'PurchaseOrderLineItems__r.Items__r.Item_Name__c'
        }).setCondition('Id in :idSet');
        
        for (Schema.ChildRelationship childRow : PurchaseOrder__c.SObjectType.getDescribe().getChildRelationships())
		{
            if (childRow.getRelationshipName() == 'PurchaseOrderLineItems__r')
            {
            	fflib_QueryFactory subQuery = qf.subselectQuery(childRow, true).setLimit(1);
                subQuery.selectFields(new List<String>{'Id'});
            }
        }
*/
