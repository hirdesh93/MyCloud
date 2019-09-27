@istest
private class TestOnPreventInsertBook {
    static testmethod void test(){
        test.startTest();
        Book_Category__c bc= new Book_Category__c();
       	bc.Descriptions__c='bhjkk';
        bc.Discount__c=20;
        
        Author__c acc =new Author__c();
        acc.Name='abc';
        acc.Address__c='gwalior';
        acc.Book_Category__c=bc.Id;
        acc.Categories__c='Eduactional';
        acc.Email__c='hirdesh@gmail.com';
        acc.Date_Of_Birth__c=date.newInstance(1993, 4, 1);
        insert acc;
        
      Book__c bcc= new Book__c();
        bcc.Name='Hirdesh';
        bcc.Author__c = acc.Id;
        bcc.Book_Category__c=bc.Id;
        bcc.Category__c='Educational';
        bcc.Date_Of_Publishing__c=system.today();
        bcc.Price__c=300;
        bcc.Description__c='ijj';
        insert bcc;
        
        List<Book_Category__c> bc1 =[select id,Descriptions__c,Discount__c, name, count__c from Book_Category__c where id =: bc.Id];
     
      test.stopTest();
        }
        
}