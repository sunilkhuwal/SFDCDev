@isTest
public class AllObjectsTest {
    
    @isTest
    public static void testAllObjects(){
        List<SObjectType> objectList = AllObjects.getAllObjects();
        System.assertEquals(true, objectList.contains(Contact.SObjectType));
        System.assertEquals(true, objectList.contains(Class__c.SObjectType));
    }
}