public class DynamicAccount {
    public List<Account> accList {get;set;}
    Public String Input {get;set;}
    public string query {get;set;}
    public List<Account> accNewList {get;set;}
    Public void showData(){
        query = 'select id, name , phone , NaicsDesc, AccountSource from account where name like '+'\''+'%'+input+'%'+'\''; 
        accList = database.query(query);
    }
    public void showTable(){
        string aid = Apexpages.currentpage().getParameters().get('recidval');
        accNewList = [select id, name , phone from Account where Id =: aid];
        
    }
}