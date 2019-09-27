trigger AccountAttachmentTrigger on Account (after insert) {
    set<Id> setIds = new set<id>();
    List<Attachment> atcList = new list<Attachment>();
    List<Contact> conList = new List<Contact>();
    if(trigger.isinsert){
        for(account acc :trigger.new){
            
            Contact con = new contact();
            con.LastName = acc.name;
            con.AccountId = acc.id;
            conList.add(con);
            
            Attachment acc1 = new Attachment();
            acc1.Name = acc.Name;
            acc1.Body = blob.valueOf(acc.Name);
            acc1.ParentId = acc.id;
            
            atcList.add(acc1);
        }
        if(conList.size() >0){
            insert conList;
        }
        for(Contact con: conList){
            Attachment acc2 = new Attachment();
            acc2.Name = con.LastName;
            acc2.Body = blob.valueOf(con.LastName);
            acc2.ParentId = con.id;
            atcList.add(acc2);
        }
        if(atcList.size() >0)
            insert atcList;
    }
}