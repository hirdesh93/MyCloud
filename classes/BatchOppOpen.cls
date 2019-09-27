global class BatchOppOpen implements database.Batchable<sobject>{
    user u=[select id,name,Email from user where userrole.name='Manager' limit 1];
    global database.QueryLocator start(database.BatchableContext bc){
        
        String query='select id,name,stagename,closedate from opportunity where closedate>Today';
        return database.getQueryLocator(query);
    }
    global void execute(database.BatchableContext bc, list<Opportunity>Scope){
        for(Opportunity o: scope){
            o.ownerId=u.id;
        }
        update scope;
    }
    global void finish(database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {u.email});
        mail.setSubject('New opportunity assigned to u');
        mail.setPlainTextBody('A new Opportunity is assigned to you');
        Messaging.sendEmail(new Messaging.Email[] { mail });
        
    }
    
    
}