global class CreateCSVFile {
    public CreateCSVFile(){}
    webservice static void CreateCSVFiles(Id aId){
        
        contact con =  [SELECT Id,FirstName ,Lastname , Phone FROM Contact where Id =: aId];
        string header = 'Record Id, FirstName , Lastname, Phone \n';
        string recordString = con.id+','+con.FirstName+','+con.Lastname+','+con.Phone +'\n';
        string finalstr = header ;
        finalstr = finalstr +recordString;
        blob csvBlob = Blob.valueOf(finalstr);
        string csvname= 'Account.xls';
        
        Attachment attachment = new Attachment();
        attachment.Body = csvBlob ;
        attachment.Name = String.valueOf('test.csv');
        attachment.ParentId = con.Id; 
        insert attachment;
        
    }
    
}