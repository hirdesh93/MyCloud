trigger UpdateField1 on Book__c (after insert,after delete) {
    List<id> accIdList = new List<id>();
    if(Trigger.isInsert){
        For(Book__c con : Trigger.new){
            accIdList.add(con.Author__c);
        }
    }
    if(Trigger.isDelete){
        For(Book__c con1 : Trigger.old){
            accIdList.add(con1.Author__c);
        }
    }
    List<Author__c> accUpdateList = new List<Author__c>();
    For(Author__c acc : [SELECT No_of_Books__c,(SELECT id FROM Books__r) FROM Author__c WHERE id IN: accIdList]){
        acc.No_of_Books__c = acc.Books__r.size();
        accUpdateList.add(acc);
    }
    try{
        update accUpdateList;
    }Catch(Exception e){
        System.debug('Exception :'+e.getMessage());
    }
    }