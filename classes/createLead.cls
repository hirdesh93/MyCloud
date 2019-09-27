public class createLead {

    public static void  CreateNewLead(){
	Lead lstLead =   new Lead();
        lstLead.Company = 'JohnMiller';
        lstLead.LastName = 'Mike';
        lstLead.Status = 'Open';               
        insert lstLead;   
        
       
    }
    
}