global class AllObjects {

    global static List<SObjectType> getAllObjects(){
        Map<String, Schema.SObjectType> allObjects = Schema.getGlobalDescribe();
        System.debug(allObjects.values().size());
        return allObjects.values();
    }
}