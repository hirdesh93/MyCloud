public class SEwithSchedule{
    public List<Account> AccData {get;set;}
    public String subject { get; set; }
    public String body { get; set; }
    /*
    public void execute(SchedulableContext SC){
        sendexcelfile();
    }*/
    public void sendexcelfile(){
        AccData = [select id, name from Account];
        string header ='AccountId, AccountName \n';
        String finalstr = header;
        for(Account obj:AccData){
            String Recordstring = obj.id+','+obj.Name+'\n';
            finalstr = finalstr+Recordstring;
        }
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        blob excel = blob.valueOf(finalstr);
        system.debug('excelblob111'+excel);
        attach.setBody(excel);
        attach.setFileName('ExcelfileSC.xls');
        subject = 'myExcel';
        body = 'This file is generated using Schedulable';
        
        string[] address = new string[]{'hirdeshgangil@gmail.com'};
            
        Messaging.singleEmailMessage Emailwithattch = new Messaging.singleEmailMessage();
        Emailwithattch.setSubject(subject);
        Emailwithattch.setToaddresses(address);
        Emailwithattch.setPlainTextBody(body);
        Emailwithattch.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
        // Sends the email
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {Emailwithattch});
    }
}