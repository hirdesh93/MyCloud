public class AccountToContact {
    public integer a{get;set;}
    public integer b{get;set;}
    public integer result {get;set;}
    public List<Contact> conList {get;set;}
    public contact con {get;set;}
    public string message {get;set;}
    
    public AccountToContact(){
        a=0;
        b=0;
      //  result = a*b;
    }
    public void countMethod(){
        if(a!=0 && b!=0){
            for(integer i=0;i<b;i++){
                result = result*a;
                system.debug('test'+result);
            }
        }
    }
    public void showContact(){
        if(con.AccountId != null){
            conList = [select id, LastName ,AccountId from Contact where id=:con.AccountId ];
        }else{
            conList = [select id, LastName ,AccountId from Contact];
        }
        
    }
}