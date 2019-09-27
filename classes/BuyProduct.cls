public class BuyProduct {
/*
 public class BuyProductscontroller {
    
    Public boolean IsIpad{get;set;}
    Public String FirstName{get;set;}
    Public String LastName{get;set;}
    Public String Email{get;set;}
    Public String Mobile{get;set;}
    
    Public Decimal ProductSubTotal{get;set;}
    Public Decimal ProductTaxes{get;set;}
    Public Decimal ProductFinalTotal{get;set;}
    
    Public List<WrapAllProducts> AllAvailableProducts{get;set;}
    Public List<Contact> ClientList = new List<Contact>();
    
    Public String Location{get;set;}
    
    Public Boolean SplitPayment{get;set;}
    Public String PrimaryPaymentMethod{get;set;}
    Public String PrimaryNameOnCard{get;set;}
    Public Decimal PrimaryAmount{get;set;}
    Public String PrimaryBillingStreet{get;set;}
    Public String PrimaryBillingCity{get;set;}
    Public String PrimaryBillingState{get;set;}
    Public String PrimaryBillingZip{get;set;}
    Public String PrimaryCardNo{get;set;}
    Public String PrimarySecurityCode{get;set;}
    Public String PrimaryExpirationMonth{get;set;}
    Public String PrimaryExpirationYear{get;set;}
    
    Public String SecondaryPaymentMethod{get;set;}
    Public String SecondaryNameOnCard{get;set;}
    Public String SecondaryAmount{get;set;}
    Public String SecondaryBillingStreet{get;set;}
    Public String SecondaryBillingCity{get;set;}
    Public String SecondaryBillingState{get;set;}
    Public String SecondaryBillingZip{get;set;}
    Public String SecondaryCardNo{get;set;}
    Public String SecondarySecurityCode{get;set;}
    Public String SecondaryExpirationMonth{get;set;}
    Public String SecondaryExpirationYear{get;set;}
    
    Public Boolean ClientInserted{get;set;}
    Public Boolean cardauthpassed{get;set;}
    Public Contact Client;
    Public String PrimaryTransId{get;set;}
    Public String PrimaryMessage{get;set;}
    Public Boolean PrimaryCash{get;set;}
    Public String SecondaryTransId{get;set;}
    Public String SecondaryMessage{get;set;}
    Public Boolean SecondaryCash{get;set;}
    Public Boolean PaymentProcessComplted{get;set;}
    Public List<Transaction_history__c> TranshistoryList;
    Public String CashMessage{get;set;}
    Public Boolean cardauthpassedSecondary{get;set;}
    
    Public List<WrapAllProducts> selectedProducts{get;set;}

    
    Public BuyProductscontroller(){
        // Check if iPad
        String userAgent = System.currentPageReference().getHeaders().get('User-Agent');
        if (string.isNotBlank(userAgent) && userAgent.contains('iPad') ){
            IsIpad=true;
        }
        
        //Get All Products
        AllAvailableProducts = new List<WrapAllProducts>();
        selectedProducts = new List<WrapAllProducts>();
        for(Product__c pro : [select id,is_taxable__c,name,Regular_Price__c from Product__c]){
            AllAvailableProducts.add(new WrapAllProducts(pro));
        }
        Location = '';
        ClientInserted = false;
        SplitPayment = false;
        Client = new Contact();
        cardauthpassed = false;
        cardauthpassedSecondary = false;
    }
    
    Public Void UpsertContact(){
        if(String.isNotBlank(Mobile)){
        system.debug('mobile'+ Mobile);
            for(Contact con : [select id,firstname,lastname,email,MobilePhoneFormulae__c ,mobilephone from contact where MobilePhoneFormulae__c =: Mobile OR MobilePhone =: Mobile Limit 1]){
                system.debug('mobile'+ con.MobilePhoneFormulae__c + FirstName + LastName);
                Client = new Contact();
                Client.id = con.id;
                Client.firstname = FirstName;
                Client.lastname = LastName;
                Client.email = Email;
                Client.mobilephone = Mobile;
                ClientList.add(Client);
            }
        }
        
        if(String.isNotBlank(Email) && Client == null){
            for(Contact con : [select id,firstname,lastname,email,mobilephone from contact where Email =: Email Limit 1]){
                Client = new Contact();
                Client.id = con.id;
                Client.firstname = FirstName;
                Client.lastname = LastName;
                Client.email = Email;
                Client.mobilephone = Mobile;
                ClientList.add(Client);
            }
        }
        system.debug('testClient' +ClientList );
        if(ClientList.size() > 0 ) {
            Update ClientList;
            ClientInserted = true;
        }
        else{
            Client = new Contact();
            Client.firstname = FirstName;
            Client.lastname = LastName;
            Client.email = Email;
            Client.mobilephone = Mobile;
            Insert Client;
            ClientInserted = true;
        }
    }
    
    Public void CreateProductList(){
        selectedProducts=new List<WrapAllProducts>();
        if(AllAvailableProducts.size() > 0){
            for(WrapAllProducts product : AllAvailableProducts){
            system.debug(product.IsSelected);
            system.debug(product.Quantity );
                if(product.IsSelected && Decimal.valueOf(product.Quantity) > 0){
                    selectedProducts.add(product);
                }
            }
        }
        System.debug(selectedProducts);
    }
    
    Public void UnleashVEerything(){
        
        if(ClientInserted){
            Client = [select id,AccountId,account.Name from contact where id =: Client.Id Limit 1];
        }
        PaymentProcessComplted=true;
        if(!SplitPayment){
            TranshistoryList = new List<Transaction_history__c >();
            system.debug(PrimaryPaymentMethod);
            if(PrimaryPaymentMethod=='Credit Card'){
                String ResponseBody=   MakePrimaryPayment(); 
                if(String.IsNotBlank(ResponseBody)){
                    if(ResponseBody.contains('"description":"This transaction has been approved."') || ResponseBody.contains('"description":"Your order has been received. Thank you for your business!"')){
                        System.debug('Success');
                        cardauthpassed=true; 
                        if(String.isNotBlank(ResponseBody.substringBetween(',"transId":"','","')) && String.isNotBlank(ResponseBody.substringBetween(',"accountType":"','","'))){
                                
                                /*CardMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",');
                                System.debug('CardMessage '+CardMessage);
                                
                                PrimaryTransId = ResponseBody.substringBetween(',"transId":"','","');
                                PrimaryMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",');
                                
                               // Create transaction record in the case of success.
                                Transaction_history__c tr = new Transaction_history__c();
                                tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                                tr.Amount__c = PrimaryAmount;
                                tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                                tr.Transaction_Date__c = system.today();
                                tr.status__c = ResponseBody.substringBetween('"description":"','"');
                                if(String.isNotBlank(Client.AccountId)){
                                    tr.Account__c = Client.AccountId;
                                }
                                tr.Credit_Card_Number__c = String.valueOf(PrimaryCardNo);
                                tr.Expiration_Month__c = PrimaryExpirationMonth;
                                tr.Expiration_Year__c =  PrimaryExpirationYear;
                                
                                TranshistoryList.add(tr);
                                
                                //Managing Gratuity
                                /*if(PrimaryAmount <= TreatmentTotal){
                                    PaidBycard = PrimaryAmount;
                                }
                                else if(TreatmentTotal > 0){
                                    PaidBycard = TreatmentTotal;
                                }
                                else if(TreatmentTotal == 0 && String.isNotBlank(membershipgratuity)){
                                    PaidBycard = Decimal.valueOf(membershipgratuity);
                                }
                                  
                                
                                //Creating everyting else....
                                //CreateProductAndServices();
                                
                        }else{
                            // Create Transaction record in the case of failure
                            Transaction_history__c tr = new Transaction_history__c();
                            tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                            tr.Amount__c =  PrimaryAmount;
                            tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                            tr.status__c = ResponseBody.substringBetween('"errorText":"','"');
                            tr.Transaction_Date__c = system.today();
                            if(String.isNotBlank(Client.AccountId)){
                                tr.Account__c = Client.AccountId;
                            }
                            tr.Credit_Card_Number__c = String.ValueOf(PrimaryCardNo);
                            tr.Expiration_Month__c = PrimaryExpirationMonth;
                            tr.Expiration_Year__c =  PrimaryExpirationYear;
                            TranshistoryList.add(tr);
                            
                            System.debug('Failed');
                            cardauthpassed=false;
                            
                        }
                    }
                }
                
                if(TranshistoryList.size()>0 && ClientInserted == true){
                    insert TranshistoryList;
                }
            }else{
                //Creating everyting else in cash payment....
                system.debug('in pri cash');
                Transaction_history__c tr = new Transaction_history__c();
                tr.Transaction_Id__c = 'Paid by cash';
                tr.Amount__c =  PrimaryAmount;
                tr.card_type__c = 'Paid by cash';
                tr.status__c = 'Paid';
                tr.Transaction_Date__c = system.today();
                if(String.isNotBlank(Client.AccountId)){
                    tr.Account__c = Client.AccountId;
                }
                TranshistoryList.add(tr);
                
                if(TranshistoryList.size()>0 && ClientInserted == true){
                    insert TranshistoryList;
                }
                
                PrimaryCash = true;
                
                CashMessage = 'Paid in full by cash.';
            }
            
            /*Payment_Receipt__c PayRec = new Payment_Receipt__c();
            if(String.isNotBlank(SelectedGratuity)){
                PayRec.Gratuity__c=SelectedGratuity;
            }
            if(String.isNotBlank(membershipgratuity)){
                PayRec.Gratuity_Amount__c =Integer.valueOf(membershipgratuity);
            }
            PayRec.Amount_To_Calculate_Gratuity__c = PaidBycard;
            //PayRec.Total_Amount__c=ProductFinalTotal;
            //PayRec.Total_Tax__c=ProductTaxes;
           // PayRec.Appointment__c = AppointmentId;
            //if(String.isNotBlank(Client.AccountId)){
              //  PayRec.Household__c = Client.AccountId ;
                //PayRec.UnsettledGratuity__c= true;
                //Insert Payrec;
            }
        }else{
            system.debug(cardauthpassed);
            TranshistoryList = new List<Transaction_history__c >();
            if(PrimaryPaymentMethod=='Credit Card'){
                String ResponseBody=   MakePrimaryPayment(); 
                System.debug(ResponseBody);
                if(String.IsNotBlank(ResponseBody)){
                    if(ResponseBody.contains('"description":"This transaction has been approved."') || ResponseBody.contains('"description":"Your order has been received. Thank you for your business!"')){
                        System.debug('Success');
                        
                        if(String.isNotBlank(ResponseBody.substringBetween(',"transId":"','","')) && String.isNotBlank(ResponseBody.substringBetween(',"accountType":"','","'))){
                                
                                /*CardMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",');
                                System.debug('CardMessage '+CardMessage);
                               
                                PrimaryTransId = ResponseBody.substringBetween(',"transId":"','","');
                                PrimaryMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",'); 
                                
                                /*if(PrimaryAmount <= TreatmentTotal){
                                    PaidBycard = PrimaryAmount;
                                }
                                else if(TreatmentTotal > 0){
                                    PaidBycard = TreatmentTotal;
                                }
                                else if(TreatmentTotal == 0 && String.isNotBlank(MembershipGratuity)){
                                    PaidBycard = Decimal.ValueOf(MembershipGratuity);
                                }
                               // Create transaction record in the case of success.
                                Transaction_history__c tr = new Transaction_history__c();
                                tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                                tr.Amount__c = PrimaryAmount;
                                tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                                tr.Transaction_Date__c = system.today();
                                tr.status__c = ResponseBody.substringBetween('"description":"','"');
                                if(String.isNotBlank(Client.AccountId)){
                                    tr.Account__c = Client.AccountId;
                                }
                                tr.Credit_Card_Number__c = String.ValueOf(PrimaryCardNo);
                                tr.Expiration_Month__c = PrimaryExpirationMonth;
                                tr.Expiration_Year__c =  PrimaryExpirationYear;
                                TranshistoryList.add(tr);  
                                cardauthpassed=true; 
                                System.debug('Is case of split payment first transaction passed.');
                                
                        }
                    }else{
                        // Create Transaction record in the case of failure
                        Transaction_history__c tr = new Transaction_history__c();
                        tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                        tr.Amount__c =  PrimaryAmount;
                        tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                        tr.status__c = ResponseBody.substringBetween('"errorText":"','"');
                        tr.Transaction_Date__c = system.today();
                        if(String.isNotBlank(Client.AccountId)){
                            tr.Account__c = Client.AccountId;
                        }
                        tr.Credit_Card_Number__c = String.ValueOf(PrimaryCardNo);
                        tr.Expiration_Month__c = PrimaryExpirationMonth;
                        tr.Expiration_Year__c =  PrimaryExpirationYear;
                        TranshistoryList.add(tr);
                        System.debug('Failed');
                        cardauthpassed=false;
                        System.debug('Is case of split payment first transaction Failed.');
                    }
                }
            }
            else{
                system.debug('in pri cash split');
                Transaction_history__c tr = new Transaction_history__c();
                tr.Transaction_Id__c = 'Paid by cash';
                tr.Amount__c =  PrimaryAmount;
                tr.card_type__c = 'Paid by cash';
                tr.status__c = 'Paid';
                tr.Transaction_Date__c = system.today();
                if(String.isNotBlank(Client.AccountId)){
                     tr.Account__c = Client.AccountId;
                }
                
                TranshistoryList.add(tr);
                
                PrimaryCash = true;
                CashMessage = 'Paid partially by cash.';
            }
            
            System.debug(cardauthpassed);
            if((cardauthpassed || PrimaryPaymentMethod == 'Cash' ) && Decimal.valueOf(SecondaryAmount) > 0){
                if((String.IsNotBlank(SecondaryExpirationMonth) && String.IsNotBlank(SecondaryExpirationYear) && String.IsNotBlank(String.valueOf(SecondaryCardNo)) && String.IsNotBlank(String.valueOf(SecondarySecurityCode)) && SecondaryPaymentMethod=='Credit Card')){
                    GatewayAuth__c ga = GatewayAuth__c.getValues('merchant');
                    
                    JSONGenerator gen = JSON.createGenerator(true);
                    gen.writeStartObject();//1
                    gen.writeFieldName('createTransactionRequest');
                    
                    gen.writeStartObject();//2
                    gen.writeFieldName('merchantAuthentication');
                    
                    gen.writeStartObject();//3
                    gen.writeStringField('name',ga.merchantName__c);
                    gen.writeStringField('transactionKey',ga.Transaction_Key__c);
                    gen.writeEndObject();
                    
                    gen.writeStringField('refId', '123456');
                    gen.writeFieldName('transactionRequest');
                    
                    gen.writeStartObject();//4
                    gen.writeStringField('transactionType', 'authCaptureTransaction');
                    gen.writeStringField('amount', string.valueOf(SecondaryAmount));
                    gen.writeFieldName('payment');
                    
                    gen.writeStartObject();//5
                    gen.writeFieldName('creditCard');
                    
                    gen.writeStartObject();//6
                    gen.writeStringField('cardNumber', String.ValueOf(SecondaryCardNo));
                    gen.writeStringField('expirationDate', SecondaryExpirationYear+'-'+SecondaryExpirationMonth);
                    gen.writeStringField('cardCode', String.ValueOf(SecondarySecurityCode));
                    gen.writeEndObject();
                    
                    
                    gen.writeEndObject();
                    
                    gen.writeFieldName('customer');
                    gen.writeStartObject();
                    if(String.isNotBlank(Email)){
                        gen.writeStringField('email', Email);    
                    }
                    gen.writeEndObject();
                    
                    gen.writeFieldName('billTo');
                    gen.writeStartObject();
                    if(String.isNotBlank(FirstName)){
                       gen.writeStringField('firstName', FirstName);
                    }
                    if(String.isNotBlank(LastName)){
                        gen.writeStringField('lastName', LastName);
                    }
                    if(string.isNotBlank(Client.Account.Name)){
                       gen.writeStringField('company', Client.Account.Name);
                    }
                    if(string.isNotBlank(PrimaryBillingStreet)){
                       gen.writeStringField('address', SecondaryBillingStreet);
                    }
                    if(String.isNotBlank(PrimaryBillingCity)){
                       gen.writeStringField('city', SecondaryBillingCity);
                    }
                    if(String.isNotBlank(PrimaryBillingState)){
                       gen.writeStringField('state', SecondaryBillingState);
                    }
                    if(String.isNotBlank(String.valueOf(SecondaryBillingZip))){
                       gen.writeStringField('zip', String.valueOf(SecondaryBillingZip));
                    }
                    if(String.isNotBlank(Mobile)){
                       gen.writeStringField('phoneNumber', Mobile);
                    }
                    gen.writeEndObject();
                    gen.writeEndObject();
                    gen.writeEndObject();
                    gen.writeEndObject();
                    
                    // Instantiate a new http object
                    Http h = new Http();
                    
                    // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
                    HttpRequest req = new HttpRequest();
                    req.setEndpoint(ga.EndPoint_URL__c);
                    req.setHeader('Content-Type', 'application/json');
                    req.setMethod('POST');
                    req.setBody(gen.getAsString());
                    // Send the request, and return a response
                    HttpResponse res = new HttpResponse();
                    if(Test.isRunningTest()){
                        res.setBody('﻿{"transactionResponse":{"responseCode":"1","authCode":"ICB6TR","avsResultCode":"Y","cvvResultCode":"P","cavvResultCode":"2","transId":"60036066245","refTransID":"","transHash":"0A3DEB95FCA15DFEE5E7496ABFD8C8D9","testRequest":"0","accountNumber":"XXXX0015","accountType":"MasterCard","messages":[{"code":"1","description":"This transaction has been approved."}],"transHashSha2":""},"refId":"123456","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}') ;                
                    }else{
                        res = h.send(req);
                    }            
                    System.debug(res.getBody());
                    if(String.IsNotBlank(res.getBody())){
                        //String ResponseBody='﻿{"transactionResponse":{"responseCode":"1","authCode":"ICB6TR","avsResultCode":"Y","cvvResultCode":"P","cavvResultCode":"2","transId":"60036066245","refTransID":"","transHash":"0A3DEB95FCA15DFEE5E7496ABFD8C8D9","testRequest":"0","accountNumber":"XXXX0015","accountType":"MasterCard","messages":[{"code":"1","description":"This transaction has been approved."}],"transHashSha2":""},"refId":"123456","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}';
                        String ResponseBody=res.getBody();
                        system.debug('ResponseBody'+ResponseBody);
                        if(ResponseBody.contains('"description":"This transaction has been approved."') || ResponseBody.contains('"description":"Your order has been received. Thank you for your business!"')){
                            System.debug('Success');
                            cardauthpassedSecondary=true; 
                            
                            if(String.isNotBlank(ResponseBody.substringBetween(',"transId":"','","')) && String.isNotBlank(ResponseBody.substringBetween(',"accountType":"','","'))){
                                    
                                    /*CardMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",');
                                    System.debug('CardMessage '+CardMessage);
                                    
                                    SecondaryTransId = ResponseBody.substringBetween(',"transId":"','","');
                                    SecondaryMessage = 'CARDTYPE: '+ResponseBody.substringBetween(',"accountType":"','","') +', CARD NO: '+ResponseBody.substringBetween('"accountNumber":"','",');
                                    
                                    System.debug('Is case of split payment Second transaction passed.');
                                   // Create transaction record in the case of success.
                                    Transaction_history__c tr = new Transaction_history__c();
                                    tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                                    tr.Amount__c = Decimal.valueOf(SecondaryAmount);
                                    tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                                    tr.Transaction_Date__c = system.today();
                                    tr.status__c = ResponseBody.substringBetween('"description":"','"');
                                    if(String.isNotBlank(Client.AccountId)){
                                        tr.Account__c = Client.AccountId;
                                    }
                                    tr.Credit_Card_Number__c = String.ValueOf(SecondaryCardNo);
                                    tr.Expiration_Month__c = SecondaryExpirationMonth;
                                    tr.Expiration_Year__c =  SecondaryExpirationYear;
                                    
                                    TranshistoryList.add(tr);  
                            }
                            
                            CreateProductAndServices();
                           
                        }else{
                        
                          // Create Transaction record in the case of failure
                            
                            System.debug('Is case of split payment Second transaction Failed.');
                            Transaction_history__c tr = new Transaction_history__c();
                            tr.Transaction_Id__c = ResponseBody.substringBetween(',"transId":"','","');
                            tr.Amount__c =  Decimal.valueOf(SecondaryAmount);
                            tr.card_type__c = ResponseBody.substringBetween(',"accountType":"','","') ;
                            tr.status__c = ResponseBody.substringBetween('"errorText":"','"');
                            tr.Transaction_Date__c = system.today();
                            if(String.isNotBlank(Client.AccountId)){
                                tr.Account__c = Client.AccountId;
                            }
                            tr.Credit_Card_Number__c = String.ValueOf(SecondaryCardNo);
                            tr.Expiration_Month__c = SecondaryExpirationMonth;
                            tr.Expiration_Year__c =  SecondaryExpirationYear;
                            TranshistoryList.add(tr);
                            System.debug('Failed');
                            cardauthpassedSecondary=false;
                        }
                    }
                    
                }else{
                    //Paid in cash
                    Transaction_history__c tr = new Transaction_history__c();
                    tr.Transaction_Id__c = 'Paid by cash';
                    tr.Amount__c =  Decimal.valueOf(SecondaryAmount);
                    tr.card_type__c = 'Paid by cash';
                    tr.status__c = 'Paid';
                    tr.Transaction_Date__c = system.today();
                    if(String.isNotBlank(Client.AccountId)){
                        tr.Account__c = Client.AccountId;
                    }
                    
                    TranshistoryList.add(tr);
                    
                    SecondaryCash = true;
                    CashMessage = 'Paid Partially by cash.';
                    CreateProductAndServices();
                }
            }
            
            /*if(ClientInserted == true){
                Payment_Receipt__c PayRec = new Payment_Receipt__c();
                if(String.isNotBlank(SelectedGratuity)){
                    PayRec.Gratuity__c=SelectedGratuity;
                }
                if(String.isNotBlank(membershipgratuity)){
                    PayRec.Gratuity_Amount__c =Integer.valueOf(membershipgratuity);
                }
                //PayRec.Amount_To_Calculate_Gratuity__c = PaidBycard;
                PayRec.Total_Amount__c=ProductFinalTotal;
                PayRec.Total_Tax__c=ProductTaxes;
                //PayRec.Appointment__c = AppointmentId;
                PayRec.Household__c = Client.AccountId;
                //PayRec.UnsettledGratuity__c= true;
            
                Insert Payrec;
            }
            
            
            if(TranshistoryList.size()>0 && ClientInserted == true){
                insert TranshistoryList;
            }
        }
    }
    
    public String MakePrimaryPayment(){
        system.debug(PrimaryExpirationMonth+'-----'+PrimaryExpirationYear+'-------'+PrimaryCardNo+'------'+PrimarySecurityCode+'---------'+PrimaryPaymentMethod );
        if(String.IsNotBlank(PrimaryExpirationMonth) && String.IsNotBlank(PrimaryExpirationYear) && String.IsNotBlank(String.valueOf(PrimaryCardNo)) && String.IsNotBlank(String.valueOf(PrimarySecurityCode)) && PrimaryPaymentMethod=='Credit Card' && cardauthpassed==false){
            GatewayAuth__c ga = GatewayAuth__c.getValues('merchant');
            
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();//1
            gen.writeFieldName('createTransactionRequest');
            
            gen.writeStartObject();//2
            gen.writeFieldName('merchantAuthentication');
            
            gen.writeStartObject();//3
            gen.writeStringField('name',ga.merchantName__c);
            gen.writeStringField('transactionKey',ga.Transaction_Key__c);
            gen.writeEndObject();
            
            gen.writeStringField('refId', '123456');
            gen.writeFieldName('transactionRequest');
            
            gen.writeStartObject();//4
            gen.writeStringField('transactionType', 'authCaptureTransaction');
            gen.writeStringField('amount', string.valueOf(PrimaryAmount));
            gen.writeFieldName('payment');
            
            gen.writeStartObject();//5
            gen.writeFieldName('creditCard');
            
            gen.writeStartObject();//6
            gen.writeStringField('cardNumber', String.valueOf(PrimaryCardNo));
            gen.writeStringField('expirationDate', PrimaryExpirationYear+'-'+PrimaryExpirationMonth);
            gen.writeStringField('cardCode', String.valueOf(PrimarySecurityCode));
            gen.writeEndObject();
            
            
            gen.writeEndObject();
            
            gen.writeFieldName('customer');
            gen.writeStartObject();
            if(String.isNotBlank(Email)){
                gen.writeStringField('email', Email);    
            }
            gen.writeEndObject();
            
            gen.writeFieldName('billTo');
            gen.writeStartObject();
            if(String.isNotBlank(FirstName)){
               gen.writeStringField('firstName', FirstName);
            }
            if(String.isNotBlank(LastName)){
                gen.writeStringField('lastName', LastName);
            }
            
            if(string.isNotBlank(Client.AccountId)){
               gen.writeStringField('company', Client.Account.Name);
            }
            if(string.isNotBlank(SecondaryBillingStreet)){
               gen.writeStringField('address', SecondaryBillingStreet);
            }
            if(String.isNotBlank(SecondaryBillingCity)){
               gen.writeStringField('city', SecondaryBillingCity);
            }
            if(String.isNotBlank(SecondaryBillingState)){
               gen.writeStringField('state', SecondaryBillingState);
            }
            if(String.isNotBlank(String.valueOf(SecondaryBillingZip))){
               gen.writeStringField('zip', String.valueOf(SecondaryBillingZip));
            }
            if(String.isNotBlank(Mobile)){
               gen.writeStringField('phoneNumber',Mobile);
            }
            gen.writeEndObject();
            gen.writeEndObject();
            gen.writeEndObject();
            gen.writeEndObject();
            
            // Instantiate a new http object
            Http h = new Http();
            
            // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
            HttpRequest req = new HttpRequest();
            req.setEndpoint(ga.EndPoint_URL__c);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('POST');
            req.setBody(gen.getAsString());
            // Send the request, and return a response
            HttpResponse res = new HttpResponse();
            if(Test.isRunningTest()){
                res.setBody('﻿{"transactionResponse":{"responseCode":"1","authCode":"ICB6TR","avsResultCode":"Y","cvvResultCode":"P","cavvResultCode":"2","transId":"60036066245","refTransID":"","transHash":"0A3DEB95FCA15DFEE5E7496ABFD8C8D9","testRequest":"0","accountNumber":"XXXX0015","accountType":"MasterCard","messages":[{"code":"1","description":"This transaction has been approved."}],"transHashSha2":""},"refId":"123456","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}') ;                
            }else{
                res = h.send(req);
            }            
            System.debug(res.getBody());
            if(String.IsNotBlank(res.getBody())){
                return res.getBody();
            }
        }
        return null;
    }
    
    Public void CreateProductAndServices(){
        /*ProductsBought = new List<Household_Product__c>();
        for(WrapAllProducts w : selectedProducts){
            Household_Product__c hp = new Household_Product__c();
            //hp.Appointment__c = AppointmentId;
            hp.Product__c = w.Product.Id ;
            hp.Total_Price__c = w.FinalPrice;
            hp.Quantity__c = w.quantity;
            hp.Base_Price__c = w.product.Regular_Price__c;
            ProductsBought.add(hp);
        }
        
        if(ProductsBought.size()>0){
            insert ProductsBought;
        }
    }
    
    Public pagereference AttachEmailDownloadPDF(){   
        
        PageReference pdf = new pagereference('/apex/BuyProductsReceipt');
        pdf.SetRedirect(false);
        Attachment Attach= new Attachment();
        Blob body;
        
        try {
            body = pdf.getContentAsPDF();
            
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        Attach.Body = body;
        Attach.Name = 'ProductReceipt.pdf';
        Attach.IsPrivate = false; 
        system.debug('Client.AccountId--->'+Client.AccountId);   
        if(String.isNotBlank(Client.AccountId)){
            Attach.ParentId = Client.AccountId;
            insert Attach;
        }
            
        List<string> ToAddresses = new List<string>();
        ToAddresses.add(Email);
        Blob attbody;
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        
        if(!Test.IsRunningTest()){
            attbody = pdf.getContentAsPDF();
            efa1.setFileName('ProductReceipt.pdf');
            efa1.setBody(attbody);
            fileAttachments.add(efa1);
        }
        string htmlbody = '';
        String subject = 'Payment Receipt';
        htmlbody = '<h1>LICE TROOPERS</h1> <br/>The safe & smart solution for head lice removal.<br/><br/>Thank you for using Lice Troopers.<br/>It was a pleasure to serve you!<br/><br/>[Order/Service/Payment Information]<br/><br/><br/><br/><br/>Lice Troopers thanks you for your business.<br/><br/>It is our aim to provide the safest and most effective lice<br/>removal treatment possible as we help families get lice free.<br/>We’re here to serve you—please let us know<br/>how we can continue to provide the finest customer service.<br/><br/>Thank you from your friends at Lice Troopers<br/> © 1980-2018 All rights reserved - Lice Troopers®<br/>Lice Troopers, Inc. | 5743 Hollywood Blvd. | Hollywood, FL 33021 | USA<br/>General Enquiries: 800-403-5423  | ';

        mail.setSubject(subject);
        mail.setToAddresses(ToAddresses);
        mail.setHtmlBody(htmlbody);
        mail.setFileAttachments(fileAttachments);
        mails.add(mail);  
        //Messaging.sendEmail(mails);
        if(ToAddresses.size() > 0 && String.isNotBlank(Email)){
            Messaging.SendEmailResult[] results1 = Messaging.sendEmail(mails);
        }
        return pdf;
    }
    
    public List<SelectOption> getLocationsOptions() {
        List<SelectOption> LocationOptions = new List<SelectOption>();
        LocationOptions.add(new SelectOption('','--None--'));
        LocationOptions.add(new SelectOption('Coral Gables','Coral Gables'));
        LocationOptions.add(new SelectOption('Kendall','Kendall'));
        LocationOptions.add(new SelectOption('Bay Harbor','Bay Harbor'));
        LocationOptions.add(new SelectOption('Hollywood','Hollywood'));
        LocationOptions.add(new SelectOption('Winter Park','Winter Park'));
        LocationOptions.add(new SelectOption('Plantation','Plantation'));
        LocationOptions.add(new SelectOption('Orlando','Orlando'));

        return LocationOptions;
    }
    
    public List<SelectOption> getPaymentMethodsOptions() {
        List<SelectOption> PaymentMethodOptions = new List<SelectOption>();
        PaymentMethodOptions .add(new SelectOption('','--None--'));
        PaymentMethodOptions .add(new SelectOption('Cash','Cash'));
        PaymentMethodOptions .add(new SelectOption('Credit Card','Credit Card'));
        
        return PaymentMethodOptions;
    }
    
    public List<SelectOption> getExpirationYearsOptions() {
        List<SelectOption> ExpirationYearOptions = new List<SelectOption>();
        ExpirationYearOptions.add(new SelectOption('','--None--'));
        ExpirationYearOptions.add(new SelectOption('2018','2018'));
        ExpirationYearOptions.add(new SelectOption('2019','2019'));
        ExpirationYearOptions.add(new SelectOption('2020','2020'));
        ExpirationYearOptions.add(new SelectOption('2021','2021'));
        ExpirationYearOptions.add(new SelectOption('2022','2022'));
        ExpirationYearOptions.add(new SelectOption('2023','2023'));
        ExpirationYearOptions.add(new SelectOption('2024','2024'));
        ExpirationYearOptions.add(new SelectOption('2025','2025'));
        ExpirationYearOptions.add(new SelectOption('2026','2026'));
        ExpirationYearOptions.add(new SelectOption('2027','2027'));
        ExpirationYearOptions.add(new SelectOption('2028','2028'));
        ExpirationYearOptions.add(new SelectOption('2029','2029'));
        ExpirationYearOptions.add(new SelectOption('2030','2030'));
        
        return ExpirationYearOptions;
    }
    
    public List<SelectOption> getExpirationMonthsOptions() {
        List<SelectOption> ExpirationMonthOptions = new List<SelectOption>();
        ExpirationMonthOptions.add(new SelectOption('','--None--'));
        ExpirationMonthOptions.add(new SelectOption('01','01'));
        ExpirationMonthOptions.add(new SelectOption('02','02'));
        ExpirationMonthOptions.add(new SelectOption('03','03'));
        ExpirationMonthOptions.add(new SelectOption('04','04'));
        ExpirationMonthOptions.add(new SelectOption('05','05'));
        ExpirationMonthOptions.add(new SelectOption('06','06'));
        ExpirationMonthOptions.add(new SelectOption('07','07'));
        ExpirationMonthOptions.add(new SelectOption('08','08'));
        ExpirationMonthOptions.add(new SelectOption('09','09'));
        ExpirationMonthOptions.add(new SelectOption('10','10'));
        ExpirationMonthOptions.add(new SelectOption('11','11'));
        ExpirationMonthOptions.add(new SelectOption('12','12'));
        
        return ExpirationMonthOptions;
    }
    
    //Wrapper Class For Products
    Public Class WrapAllProducts{
        Public Product__c Product{get;set;}
        Public Boolean IsSelected{get;set;}
        Public Integer Quantity{get;set;}
        Public String FinalPrice{get;set;}
        Public Decimal Discount{get;set;}
        Public WrapAllProducts(Product__c Product){
            this.Product=Product;
            Quantity= 0;
            FinalPrice='';
            Discount = 0;
            IsSelected = false;
        }
    }
}b*/
}