public class Filter1 {
    public String Name          {get;set;}
    public string AuthorName    {get;set;}
    public string BookCategory  {get;set;}
    public decimal price        {get;set;}
    public string q             {get;set;}
    public list<Book__c> bcc    {get;set;}
    
    
    public boolean NameFlag {get;set;}
    public boolean Authorflag {get;set;}
    public boolean Bookcategoryflag{get;set;}
    public boolean Bookpriceflag {get;set;}
    
    public Filter1() {
    NameFlag  = false;
    Authorflag  = false;
    Bookcategoryflag = false;
    Bookpriceflag  = false;
    
    }
    public  void search(){
         q='select id,name, Author__r.name, Book_category__r.name, price__c from Book__c where name != null';
       		if(NameFlag == true && Name != '')
            q=q+' AND name=\''+Name+'\'' ;
           if(Authorflag  == true && AuthorName != null) 
            q = q+' AND Author__r.name=\''+AuthorName+'\'';
           if(Bookcategoryflag == true && BookCategory != null) 
            q= q+ ' AND Book_category__r.name=\''+BookCategory+'\'';
           if(Bookpriceflag  == true && price !=null) 
            q= q+ ' AND price__c=\''+price +'\'';
        
        bcc=database.query(q);
        }
    }