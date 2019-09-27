@istest
private class TestPreventDeleteBook1 {
    static testmethod void show(){
        Test.startTest();
        Book_Category__c bc= new Book_Category__c();
        bc.Name='testField';
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
        
        Book__c bcc2= new Book__c();
        bcc2.Name='Hirdesh';
        bcc2.Author__c = acc.Id;
        bcc2.Book_Category__c=bc.Id;
        bcc2.Category__c='Educational';
        bcc2.Date_Of_Publishing__c=system.today();
        bcc2.Price__c=300;
        bcc2.Description__c='ijj';
        insert bcc2;
        
        List<Book__c> BookList = new List<Book__c>();
        BookList.add(bcc1);
        BookList.add(bcc2);
        if(bc.Count__c >0){
            system.assertNotEquals(BookList.isEmpty(), false , 'delete');
        }
        else {
            delete BookList;
        }
         
        
    }
       
}