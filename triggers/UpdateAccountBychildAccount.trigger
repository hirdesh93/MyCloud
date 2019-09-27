trigger UpdateAccountBychildAccount on Account (after Update) {
    set<Id> setIds = new Set<Id>();
    list<string> st = new list<string>();
    string st1 = '';
    If(trigger.isUpdate){
        for(Account acc : trigger.New){
            setIds.add(acc.ParentId);
            st.add(acc.Hirdesh93Org__IndustryMulti__c);
        }
    }
    list<Account> accList = new List<Account>();
    for(Account acc : [select id ,Hirdesh93Org__IndustryMulti__c, name from Account where Id In:setIds]){
        
            st.add(acc.Hirdesh93Org__IndustryMulti__c);
       // acc.Hirdesh93Org__IndustryMulti__c=null;
        for(string s : st){
            if(acc.Hirdesh93Org__IndustryMulti__c==null){
                acc.Hirdesh93Org__IndustryMulti__c=s;            
            }else{
                acc.Hirdesh93Org__IndustryMulti__c+=s;           
        }
            accList.add(acc);
            if(!s.contains(acc.Hirdesh93Org__IndustryMulti__c) && (st1==null || st1=='')){
                st1=s;
            }else if(s.contains(acc.Hirdesh93Org__IndustryMulti__c)){
                if(st1==null && st1==''){
                     st1=s;
                }else if((st1!=null && st1!='') && !st1.contains(s)){
                    st1=st1+';'+s;
                }
            }

           
        }
        if(st1!=null && st1!='')        
         //    acc.Hirdesh93Org__IndustryMulti__c=null;
             acc.Hirdesh93Org__IndustryMulti__c = st1;
            
        }
   
    if(acclist.size() > 0)
    update accList;
}