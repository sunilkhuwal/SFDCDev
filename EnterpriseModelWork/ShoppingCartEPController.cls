public class ShoppingCartEPController {
    
    public void getPurchaseOrders(){
        PurchaseOrderSelector poSelector = new PurchaseOrderSelector();
        List<PurchaseOrder__c> poList = poSelector.selectByIdsWithChildren(new Set<Id>{'a0E0K00000wB12FUAS', 'a0E0K00000w9xj2UAA'});
        
        if(poList != NULL && !poList.isEmpty()){
            for(PurchaseOrder__c po : poList){
                System.debug('po -> ' + po.Id);
                System.debug('PO full' + po);
            }
            
        }    
    }
}

