global class BatchUpdateAccBillingToConMailing  implements Database.Batchable <Sobject>{
    List <Account> mapAccount = new List <Account> ();
    
    global BatchUpdateAccBillingToConMailing() {
        mapAccount=[select id, Name ,BillingStreet ,BillingPostalCode ,BillingCity ,BillingState,BillingCountry 
                    From Account];
        
    }
    
    global database.QueryLocator Start(database.BatchableContext bc){
        return database.getQueryLocator([select id,AccountId,  Lastname ,FirstName , MailingStreet , MailingPostalCode ,MailingCity ,MailingState,MailingCountry
                                         from Contact where AccountId In: mapAccount]);
    }
    global void  execute(Database.BatchableContext bc, List<Contact> conList){
        List<Contact>  ConList1 = new List<Contact>();
        for(Account acc : mapAccount){
            for(Contact con : conList){
                if(con.AccountId == acc.id){
                    if(acc.BillingStreet != null){
                        con.MailingStreet = acc.BillingStreet;
                    }
                    if(acc.BillingCity != null){
                        con.MailingCity = acc.BillingCity;
                    }
                    if(acc.BillingState != null){
                        con.MailingState = acc.BillingState;
                    }
                    if(acc.BillingPostalCode != null){
                        con.MailingPostalCode = acc.BillingPostalCode;
                    }
                    if(acc.BillingCountry != null){
                        con.MailingCountry = acc.BillingCountry;
                    }
                    conList1.add(con);
                }
            }
        }
        update conList1;
    }
    global void finish(Database.BatchableContext bc){
        
    }
    
}