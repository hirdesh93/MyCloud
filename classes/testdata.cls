public class testdata {
    /*
     global class TwilioBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    Map<String,String> ChangeTypeMap=new Map<String,String>();
    Set<String> AllAppointMents = new Set<String>();
    global TwilioBatch(Set<String> AllAppointMents,Map<String,String> ChangeTypeMap){
        this.AllAppointMents=AllAppointMents;
        this.ChangeTypeMap=ChangeTypeMap;
    }
    
    String query = 'select id,StatusPicklist__c,Household__c,Appointment_Date_Time__c,Status__c,Client__c,Service_ID__c,Location_Text__c,Client_Mobile__c,Appointment_Date__c from Appointment__c where id in : AllAppointMents';
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Appointment__c> Appointments){
        List<Response_Messages__c> Responses=new List<Response_Messages__c>();
        List<Appointment__c> AppointMentUpdates=new List<Appointment__c>();
        for(Appointment__c Appt: Appointments){
            if(ChangeTypeMap.containsKey(Appt.Id) && (ChangeTypeMap.get(Appt.Id)=='Confirm Insert' || ChangeTypeMap.get(Appt.Id)=='AppointMent Rescheduled')){
                String SmsBody='Appointment Confirmation: \n'+'Lice Troopers ';
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Coral Gables\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n2109 Le Jeune Rd., Coral Gables FL 33134\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Kendall\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n13027 Southwest 88th Street, Miami, FL 33186\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Bay Harbor\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n1005 Kane Concourse, Suite 212, Bay Harbor Islands, FL 33154\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Hollywood\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n5735 Hollywood Boulevard, Hollywood, FL 33021\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Plantation\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n8320 West Sunrise Boulevard, Suite 206, Plantation, FL 33322\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Orlando\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n250 Lake Cane Drive, Suite 250, Orlando, FL 32819\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Winter Park\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n1555 FL-436, Suite 1101, Winter Park, FL 32792\n';
                }
                else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('House Call') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='House Call Visit\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\nOur lice expert will arrive within a 30 minute range of your appointment.\n';
                }
                SmsBody+='Please call us at 800-403-5423 if you need to reschedule to avoid a $50 no show fee.';
                System.debug(SmsBody);
                
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody=SmsBody;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to Cancel or Lead'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody = System.Label.LeadOrCancelled;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to No Show'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.NoShowRetreatment : System.Label.NoShowScreening ;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to Complete'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = System.Label.CoralComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = System.Label.KendallComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = System.Label.BayHarborComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = System.Label.HollywoodComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = System.Label.PlantationComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = System.Label.OrlandoComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = System.Label.WinterParkComplete;
                }
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Completed Yesterday'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody =System.Label.MembershipOffer;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled Tomorrow'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.CoralNightBeforeRetreatment : System.Label.CoralNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.KendallNightBeforeRetreatment : System.Label.KendallNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.BayHarborNightBeforeRetreatment : System.Label.BayHarborNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.HollywoodNightBeforeRetreatment : System.Label.HollywoodNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.PlantationNightBeforeRetreatment : System.Label.PlantationNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.OrlandoNightBeforeRetreatment : System.Label.OrlandoNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.WinterParkNightBeforeRetreatment : System.Label.WinterParkNightBeforeScreening ;
                }
                else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('House Call') && Appt.Service_ID__c.contains('In Home Lice Screening or Treatment')){
                    send.smsBody = System.Label.HouseCallNightBefore ;
                }
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled after 15 Minutes Of Creation'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.Coral5MinsRetreatment : System.Label.Coral5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.Kendall5MinsRetreatment : System.Label.Kendall5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.BayHarbor5MinsRetreatment : System.Label.BayHarbor5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.Hollywood5MinsRetreatment : System.Label.Hollywood5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.Plantation5MinsRetreatment : System.Label.Plantation5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.Orlando5MinsRetreatment : System.Label.Orlando5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = Appt.Service_ID__c.contains('Re-treatment') ? System.Label.WinterPark5MinsRetreatment : System.Label.WinterPark5MinsScreening ;
                }
                else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('House Call') && Appt.Service_ID__c.contains('In Home Lice Screening or Treatment')){
                    send.smsBody = System.Label.HoseCall15mins ;
                }
                
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                AppointMentUpdates.add(Appt);
                
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled after 2 Hours Of Completion'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody =System.Label.TwoHoursComplete;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                AppointMentUpdates.add(Appt);
            }
        }
        
        if(!Responses.isEmpty()){
            Insert Responses;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }

}

===========
global class TwilioImmediateMessagesBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    Map<String,String> ChangeTypeMap=new Map<String,String>();
    Set<String> AllAppointMents = new Set<String>();
    global TwilioImmediateMessagesBatch(Set<String> AllAppointMents,Map<String,String> ChangeTypeMap){
        this.AllAppointMents=AllAppointMents;
        this.ChangeTypeMap=ChangeTypeMap;
    }
    
    String query = 'select id,StatusPicklist__c,Household__c,Appointment_Date_Time__c,Status__c,Client__c,Service_ID__c,Location_Text__c,Client_Mobile__c,Appointment_Date__c from Appointment__c where id in : AllAppointMents';
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Appointment__c> Appointments){
        List<Response_Messages__c> Responses=new List<Response_Messages__c>();
        List<Appointment__c> AppointMentUpdates=new List<Appointment__c>();
        for(Appointment__c Appt: Appointments){
            if(ChangeTypeMap.containsKey(Appt.Id) && (ChangeTypeMap.get(Appt.Id)=='Confirm Insert' || ChangeTypeMap.get(Appt.Id)=='AppointMent Rescheduled')){
                String SmsBody='Appointment Confirmation: \n'+'Lice Troopers ';
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Coral Gables\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n2109 Le Jeune Rd., Coral Gables FL 33134\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Kendall\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n13027 Southwest 88th Street, Miami, FL 33186\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Bay Harbor\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n1005 Kane Concourse, Suite 212, Bay Harbor Islands, FL 33154\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Hollywood\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n13027 Southwest 88th Street, Miami, FL 33186\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Plantation\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n8320 West Sunrise Boulevard, Suite 206, Plantation, FL 33322\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Orlando\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n250 Lake Cane Drive, Suite 250, Orlando, FL 32819\n';
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park') && Appt.Appointment_Date_Time__c!=null){
                    SmsBody+='Winter Park\n'+Appt.Appointment_Date_Time__c.format('MM/dd/yyyy hh:mm a')+'\n1555 FL-436, Suite 1101, Winter Park, FL 32792\n';
                }
                SmsBody+='Please call us at 800-403-5423 if you need to reschedule to avoid a $50 no show fee.';
                System.debug(SmsBody);
                
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody=SmsBody;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to Cancel or Lead'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody = System.Label.LeadOrCancelled;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to No Show'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.NoShowRetreatment : System.Label.NoShowScreening ;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Status Changed to Complete'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = System.Label.CoralComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = System.Label.KendallComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = System.Label.BayHarborComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = System.Label.HollywoodComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = System.Label.PlantationComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = System.Label.OrlandoComplete;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = System.Label.WinterParkComplete;
                }
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Completed Yesterday'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody =System.Label.MembershipOffer;
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled Tomorrow'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.CoralNightBeforeRetreatment : System.Label.CoralNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.KendallNightBeforeRetreatment : System.Label.KendallNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.BayHarborNightBeforeRetreatment : System.Label.BayHarborNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.HollywoodNightBeforeRetreatment : System.Label.HollywoodNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.PlantationNightBeforeRetreatment : System.Label.PlantationNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.OrlandoNightBeforeRetreatment : System.Label.OrlandoNightBeforeScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.WinterParkNightBeforeRetreatment : System.Label.WinterParkNightBeforeScreening ;
                }
                
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled after 15 Minutes Of Creation'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Coral Gables')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.Coral5MinsRetreatment : System.Label.Coral5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Kendall')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.Kendall5MinsRetreatment : System.Label.Kendall5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Bay Harbor')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.BayHarbor5MinsRetreatment : System.Label.BayHarbor5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Hollywood')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.Hollywood5MinsRetreatment : System.Label.Hollywood5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Plantation')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.Plantation5MinsRetreatment : System.Label.Plantation5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Orlando')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.Orlando5MinsRetreatment : System.Label.Orlando5MinsScreening ;
                }else if(String.IsNotBlank(Appt.Location_Text__c) && Appt.Location_Text__c.contains('Winter Park')){
                    send.smsBody = Appt.Service_ID__c.contains('Retreatment') ? System.Label.WinterPark5MinsRetreatment : System.Label.WinterPark5MinsScreening ;
                }
                
                Appt.Send_Text_After_15_Minutes__c=false;
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                AppointMentUpdates.add(Appt);
                
            }else if(ChangeTypeMap.containsKey(Appt.Id) && ChangeTypeMap.get(Appt.Id)=='Scheduled after 2 Hours Of Completion'){
                SendMessageTwilio  send = new SendMessageTwilio();
                send.phNumber = Appt.Client_Mobile__c;
                send.smsBody =System.Label.TwoHoursComplete;
                Appt.Two_Hours_Complete__c=false;
                Response_Messages__c response = new Response_Messages__c();
                response.Respose_message__c = send.processSms();
                response.Message_body__c = send.smsBody;
                response.Household__c = Appt.Household__c;
                Responses.add(response);
                AppointMentUpdates.add(Appt);
            }
            
        }
        
        if(!Responses.isEmpty()){
            Insert Responses;
        }
        
        if(!AppointMentUpdates.isEmpty()){
            Update AppointMentUpdates;
        }
        
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}

==========
public class TwilioRequestControllerContacts {
    
    public String fromNumber = ApexPages.currentPage().getParameters().get('From');
    public String toNumber = ApexPages.currentPage().getParameters().get('To');
    public String body = ApexPages.currentPage().getParameters().get('Body');
    public PageReference response = new PageReference('http://dev-licetroopers.cs19.force.com/TwilioResponse');
    Public String xmlstring{get;set;}
    
    Public TwilioRequestControllerContacts()
        {
            
        }
    
    public PageReference init()
    {
        DOM.Document doc = new DOM.Document();
        dom.XmlNode Response = doc.createRootElement('Response', null, null);
        dom.XmlNode body1= Response.addChildElement('Message', null, null).addTextNode('Test Response');
        
        xmlstring = doc.toXmlString();
      //  response = xmlstring;
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setBody(xmlstring);
        req.setEndpoint('http://dev-licetroopers.cs19.force.com/TwilioResponse');
        Http http = new Http();    
        HTTPResponse res = new HTTPResponse(); 
        res = http.send(req);
        return null;
    }
    =============
trigger callTwilio on Contact (after update) {
    map<String,contact> conMap = new map<String,contact>(); 
    map<String,String> conMap2 = new map<String,String>();   
    
    for(contact con : trigger.new){
        if(trigger.oldMap.get(con.id).Cancel_app2__c == false && con.Cancel_app2__c == true && con.Primary_Member__c == true){
            conMap.put(con.id,con);
        }
    } 
    
    if(conMap.size()>0){
        for(Appointment__c ap : [select id,client__c,client__r.mobilephone,status__c from Appointment__c where client__c in: conMap.keySet()]){
            if(ap.status__c == 'Lead' || ap.status__c == 'Cancelled' || ap.status__c == 'Cancellation'){
                conMap2.put(ap.client__c,ap.client__r.mobilephone);
            }
        }
    }
    
    if(conMap2.size()>0){
        for(String con : conMap2.keySet()){
            SendMessageTwilio send = new SendMessageTwilio();
            if(string.isNotBlank(conMap2.get(con))){
                send.phNumber = conMap2.get(con);    
                send.smsBody = 'Receive 10% OFF lice treatments & screenings today or tomorrow only! Book Now 800-403-5423 Mention CODE: LICE10'; 
                send.processSms();
            }
        }
    }
}
    
}
     */ 

}