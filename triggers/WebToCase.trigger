trigger WebToCase on Case (before insert ) {
    set<Id> setIds = new set<Id>();
    List<String> EmailList = new List<String>();
    List<Case> CaseList = new List<Case>();
    if(trigger.isInsert && trigger.isBefore){
        for(case c : trigger.new){
            if(c.ContactId != null && c.SuppliedEmail != ''){
                EmailList.add(c.SuppliedEmail);
                CaseList.add(c); 
            }
        }
    }
    List<Contact> conList = new List<Contact>();
    Map<String , Contact> maplist = new Map<string ,Contact>();
    for(contact cn : [select id,Email, lastname from contact where email =: EmailList]){
        maplist.put(cn.email, cn);
    }
    for(case c1 : trigger.new){
        if(!maplist.containsKey(c1.SuppliedEmail)){
            Contact con = new Contact();
            con.LastName= c1.SuppliedName;
            con.Email = c1.SuppliedEmail;
            conList.add(con);
            maplist.put(c1.SuppliedEmail, con);
            CaseList.add(c1);
        }
        
    }
    if(conList.size() > 0 ){
        insert conList;
    } 
    if(CaseList.size() > 0){
        for(case c2 : CaseList){
            Contact ConNew= mapList.get(c2.SuppliedEmail);
            c2.ContactId = conNew.Id;
        }
    }
}