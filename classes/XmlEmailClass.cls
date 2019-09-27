public class XmlEmailClass {
    public messaging.InboundEmailResult HandleInboundEmail(messaging.InboundEmail email,messaging.InboundEnvelope env){
    messaging.InboundEmailResult result=new messaging.InboundEmailResult ();
    Dom.Document doc = new Dom.Document();
    Dom.Xmlnode rootNode = doc.createRootElement('response', null, null);
    

    list<contact> con=[select id, name, email from Contact];
        for (Contact eachContact : con){
            Dom.Xmlnode contactNode = rootNode.addChildElement('Contact', null, null);
            contactNode.setAttribute('id', eachContact.Id);
            contactNode.setAttribute('lastname', eachContact.lastname);
            contactNode.setAttribute('email', eachContact.Email);
            system.debug(doc.toXmlString());            
			}
        
		return result;	
    }
       
}