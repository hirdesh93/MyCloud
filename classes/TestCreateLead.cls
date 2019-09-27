@isTest
private class TestCreateLead {
    static testMethod void protectFields(){
    createLead.CreateNewLead();
     	Lead l = new Lead();
        l.Company = 'JohnMiller';
        l.LastName = 'Mike';
        l.Status = 'Open';               
        insert l;
    }
}