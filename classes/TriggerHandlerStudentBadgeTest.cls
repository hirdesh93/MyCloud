@istest
private class TriggerHandlerStudentBadgeTest {
	@istest
    static void Test(){
        
        Badge__c bg = new Badge__c();
        bg.Type__c ='IT';
        bg.Name = 'test';
        bg.Points__c = 20;
        insert bg;
        
        Program__c pg = new Program__c();
        pg.Name = 'test pg';
        pg.Date__c = system.today();
        pg.Type__c =' it';
        pg.Badge__c = bg.Id;
        insert pg;
        
        contact con = new Contact();
        con.lastName = 'test Last';
        insert con;
        
        EnrollMent__c et = new EnrollMent__c();
        et.Status__c = 'Completed';
        et.Student__c = con.Id;
        et.Program__c = Pg.Id;
        insert et;
        
        Student_Badge__c stu = new Student_Badge__c();
        stu.Badge__c = bg.Id;
        stu.Student__c = con.Id;
        insert stu;
        
        delete stu;
    }
}