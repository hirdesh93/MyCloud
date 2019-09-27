global class EmailClass1 implements Messaging.InboundEmailHandler{
   public messaging.InboundEmailResult HandleInboundEmail(messaging.InboundEmail email,messaging.InboundEnvelope env){
        messaging.InboundEmailResult result=new messaging.InboundEmailResult ();
        try{
            Contact con=new Contact();
            con.lastname=email.fromName;
            con.department=email.subject;
            con.Email=email.fromAddress;
            con.Description='THIS IS TESTING';
            insert con;
            result.success=true;
        } 
        catch(exception e){
            result.success=false;
            
    }
return result;
}
}