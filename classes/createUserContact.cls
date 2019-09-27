public class createUserContact {
    
    public static void createNewContact(set<ID> recordIDs){
        system.debug('testrecordIDs'+recordIDs);
        List<Contact> contactlist = new List<Contact>();
        
        list<user> users = [Select ID, FirstName,LastName, Title,Department,Phone,Fax,Email,Street,City,State,PostalCode,Country from user where id IN :recordIDs];
        for (user u: users){ 
            Contact con = new Contact();
          //  con.FirstName = u.FirstName;
            con.LastName = u.LastName;
          /*  con.Email = u.Email;
            con.Phone = u.Phone;
            con.Fax = u.Fax;
            con.Department = u.Department;
            con.Title = u.Title;
            con.MailingStreet = u.Street;
            con.MailingCity = u.City;
            con.MailingCountry = u.Country;
            con.MailingPostalCode = u.PostalCode;
            con.MailingState= u.State; */
            contactlist.add(con);  
            system.debug('testcontacts'+contactlist);
        }
        if(contactlist.size() > 0){
            insert contactlist;
        }
    }
    
}