public with sharing class HeapSize_Controller {

    @remoteAction
    public static List<String> generateRandomObject() {
        List<String> fileData = new List<String>();
        StaticResource sr = [SELECT Id, Body FROM StaticResource limit 1];
        String body = sr.Body.toString();
        fileData.add(body);
        fileData.add(body);
        System.debug('========== Heap Size :: ' + Limits.getHeapSize());
        return fileData;
    }

}