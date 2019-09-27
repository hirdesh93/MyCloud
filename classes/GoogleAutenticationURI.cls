global class GoogleAutenticationURI {
    global string authenticationUri = '';
    public GoogleAutenticationURI(string clientkey,string redirect_uri){
        string key = encodingutil.urlEncode(clientkey, 'UTF-8');
        string uri = encodingutil.urlEncode(redirect_uri, 'UTF-8');
        
        String authuri = 'https://accounts.google.com/o/oauth2/auth?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope=https://www.googleapis.com/auth/drive'+
            '&redirect_uri='+uri+
            '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+
            '&login_hint=engineer.gangil@gmail.com&'+
            'access_type=offline';
        
        authenticationUri = authuri;
    }
    
}