trigger CountAtachement on Attachment (after insert , after update , after delete , after undelete) {
    set<Id> setIds = new set<Id>();
    if(trigger.isInsert || trigger.isUpdate || trigger.IsUndelete && (trigger.isAfter)){
        for(Attachment atc : trigger.new){
            if(String.valueof(atc.ParentId).startsWith('001')){
                setIds.add(atc.ParentId);
            }
        }
    }
    if(trigger.isDelete && trigger.isAfter){
        for(Attachment atc : trigger.old){
            if(String.valueof(atc.ParentId).startsWith('001')){
                setIds.add(atc.ParentId);
            }
        }
    }
    List<Account> accList = new List<Account>();
    if(setIds.size() > 0){
        for(Account acc : [select id, name ,(select id, name, ParentId from Attachments) from account where id in:setIds]){
            acc.CountAttacements__c = acc.Attachments.size();
            accList.add(acc);
        }
    }
    if(accList.size() > 0){
        update accList;
    }
}