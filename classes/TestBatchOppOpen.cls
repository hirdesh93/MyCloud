@istest
private class TestBatchOppOpen {
	@istest
    static void show(){
        test.startTest();
        BatchOppOpen Batch= new BatchOppOpen();
        List<Opportunity> scope=  new List<Opportunity>();
        database.BatchableContext bc;
        batch.execute(bc, Scope);
        batch.start(bc);
        batch.finish(bc);
        test.stopTest();
}
}