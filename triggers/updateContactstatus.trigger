trigger updateContactstatus on Invoice__c (after insert ,after update,after delete) {
    set<Id> setNewids = new set<Id>();
    
    if(trigger.isInsert || trigger.isupdate){
        for(Invoice__c iv : trigger.new){
            setNewids.add(iv.Contact__c);
        }
    }
    if(trigger.IsDelete || Trigger.isUpdate){
        for(Invoice__c iv : trigger.old){
            setNewids.add(iv.Contact__c);
        }
    }
    list<contact> conList = new list<contact>();
    set<id> setAccid = new set<id>();
    if(setNewids .size() > 0){
        for(contact con : [select Id,LastName,InvoiceStatus__c ,Amount__c,accountid,(SELECT ID,Amount__c, status__c FROM Invoices__r)
                           from Contact where Id IN :setNewids]){
                               if(con.accountid != null){
                                   setAccid.add(con.accountid);
                               }
                               decimal amt = 0;
                               for (Invoice__c inv: con.Invoices__r){
                                   if(inv.Amount__c != null ){
                                       amt = amt + inv.Amount__c;
                                   }
                               }
                               con.Amount__c = amt;
                               conList.add(con);
                               
                               
                           }
    }
    if(conList.size() > 0){
        update conList;
    }
    List<Account> accList = new List<Account>();
    for(Account acc :[select id, Name,Amount__c,(select id, LastName, Amount__c from contacts) from Account where Id In: setAccid]){
        decimal am = 0;
        for (Contact con: acc.contacts){
            if(con.Amount__c != null ){
                am = am + con.Amount__c;
            }
        }
        acc.Amount__c = am;
        accList.add(acc);
    }
    if(accList.size() >0){
        update accList;
    }
}