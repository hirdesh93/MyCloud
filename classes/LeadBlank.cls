public class LeadBlank {
    List<Lead> Leadlist = [select id,FirstName,LastName,Leadsource, Industry from Lead];
    public void updateLead(){
      //  List<Lead> leadList1 = [select id,FirstName,LastName,Leadsource, Industry from Lead where Industry = '' AND id in : Leadlist limit 5 ];
        for(Lead l : Leadlist){
            l.Industry = '';
        }
        update Leadlist; 
    }

}