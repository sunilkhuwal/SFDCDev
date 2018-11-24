@isTest
public class ShoppingCartControllerTest {

    static testMethod void addFunctionality(){
        Item__c it = new Item__c(Item_Name__c='Black shoes', Type__c='Shoes',   Unit_Price__c=200); insert it;
        Item__c it2 = new Item__c(Item_Name__c='Brown shoes', Type__c='Shoes',   Unit_Price__c=300); insert it2;
        PurchaseOrder__c po = new PurchaseOrder__c(); insert po;
        PurchaseOrderLineItem__c poLine = new PurchaseOrderLineItem__c(PurchaseOrder__c=po.Id,   Items__c=it.Id, Quantity__c=2, Smart_Pack__c=true); insert poLine;
        
        Apexpages.StandardController stdCon = new ApexPages.StandardController(po);
        ShoppingCartController shopCon = new ShoppingCartController(stdCon);
        shopCon.purchaseOrderId = po.Id;
        shopCon.addItemLineId = it.Id;
        shopCon.addLineItem();
        List<PurchaseOrderLineItem__c> verifyLineList = [SELECT Id, Quantity__c, Smart_Pack__c FROM PurchaseOrderLineItem__c where PurchaseOrder__c = :po.Id];
        System.assertEquals(1, verifyLineList.size());
        System.assertEquals(3, verifyLineList.get(0).Quantity__c);

        shopCon.addItemLineId = it2.Id;
        shopCon.addLineItem();
        verifyLineList.clear();
        verifyLineList = [SELECT Id, Quantity__c, Smart_Pack__c FROM PurchaseOrderLineItem__c where PurchaseOrder__c = :po.Id];
        System.assertEquals(2, verifyLineList.size());
        System.assertEquals(3, verifyLineList.get(0).Quantity__c);
        System.assertEquals(1, verifyLineList.get(1).Quantity__c);
    }
    
    static testMethod void deleteFunctionality(){
        Item__c it = new Item__c(Item_Name__c='Black shoes', Type__c='Shoes',   Unit_Price__c=200); insert it;
        Item__c it2 = new Item__c(Item_Name__c='Brown shoes', Type__c='Shoes',   Unit_Price__c=300); insert it2;
        PurchaseOrder__c po = new PurchaseOrder__c(); insert po;
        PurchaseOrderLineItem__c poLine = new PurchaseOrderLineItem__c(PurchaseOrder__c=po.Id,   Items__c=it.Id, Quantity__c=2, Smart_Pack__c=true); insert poLine;
        
        Apexpages.StandardController stdCon = new ApexPages.StandardController(po);
        ShoppingCartController shopCon = new ShoppingCartController(stdCon);
        shopCon.purchaseOrderId = po.Id;
        shopCon.deleteId = poLine.Id;
        shopCon.deleteLineItem();
        List<PurchaseOrderLineItem__c> verifyLineList = [SELECT Id, Quantity__c, Smart_Pack__c FROM PurchaseOrderLineItem__c where PurchaseOrder__c = :po.Id];
        System.assertEquals(0, verifyLineList.size());
    }
    
    static testMethod void saveCartFunctionality(){
        Item__c it = new Item__c(Item_Name__c='Black shoes', Type__c='Shoes',   Unit_Price__c=200); insert it;
        Item__c it2 = new Item__c(Item_Name__c='Brown shoes', Type__c='Shoes',   Unit_Price__c=300); insert it2;
        PurchaseOrder__c po = new PurchaseOrder__c(); insert po;
        PurchaseOrderLineItem__c poLine = new PurchaseOrderLineItem__c(PurchaseOrder__c=po.Id,   Items__c=it.Id, Quantity__c=2, Smart_Pack__c=true); insert poLine;
        
        Apexpages.StandardController stdCon = new ApexPages.StandardController(po);
        ShoppingCartController shopCon = new ShoppingCartController(stdCon);
        shopCon.purchaseOrderId = po.Id;
        poLine.Quantity__c = 5;
        shopCon.poLineList = new List<PurchaseOrderLineItem__c>{poLine};
        shopCon.saveCart();
        
        List<PurchaseOrderLineItem__c> verifyLineList = [SELECT Id, Quantity__c, Smart_Pack__c FROM PurchaseOrderLineItem__c where PurchaseOrder__c = :po.Id];
        System.assertEquals(1, verifyLineList.size());
        System.assertEquals(5, verifyLineList.get(0).Quantity__c);
    }
    
    static testMethod void allItemsFunctionality(){
     Item__c it = new Item__c(Item_Name__c='Black shoes', Type__c='Shoes',   Unit_Price__c=200); insert it;
        Item__c it2 = new Item__c(Item_Name__c='Brown shoes', Type__c='Shoes',   Unit_Price__c=300); insert it2;
        PurchaseOrder__c po = new PurchaseOrder__c(); insert po;
        PurchaseOrderLineItem__c poLine = new PurchaseOrderLineItem__c(PurchaseOrder__c=po.Id,   Items__c=it.Id, Quantity__c=2, Smart_Pack__c=true); insert poLine;
        
        Apexpages.StandardController stdCon = new ApexPages.StandardController(po);
        ShoppingCartController shopCon = new ShoppingCartController(stdCon);
        shopCon.purchaseOrderId = po.Id;

        shopCon.getItems();
        List<Item__c> verifyItemList = [SELECT Id FROM Item__c];
        System.assertEquals(shopCon.itemList.size(), verifyItemList.size());
    }
    
}