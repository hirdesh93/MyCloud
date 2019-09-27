@istest
private class TestDeleteContact {
    static testmethod void show(){
        PageReference pageRef = Page.DeleteContact;
        Account acc= new Account();
        acc.Name= 'testAccount';
        insert acc;
        
        Contact con= new Contact();
        con.AccountId=acc.Id;
        con.FirstName='testfirstname';
        con.LastName='testLastname';
       	insert con;
        
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',acc.id);
        DeleteContact  controller = new DeleteContact();
        System.assertNotEquals(null,controller.remove());
        
    }
}