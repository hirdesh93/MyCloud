@istest
private class TestXmlEmailClass {
    @istest
    static void show(){
        test.startTest();
       XmlEmailClass xec= new XmlEmailClass();
        Contact c= new Contact();
        c.LastName='test';
        c.Email='test@gmail.com';
        insert c;
        
        messaging.InboundEmail email;
        messaging.InboundEnvelope env;
    	messaging.InboundEmailResult result=new messaging.InboundEmailResult ();
    	Dom.Document doc = new Dom.Document();
    	Dom.Xmlnode rootNode = doc.createRootElement('response', null, null);
       
        Dom.Xmlnode contactNode = rootNode.addChildElement('Contact', null, null);
            contactNode.setAttribute('id', c.Id);
            contactNode.setAttribute('lastname', c.lastname);
            contactNode.setAttribute('email', c.Email);
        xec.HandleInboundEmail(email,env);
        test.stopTest();
    }
    

}