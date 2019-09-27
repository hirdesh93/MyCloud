@istest
private class TestEmailMissionSpecialist {
	@istest
    static void show(){
        String address;
        String subject;
        String body;
        EmailMissionSpecialist ems = new EmailMissionSpecialist();
        ems.sendMail('address', 'subject', 'body');
        
        Messaging.SendEmailResult[] results ;
        EmailMissionSpecialist.inspectResults(results);
        
        
    }
}