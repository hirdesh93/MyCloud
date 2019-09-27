public class BookPageClass {
    public Book__c bcc{get;set;}
    
    public BookPageClass(){
        bcc=new book__c();
        
    }
    public pagereference create(){
        insert bcc; 
        PageReference p=new PageReference('/'+bcc.Id);
        return p;
      }
    }