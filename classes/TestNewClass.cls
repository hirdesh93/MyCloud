@istest
Private class TestNewClass {
   
   static testMethod void Check(){
      NewClass nc =New NewClass();
        Account a= new Account();
        a.Name='Hirdesh';
        a.Phone='+91455445567';
		a.Industry='Banking';
        insert a;
       
        Contact c= new Contact();
       	c.AccountId=a.Id;
       	c.firstname='hird';
		c.LastName='Gangil';
       	insert c;
       
       nc.Create();
       system.assertEquals(nc.acc, a);
       system.assertEquals(nc.con, c);
        
        
    }

}