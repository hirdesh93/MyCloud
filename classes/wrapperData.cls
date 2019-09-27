public class wrapperData {
    public list<account> acclist{get;set;}
    public list<opportunity> oppList {get;set;}
    public list<wrapperclass> wrapList {get;set;}
    public wrapperData(){
        
        acclist = new List<account>();
        oppList = new List<opportunity>();
        for(account a : [select id, name , (select id , name from opportunities) from account]){
            wrapperclass wpc = new wrapperclass();
            wpc.acc = a;
            wpc.opp = a.opportunities;
            for(opportunity o:[select id, name , (select id, unitprice from opportunitylineitems) from opportunity]){
                wpc.con = o.opportunitylineitems;
            }
             wrapList.add(wpc);
        }
        
        
    }
    public class wrapperclass{
        public account acc{get;set;}
        public List<opportunity> opp{get;set;}
        public List<opportunitylineitem> con{get;set;}
        public wrapperclass(){
            acc = new account();
            opp = new List<opportunity>();
            con = new List<opportunitylineitem>();
        }
    }
    

}