public class ContactReportController {
    Public Contact Cont;
    public List<Contact> lstJobs{get;set;}

    public List<wrapclass> wrapList {get;set;}
    public ContactReportController(){
        lstJobs = new List<Contact>();
        wrapList = new List<wrapclass>();
        for(Contact c : [select id, FirstName,LastName,Phone,Email from Contact ]){
            wrapclass wrap = new wrapclass();
            wrap.con = c;
            wrapList.add(wrap);
            lstJobs.add(wrap.con);
                
           }
    }
     public pagereference saveme()
    {
        try
        {
                update lstJobs;
        }       
        catch(Exception e)
        {
                System.debug('Exception occurred '+String.valueOf(e));
        }
        return NULL;
    }   
    
    public class wrapclass{
        public contact con{get;set;}
        public boolean check{get;set;}
        public wrapclass(){
            con = new Contact();
            check = false;
        }
    }
    
    
}