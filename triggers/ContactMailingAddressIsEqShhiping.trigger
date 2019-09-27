trigger ContactMailingAddressIsEqShhiping on Contact (Before insert , Before update) {
     Set<Id> AccountIds =new Set<Id>();
 Map<id,account> mapAcc = new Map<id,account>();
 for(Contact con :Trigger.new)
 { 
    AccountIds.add(con.AccountId);
 }
 
 for(account a : [select id,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry from account where id in : AccountIds])
 {
    mapAcc.put(a.id,a);
 }
 
 for(Contact con :Trigger.new)
 { 
    con.MailingStreet = mapAcc.get(con.AccountId).BillingStreet;
    con.MailingCity = mapAcc.get(con.AccountId).BillingCity;
    con.MailingState = mapAcc.get(con.AccountId).BillingState;
    con.MailingPostalCode = mapAcc.get(con.AccountId).BillingPostalCode;
    con.mailingCountry = mapAcc.get(con.AccountId).BillingCountry;
}
}