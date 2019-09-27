global class JsRemotingExample {
    
    Public String name {get;set;}
    @RemoteAction
    public static String showText(String name) 
    {
        return 'Hello '+name +', you did a server request to this method through Javascript remoting in salesforce';
    }
    
}