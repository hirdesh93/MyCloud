public class SearchBarController {
    public string name {get;set;}
    public string industry {get;set;}
    public string q {get;set;}
    public list<Account> bcc   {get;set;}
    public void searchresult(){
        q='select id,name,Industry from Account';
            q=q+' where Name like \''+'%'+name+'%'+'\'';
        	q=q+'AND Industry Like \''+'%'+industry+'%'+'\'';
        bcc=database.query(q);
    }

}