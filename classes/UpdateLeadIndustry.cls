global class UpdateLeadIndustry {
   // List<Lead> Leadlist = [select id,FirstName,LastName,Leadsource, Industry from Lead];
    public void updateLead(List<Lead> Leadlist){
        List<Lead> leadList1 = [select id,FirstName,LastName,Leadsource, Industry from Lead where Industry = '' AND id in : Leadlist limit 5 ];
        for(Lead l : leadList1){
            l.Industry = 'Banking';
        }
        update leadList1; 
    }
    public void updateLead1(List<Lead> Leadlist){
        List<Lead> leadList2 = [select id,FirstName,LastName,Leadsource, Industry from Lead where  Industry = '' AND id in : Leadlist limit 5 ];
        for(Lead l : leadList2){
            l.Industry = 'Agriculture';
        }
        update leadList2; 
    }   
    public void updateLead2(List<Lead> Leadlist){
        List<Lead> leadList3 = [select id,FirstName,LastName,Leadsource, Industry from Lead where Industry = '' AND id in : Leadlist limit 5];
        for(Lead l : leadList3){
            l.Industry = 'Education';
        }
        update leadList3;  
    }
    
    
}