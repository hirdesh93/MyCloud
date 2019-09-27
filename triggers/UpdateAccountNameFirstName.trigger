trigger UpdateAccountNameFirstName on Contact (before update) {
    set<Id> setIds = new set<Id>();
    Map<Id, string> accMap = new Map<Id, string>();
    Map<Id, string>  newmap = new Map<Id, string>();
    for(Contact con: trigger.new){
        if(con.AccountId != null){
            setIds.add(con.id);
        }
        if(con.Count__c == null){
            con.Count__c = 1;
        }else{
            con.Count__c = con.Count__c +1 ;
        }
        setIds.add(con.AccountId);
    }
    for ( Account acct : [ SELECT id, Name FROM account WHERE id IN :setIds]) {
        accMap.put( acct.id, acct.Name );
    }
    for ( Contact c : Trigger.new ) {
        if(Math.mod(Integer.valueOf(c.Count__c), 2)== 0 && c.AccountId != null){
            //  con.LastName = 'testnew6';
				system.debug('Id'+c.AccountId);
                c.LastName = accMap.get(c.AccountId);
        }
    }
}