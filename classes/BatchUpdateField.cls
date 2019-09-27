global class BatchUpdateField implements Database.Batchable<sObject>{
    global final String Query;
    global final Map<String, String> fieldValues;
    global BatchUpdateField(String q, Map<String, String> fieldValues){
        Query = q;
        this.fieldValues = fieldValues;
            }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Account> scope){  
        for(sobject s : scope){
            for(String Industry : fieldValues.keySet()) {
                s.put(Industry, fieldValues.get(Industry));
            }
        }
        
        update scope;
    }
    global void finish(Database.BatchableContext BC){
        
    }
}