global class BatchUpdateLeadIndustry implements database.Batchable<sobject> {
    global database.QueryLocator start(database.BatchableContext bc){
        String query='select id,FirstName,LastName,Leadsource, Industry from Lead';
        return database.getQueryLocator(query);
    }
    global void execute(database.BatchableContext bc, list<Lead>Scope){
        UpdateLeadIndustry ul = new UpdateLeadIndustry();
        ul.updateLead(Scope);
        ul.updateLead1(Scope);
        ul.updateLead2(Scope);
    }
    global void finish(database.BatchableContext bc){
        
    }
    
}