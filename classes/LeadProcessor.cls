global class LeadProcessor implements database.Batchable<sobject> {
    
    global database.QueryLocator start(database.BatchableContext bc){
        
        return database.getQueryLocator('select id, lastname ,LeadSource from Lead');
        
    }
    global void execute(database.BatchableContext bc, List<Lead> scope){
        
        for(lead l : scope){
            l.LeadSource ='Dreamforce';
        }
        update scope;
    }
    global void finish(database.BatchableContext bc){
        
    }
}