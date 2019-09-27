public class MultipleUploadController
{   
    //Selected count
    public String FileCount {get; set;}
    
    public List<Attachment> allFileList {get; set;}
    
    public MultipleUploadController(ApexPages.StandardController controller)
    {
        //Initialize  
        FileCount = '1' ;
        allFileList = new List<Attachment>() ;
        for(Integer i = 1 ; i <= Integer.valueOf(FileCount) ; i++)
            allFileList.add(new Attachment()) ;
        //Adding values count list - you can change this according to your need
        
    }
    
    public Pagereference SaveAttachments()
    {
        String accId = System.currentPagereference().getParameters().get('id');
        if(accId == null || accId == '')
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'No record is associated. Please pass record Id in parameter.'));
        if(FileCount == null || FileCount == '')
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select how many files you want to upload.'));

        List<Attachment> listToInsert = new List<Attachment>() ;
        
        //Attachment a = new Attachment(parentId = accid, name=myfile.name, body = myfile.body);
        for(Attachment a: allFileList)
        {
            if(a.name != '' && a.name != '' && a.body != null)
                listToInsert.add(new Attachment(parentId = accId, name = a.name, body = a.body)) ;
        }
        
        //Inserting attachments
        if(listToInsert.size() > 0)
        {
            insert listToInsert ;
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO, listToInsert.size() + ' file(s) are uploaded successfully'));
            FileCount = '' ;
        }
        else
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select at-least one file'));
            
        return null;
    }
   
}