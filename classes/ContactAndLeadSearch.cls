public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(string lastname){
    List<List<Sobject>> contactsandleadsrecords =
        [find 'Smith' in all fields RETURNING contact(Name),lead(lastname)];
        system.debug('===='+ contactsandleadsrecords);
     return contactsandleadsrecords ;
        }
}