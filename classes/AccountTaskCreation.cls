global class AccountTaskCreation  implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
     //   if(email.Subject != '' && email.Subject != null){ 
            String myPlainText= '';
            myPlainText = email.plainTextBody;
            
            Task newTask ;
            string s1 = email.Subject.substringBefore(' ');
        	string s2 = email.Subject.substringAfter(' ');
            try {
                Account acc = [SELECT Id, Name FROM Account WHERE Name = :s1 OR Id = :s1 LIMIT 1];
                
                newTask = new Task(Description =  myPlainText,
                                     Priority = 'Normal',
                                     Status = 'Inbound Email',
                                     Subject = s2,
                                     IsReminderSet = true,
                                     ReminderDateTime = System.now()+1,
                                     WhatId =  acc.Id);
                
                // Insert the new Task 
                insert newTask;  
                
                List<Attachment> attachments = new List<Attachment>();
      if(email.textAttachments != null)
      {
        for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
          Attachment attachment = new Attachment();
          attachment.Name = tAttachment.fileName;
          attachment.Body = Blob.valueOf(tAttachment.body);
          attachment.ParentId = newTask.Id;
          attachments.add(attachment);
        }
      }
      if(email.binaryAttachments != null)
      {
        for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
          Attachment attachment = new Attachment();
        
          attachment.Name = bAttachment.fileName;
          attachment.Body = bAttachment.body;
          attachment.ParentId = newTask.Id;
          attachments.add(attachment);
        }
      }
      if(attachments.size() > 0)
      {
        insert attachments;
      }
              System.debug('New Task Object: ' + newTask );  
            }
            catch(QueryException e) {
                System.debug('Query Issue: ' + e);
            }
        
        
        result.success = true;
        
        return result;
    }    
}