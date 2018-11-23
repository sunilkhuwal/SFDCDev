public class ShoppingCartController {
    
    public List<PurchaseOrderLineItem__c> poLineList;
    public PurchaseOrder__c purchaseOrder {get; private set;}
    public Id purchaseOrderId {get; private set;}
    public Id deleteId {get; set;}
    public Id addItemLineId {get; set;}
    public List<Item__c> itemList;
    public List<Id> poLineItemsIdList;
    
    public List<PurchaseOrderLineItem__c> getPOLineItems(){
        poLineList = [SELECT Id, Name, Items__r.Item_Name__c, PurchaseOrder__c, Smart_Pack__c, Quantity__c, Total_Price__c,
                      Unit_Price__c FROM PurchaseOrderLineItem__c WHERE PurchaseOrder__c = :purchaseOrderId];
        return poLineList;
    }

    public ShoppingCartController(){
        purchaseOrderId = ApexPages.currentPage().getParameters().get('purchaseOrderId');
        purchaseOrder = [SELECT Id, Name FROM PurchaseOrder__c WHERE Id = :purchaseOrderId];
    }

    public List<Item__c> getItems(){
		itemList = [SELECT Id, Item_Name__c, Type__c, Unit_Price__c  FROM Item__c];
        return itemList;
    }

    public Id purchaseOrderId(){
    	
        return purchaseOrder.Id;
    }

    public void addLineItem(){
        System.debug('-=====- line item adding: ' + addItemLineId);
        List<PurchaseOrderLineItem__c> tempPOLineItemList = [SELECT Id, Name, Items__r.Item_Name__c, PurchaseOrder__c, Smart_Pack__c, Quantity__c, Total_Price__c,
                      Unit_Price__c FROM PurchaseOrderLineItem__c WHERE PurchaseOrder__c = :purchaseOrderId AND Items__c = :addItemLineId];
        
        if(tempPOLineItemList.size()>0){
            tempPOLineItemList.get(0).Quantity__c += 1;
        }
        else{
         	PurchaseOrderLineItem__c tempPOLine = new PurchaseOrderLineItem__c();
            tempPOLine.Items__c = addItemLineId;
            tempPOLine.PurchaseOrder__c = purchaseOrderId;
            tempPOLine.Quantity__c = 1;
            
            tempPOLineItemList.add(tempPOLine);
        }
        upsert tempPOLineItemList;
    }   

    public void deleteLineItem(){
        System.debug('-=====- line item adding: ' + deleteId);
        delete [SELECT Id FROM PurchaseOrderLineItem__c WHERE Id = :deleteId];
    }
}