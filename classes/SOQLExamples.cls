public class SOQLExamples {
    public string textName{get;set;}
    public integer limitNew {get;set;}
    public list<account> accList {get;set;}
    public list<contact> conList {get;set;}
    public SOQLExamples(){
        textName ='';
        limitnew = 0;
        accList = new list<account>();
        conList = new list<contact>();
    }
    public void soqlDeleted(){
        conList = [select id, LastName from contact where isDeleted = true all rows];
    }
    public void soqlAllRows(){
        conList = [select id, LastName from contact all rows];
    }
    public void soql(){
        conList = [select id, LastName from contact all rows];
    }


}