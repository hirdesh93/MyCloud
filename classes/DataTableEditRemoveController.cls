public class DataTableEditRemoveController {
    public List<Account> accs { get; set; }
    
    //used to get a hold of the account record selected for deletion
    public string SelectedAccountId { get; set; }
    
    public DataTableEditRemoveController() {
        //load account data into our DataTable
        LoadData();
    }
    
    private void LoadData() {
        accs = [Select id, name, BillingStreet, BillingCity, BillingPostalCode, BillingCountry from Account limit 20];
    }
    
    public void DeleteAccount()
    {
        // if for any reason we are missing the reference
        if (SelectedAccountId == null) {
            
            return;
        }
        
        // find the account record within the collection
        Account tobeDeleted = null;
        for(Account a : accs)
            if (a.Id == SelectedAccountId) {
                tobeDeleted = a;
                break;
            }
        
        //if account record found delete it
        if (tobeDeleted != null) {
            Delete tobeDeleted;
        }
        
        //refresh the data
        LoadData();
    }
    
    
}