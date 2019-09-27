global class BatchToUpdateFields implements Database.Batchable<sObject>{
    public string objectName ;
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select Count() from objectName';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<opportunity> scope) {
       // system.debug('==========check====='+lstOfOppId);    
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
    
    
}