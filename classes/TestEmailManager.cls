@istest
private class TestEmailManager {
	@istest
    static void show(){
        String address;
        String subject;
        String body;
        try{
        EmailManager.sendMail(address, subject, body);
        }catch(exception e){
            
        }
    }
}