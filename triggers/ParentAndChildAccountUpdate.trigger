trigger ParentAndChildAccountUpdate on Account (after update) {
    
    set<Id> setParentIds = new Set<Id>();
    set<Id> setIds = new set<Id>();
    string Name ;
    List<Account> ParentAccountList = new List<Account>();
    List<Account> ChildAccountList = New List<Account>();
    
    if(triggerCount.getRunTimes() < 3){
        triggerCount.setRunTimes();
        for(Account acc : trigger.New){
            Name = acc.Name;
            setIds.add(acc.Id);
            setParentIds.add(acc.ParentId);
        }
    }
    for(Account acc: [select id , name,Hirdesh93Org__Name__c from account where Id In : setParentIds]){
        acc.Name= name;
        ParentAccountList.add(acc); 
    }
    if(ParentAccountList.size()>0){
        update ParentAccountList;
    }
    
    for(Account acc: [select id , name,Hirdesh93Org__Name__c from account where parentId In : setIds]){
        acc.Name= name;
        ChildAccountList.add(acc);             
    }
    if(ChildAccountList.size()>0){
        update ChildAccountList;
    }
}