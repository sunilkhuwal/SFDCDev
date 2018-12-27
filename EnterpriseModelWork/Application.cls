public class Application 
{
    // Configure and create the UnitOfWorkFactory for this Application
    public static final fflib_Application.UnitOfWorkFactory UnitOfWork = 
        new fflib_Application.UnitOfWorkFactory( 
            new List<SObjectType>
            {
                PurchaseOrder__c.SObjectType,
                PurchaseOrderlineItem__c.SObjectType
            });

    // Configure and create  the ServiceFactory for this application
    public static final fflib_Application.ServiceFactory Service = 
        new fflib_Application.ServiceFactory(
            new Map<Type, Type>{
                IPurchaseOrderLineItemsService.class => PurchaseOrderLineItemsServiceImpl.class
            });
    
    // Configure and create the SelectorFactory for this Application
	public static final fflib_Application.SelectorFactory Selector = 
        new fflib_Application.SelectorFactory(
            new Map<SObjectType, type>
            {
                PurchaseOrder__c.SObjectType => PurchaseOrderSelector.class,
               PurchaseOrderLineItem__c.SObjectType => PurchaseOrderLineItemSelector.class
               
            });
}