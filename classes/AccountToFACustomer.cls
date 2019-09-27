public with sharing class AccountToFACustomer{ 

        public class Response {
        public integer code {get; set;}
        public String body {get; set;}
        public boolean success {get; set;}
        
        public Response (integer code, String body){
                this.code = code;
        		this.body = body;
        		this.success = (code == 200 || code == 201);
        }
    }
	
    public class CustomerResponse{     
        public string uuid {get; set;}
        public string link {get; set;}
        public string location {get; set;}
    }
  

    public Response CreateCustomer(){
        
        Response resp;
        
        string endpoint = 'https://apistaging.website.net/customer/';
        string token = 'Token XXXXXXXX';
        string method = 'POST';
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new http();
        
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setHeader('Authorization', token);
		req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept-Type', 'application/json');
        
        
        req.setBody(
            '{"name":"'+ Account.Name +'",' +
            
             '"phone":"'+ Account.Phone +'",'+
             '"website":"'+ Account.Website +'",'+
             '"location":{'+
                    '"streetName":"'+ Account.BillingStreet +'",'+
                    '"locality":"'+ Account.BillingCity +'",'+
                    '"postcode":"'+ Account.BillingState +'",'+
                    '"country":"'+ Account.BillingCountry +'" }}' 
        );
        

            
		res = h.send(req);
        resp = new Response(res.getStatusCode(), res.getBody());         
        return resp;   
    
    }
}