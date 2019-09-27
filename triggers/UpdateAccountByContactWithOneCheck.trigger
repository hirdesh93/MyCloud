trigger UpdateAccountByContactWithOneCheck on Contact (after insert , after update ,after Delete) {
    Set<Id> setIds = new Set<Id>();
    Set<Id> setIds2 = new Set<Id>();
    Set<Id> setIds3 = new Set<Id>();
    if(trigger.isInsert || trigger.isUpdate){
        for(contact con: trigger.new){
            if(Trigger.isInsert && con.Hirdesh93Org__Account_Contact__c == true){
                setIds.add(con.AccountId);
                
            }
            if(Trigger.isUpdate && con.Hirdesh93Org__Account_Contact__c == true){
                setIds.add(con.AccountId);
                
            }
            if(Trigger.isUpdate && Trigger.newMap.get(con.id).Hirdesh93Org__Account_Contact__c != Trigger.oldMap.get(con.id).Hirdesh93Org__Account_Contact__c && Trigger.oldMap.get(con.id).Hirdesh93Org__Account_Contact__c == true && Trigger.newMap.get(con.id).Hirdesh93Org__Account_Contact__c == false){
                setIds2.add(con.AccountId);
                setIds3.add(con.id);
            }
        }
    }
    if(trigger.isDelete){
        for(contact con: trigger.old){
            if(con.Hirdesh93Org__Account_Contact__c == true){
                setIds2.add(con.AccountId);
                setIds3.add(con.id);
            }
        }
    }
    List<Account> accList = new List<Account>();
    
    List<Contact> conList = new List<Contact>();
    for(contact con : [select id, LastName,Hirdesh93Org__Account_Contact__c from contact where AccountId In :setIds AND Hirdesh93Org__Account_Contact__c= true Order By LastModifiedDate DESC Offset 1  ]){
        con.Hirdesh93Org__Account_Contact__c = false;
        conList.add(con);
    }
    Boolean Istrue;
    for(Account acc:[select id , name ,Hirdesh93Org__Account_Contact__c,(select id, LastName , Hirdesh93Org__Account_Contact__c from contacts) from account where id in : setIds] ){
        for(contact con : acc.contacts){
            if(con.Hirdesh93Org__Account_Contact__c == true)
                acc.Hirdesh93Org__Account_Contact__c = con.LastName;
                Istrue = true;
        }
        accList.add(acc);
    }
    If(!Istrue){
    for(Account acc:[select id , name ,Hirdesh93Org__Account_Contact__c,(select id, LastName , Hirdesh93Org__Account_Contact__c from contacts) from account where id in : setIds2] ){
        for(contact con : acc.contacts){
            if(con.Hirdesh93Org__Account_Contact__c == false)
                acc.Hirdesh93Org__Account_Contact__c = '';
        }
        accList.add(acc);
    }
    }
    if(accList.size() >0){
        update accList;
    }
    
    
    if(ConList.size() > 0){
        Update conList;
    }
}