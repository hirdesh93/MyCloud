global class TwilioBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    Map<String,String> ChangeTypeMap=new Map<String,String>();
    Set<String> AllAppointMents = new Set<String>();
    
    
    String query = 'select id,LastName,Phone from Contact where id in : AllAppointMents';
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> Appointments){
        List<Response_Messages__c> Responses=new List<Response_Messages__c>();
        List<Contact> AppointMentUpdates=new List<Contact>();
        for(Contact Appt: Appointments){
            
                String SmsBody='Appointment Confirmation: \n'+'Lice Troopers ';
                
                SmsBody+='Please call us at 800-403-5423 if you need to reschedule to avoid a $50 no show fee.';
                System.debug(SmsBody);
                
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.phone;
                send.smsBody=SmsBody;
            	send.processSms();
            
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                Responses.add(response);
                
            
            AppointMentUpdates.add(Appt);
        }
        
        if(!Responses.isEmpty()){
            Insert Responses;
        }
    }
    
	global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}