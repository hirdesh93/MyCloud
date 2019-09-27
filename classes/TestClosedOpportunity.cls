@istest
private class TestClosedOpportunity {
    @istest
    static void show(){
        Opportunity opp= new opportunity();
        opp.Name='TestOpp';
        opp.CloseDate=system.today();
        opp.StageName='closed won';
        insert opp;
        

        opp.Name='testop';
        update opp;
        
        Task t = new Task();
        t.WhatId= opp.Id;
        t.Subject='Follow Up Test Task';
        insert t;
        
        
        
        
        
        
    }
}