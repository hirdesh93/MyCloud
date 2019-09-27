trigger twilio on Contact (after insert) {
    for(Contact con : trigger.new){
        SendMessageTwilio.processSms(con.Phone ,con.Description);
    }

}