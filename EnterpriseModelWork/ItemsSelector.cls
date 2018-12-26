public class ItemsSelector extends fflib_SObjectSelector 
{
    public Schema.SObjectType getSObjectType()
    {
        return Item__c.SObjectType;
    }
    
    public  List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Item__c.Id,
            Item__c.Item_Name__c,
            Item__c.Type__c,
            Item__c.Unit_Price__c            
        };
    }
        
	public List<Item__c> selectById(Set<Id> idSet)
    {
        return (List<Item__c>) selectSObjectsById(idSet);
    }
}