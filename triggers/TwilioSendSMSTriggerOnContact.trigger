trigger TwilioSendSMSTriggerOnContact on Contact (after insert) {
    if(trigger.isInsert && trigger.isAfter){
        for(Contact con : trigger.new){
            if(String.isNotBlank(con.Description) && String.isNotBlank(con.Phone)){
                TwilioClass.processSms('+917987336164', con.Description);
            }
        }
    }
}