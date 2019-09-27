@istest
private class TestFilter2 {
    
    static testmethod void show(){
        Filter2 f= new Filter2();
        Book_Category__c bc= new Book_Category__c();
       	bc.Descriptions__c='bhjkk';
        bc.Discount__c=20;
        insert bc;
        
        Author__c acc =new Author__c();
        acc.Name='abc';
        acc.Address__c='gwalior';
        acc.Book_Category__c=bc.Id;
        acc.Categories__c='Eduactional';
        acc.Email__c='hirdesh@gmail.com';
        acc.Date_Of_Birth__c=date.newInstance(1993, 4, 1);
        insert acc;
        
        Book__c bcc1= new Book__c();
        bcc1.Name='Hirdesh';
        bcc1.Author__c = acc.Id;
        bcc1.Book_Category__c=bc.Id;
        bcc1.Category__c='Educational';
        bcc1.Date_Of_Publishing__c=system.today();
        bcc1.Price__c=300;
        bcc1.Description__c='ijj';
        insert bcc1;
        
        f.search();
        f.getList();
           
            
        
    }

}