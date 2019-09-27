public class SendAccountChild {
    list<contact> conlist = new list<contact>();
    
    public string header;
    
    public SendAccountChild (){
        conlist = new list<contact>();
        header ='Id , lastname , phone'+'/n';
       // accId=ApexPages.currentPage().getParameters().get('id');
    }
    public void sendchild(){
        for(account ac : [select id,name,(select id,lastname,firstname,phone from contacts) from account where id =:'0016F00002pRfFt']){
            for(contact con : ac.contacts){
         string st = '"'+con.id+',"'+con.lastName+'","'+con.phone+'"\n' ;
          header = header+st;
           
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(header);
        string csvname= 'AccountContacts.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {'kulshresthasumit5493@gmail.com'};
        String subject ='Account CSV';
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Account CSV ');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}
}
}