public with sharing class CreateContactTr {
    @future
    public Static void AddContact(set<Id> userIds) {
        List<User> userList = [select Id, firstname, lastname, email, CompanyName,Phone,Fax,Department FROM User where Id IN :userIds];
        List<Contact> conList = new List<Contact>();
        
        for (User u : userList) {
            
            Account acc = new Account();
            acc.Name = u.CompanyName;
            insert acc;
            
            Contact con = new Contact();
            con.AccountId = acc.id;
            con.FirstName = u.FirstName;
            con.LastName = u.LastName;
            con.Email = u.Email;
            //con.Id = u.Id;
            con.Phone = u.Phone;
            con.Fax = u.Fax;
            con.Department = u.Department;
          //  con.Title = u.Title;
          //  con.MailingStreet = u.Street;
          //  con.MailingCity = u.City;
           // con.MailingCountry = u.Country;
           // con.MailingGeocodeAccuracy = u.GeocodeAccuracy;
           // con.MailingLatitude = u.Latitude;
           // con.MailingLongitude = u.Longitude;
           // con.MailingPostalCode = u.PostalCode;
           // con.MailingState= u.State;
           conlist.add(con);
        }
        insert conlist;
    }
}