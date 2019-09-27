@istest
private class TestSendEmail {
    @istest
    static void show(){
        Opportunity opp= new Opportunity();
        opp.StageName='Closed Lost';
        opp.Name='test';
        opp.CloseDate=system.today();
        insert opp;
        
        opp.StageName= 'closed won ';
        update opp;
        
        List<Opportunity> optylist= new List<Opportunity>();
        SendEmailT setr= new SendEmailT();
        setr.onAfterUpdate(optylist);
        
        
        
        
    

}    
    

}