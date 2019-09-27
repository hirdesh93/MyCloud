public class DeleteContact {
    public List<contact> lstCont {get;set;}
	public String accid{get;set;}
    public DeleteContact(){
        if(ApexPages.currentPage().getParameters().containsKey('id')){
            accid = ApexPages.currentPage().getParameters().get('id');
           lstCont=[select id,FirstName,LastName from contact where AccountId=:accid];
        }
       
    } 
    public PageReference Remove(){   
        delete lstCont;
        pageReference pg = new pageReference('/'+accid);
        pg.setRedirect(true);
        return pg;
    }
    
}