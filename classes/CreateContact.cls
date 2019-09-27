public class CreateContact {
    public contact cont {get;set;}
    public String strError{get;set;}
    public String accid{get;set;}
    public CreateContact(){
    if(ApexPages.currentPage().getParameters().containsKey('id')){
          accid = ApexPages.currentPage().getParameters().get('id');
        Contact c = new contact();
		c.AccountId=accid;
		c.firstname=cont.firstname;
		c.lastname=cont.lastname;
		insert c;
        }
       
    }
    
    public pageReference Create(){
        try{
        insert cont;
        }catch(exception e){
            strError=e.getMessage();
        }
        return null;        
    }

}