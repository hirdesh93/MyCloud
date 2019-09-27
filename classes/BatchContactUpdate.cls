global class BatchContactUpdate implements Database.Batchable<sObject>{

    List <Account> mapAccount = new List <Account> ();
    List <Contact> contactlist1 = new List <Contact> ();
    
    global BatchContactUpdate() {
        mapAccount=[select id, Name ,BillingStreet ,BillingPostalCode ,BillingCity ,BillingState,BillingCountry 
                             			From Account];
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return DataBase.getQueryLocator([SELECT Id, AccountID
                                         FROM Contact
                                         WHERE AccountID IN :mapAccount
                                        ]);
    }
    global void execute(Database.BatchableContext BC , List <Contact> contactlist) {
        for (Account acct : mapAccount){ 
            for (Contact con : contactList){
                if (con.AccountID == acct.Id){
                        contactlist1.add(new Contact(
                            Id = con.Id,LastName = acct.Name));
                    }
            }   
        }
        
         update contactlist1;
    } 
    global void finish(Database.BatchableContext BC){
        
    }
}