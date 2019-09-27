@istest
private class TestCreateContact {
	@istest
    static void show(){
        PageReference Pager= page.CreateContact;
        
        Account acc= new Account();
        acc.name='testAccount';
        insert acc;
        
        Contact con= new Contact();
        con.AccountId= acc.id;
        con.FirstName='testfirstname';
        con.LastName='testLastname';
        insert con;
        try{
        Test.setCurrentPage(pager);
        apexpages.currentpage().getparameters().put('id' , acc.Id);
        CreateContact  controller = new CreateContact();
        }
        catch(exception e){
            
        }
       }
    @istest
    static void show1(){
        Account acc= new Account();
        acc.name='testAccount';
        insert acc;
        
        Contact con= new Contact();
        con.AccountId= acc.id;
        con.FirstName='testfirstname';
        con.LastName='testLastname';
        insert con;
        
        CreateContact  controller = new CreateContact();
        try{
        controller.Create();
        }catch(exception e){
}
       }
}