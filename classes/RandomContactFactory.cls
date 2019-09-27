public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer iContacts, String sLastName){
        List<Contact> lstRndContacts = new List<Contact>();
        for(Integer i=0; i<iContacts; i++){
            Contact oContact = new Contact(LastName = sLastName, FirstName = 'FN_'+i);
            lstRndContacts.add(oContact);
        }
        system.debug('===Conlist==='+lstRndContacts);
        return lstRndContacts;
    }
}