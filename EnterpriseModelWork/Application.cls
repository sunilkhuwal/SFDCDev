public class Application 
{
    // Configure and create the UnitOfWorkFactory for this Application
    public static final fflib_Application.UnitOfWorkFactory UnitOfWork = 
        new fflib_Application.UnitOfWorkFactory( new List<SObjectType>
                                                {
                                                   PurchaseOrder__c.SObjectType,
                                                   PurchaseOrderlineItem__c.SObjectType
                                                });

    
    public static final fflib_Application.ServiceFactory Service = 
        new fflib_Application.ServiceFactory(
            new Map<Type, Type>{
                IPurchaseOrderLineItemsService.class => PurchaseOrderLineItemsServiceImpl.class
            }
        );
}