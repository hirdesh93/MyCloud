public class DisplayPickListValues {
    public List<SelectOption> getTypeOptions(){
           List<SelectOption> options = new List<SelectOption>();
           Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
           List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p : ple){
               options.add(new SelectOption(p.getValue(), p.getValue()));
        }
           return options;
     }

}