public class Filter2 {
    public Apexpages.StandardSetController Controller{get;set;}
    Public list<Book__c> getList(){
        List<Book__c> bl=(List<Book__c>)Controller.getRecords();
        return bl;
    }
    
    public String Name			{get;set;}
    public string AuthorName	{get;set;}
    public string BookCategory	{get;set;}
    public decimal price		{get;set;}
    public string q 			{get;set;}
    public list<Book__c> bcc    {get;set;}
    public Filter2(){
        List<Book__c> booklist=[select id,name, Author__r.name, Book_category__r.name, price__c from Book__c];
        controller=new Apexpages.StandardSetController(booklist);
        Controller.SetPageSize(5);
    }
   	public  void search(){
         q='select id,name, Author__r.name, Book_category__r.name, price__c from Book__c';
            q=q+' where name=\''+'%'+Name+'%'+'\' OR Author__r.name=\''+'%'+AuthorName+'%'+'\' OR Book_category__r.name=\''+'%'+BookCategory+'%'+'\'';
        bcc=database.query(q);
        }
    }