trigger CreateUserNotification on User (after insert) {
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {'Engineergangil@gmail.com'}; 
    mail.setToAddresses(toAddresses);
    mail.setSubject('New User Created');
    mail.setUseSignature(True);
    string msg = 'The following User(s) have been created: <ol>';
    for (User u : Trigger.new) {
        msg = msg + '<li>'+u.FirstName+' '+u.LastName+' - '+u.Username+'</li>'; 
    }
    msg = msg + '</ol>';
    mail.setHtmlBody(msg);
    
    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
}