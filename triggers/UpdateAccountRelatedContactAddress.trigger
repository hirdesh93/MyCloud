trigger UpdateAccountRelatedContactAddress on Account (after Update) {
    if(trigger.isUpdate && trigger.isAfter){
        Map<Id,Account> Mapacc = new Map<Id,Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Account acc: trigger.new){
            if(acc.id != null && acc.id != ''){
                Mapacc.put(acc.Id, acc);
            }
        }
        List<Account> accn = [select id,name,BillingAddress,BillingCity,BillingCountry,BillingPostalCode,BillingState,BillingStreet,
                              ShippingAddress,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet,
                              (SELECT Id,AccountId,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,
                               OtherAddress,OtherCity,OtherCountry,OtherPostalCode,OtherState,OtherStreet FROM Contacts) 
                              from account where Id IN : Mapacc.keySet() ];
        if(accn.size() > 0){
            for(Account a : accn){
                for(Contact con : a.Contacts){
                    If(Mapacc.containsKey(con.AccountId)){
                        
                        con.MailingCity = Mapacc.get(con.AccountId).BillingCity;
                        con.MailingCountry = Mapacc.get(con.AccountId).BillingCountry;
                        con.MailingPostalCode = Mapacc.get(con.AccountId).BillingPostalCode;
                        con.MailingState = Mapacc.get(con.AccountId).BillingState;
                        con.MailingStreet = Mapacc.get(con.AccountId).BillingStreet;
                        
                        con.OtherCity = Mapacc.get(con.AccountId).ShippingCity;
                        con.OtherCountry = Mapacc.get(con.AccountId).ShippingCountry;
                        con.OtherPostalCode = Mapacc.get(con.AccountId).ShippingPostalCode;
                        con.OtherState = Mapacc.get(con.AccountId).ShippingState;
                        con.OtherStreet = Mapacc.get(con.AccountId).shippingStreet;
                        
                        conList.add(con);
                    }
                }
            }
        }
        if(ConList.size() > 0){
            update conList;
        }
    }
}