@istest
private class TestOnEmail {
    @istest
    static void show(){
        Emailclass1  ecl= new Emailclass1();
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        ecl.handleInboundEmail(email, envelope);
		Messaging.InboundEmailResult  result = ecl.handleInboundEmail(email, envelope);
        
           contact con= new contact();
        	con.lastname='gangil';
            con.department='subject';
            con.Email='hirdesh@appronex.com';
            con.Description='THIS IS TESTING';
            insert con;
      		System.assertEquals(result.success, true);
      
        
    }
    

}