global class Batch1 implements database.Batchable<sobject>{
    global database.QueryLocator start(database.BatchableContext bc){
        return database.getQueryLocator('select id, name from account');
    }
    global void execute(database.BatchableContext bc,list<account>scope){
        for(Account acc: scope){
            acc.Name='Test';
            acc.Phone='1234567';
            
        }
        update scope; 
    }
    global void finish(database.BatchableContext bc){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,  TotalJobItems  FROM AsyncApexJob  WHERE Id = : bC.getJobId()];
        //If NumberOfErrors is "0" - if the execute method processed all records without errors - then call next contact batch.
        if (a.NumberOfErrors == 0)
        {     
            BatchOppOpen bop = new BatchOppOpen();   
            Id batchProcessId = Database.executeBatch(bop);     //finish method logic here
        }
        else
        {
            //process other code
        }
        
    }
    
    
}