trigger AccountAddressTrigger on Account (before insert,before update) {
    if(trigger.isinsert || trigger.isupdate){
        for(Account acc: Trigger.new){
            if(acc.Match_Billing_Address__c== true){
                acc.ShippingPostalCode=acc.BillingPostalCode;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingGeocodeAccuracy = acc.BillingGeocodeAccuracy;
                acc.ShippingState = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
            }
            
        }
    }
}