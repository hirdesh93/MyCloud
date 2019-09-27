public class AttachmentClass {
    public List<Attachment> allFileList {get; set;}
    public AttachmentClass(ApexPages.StandardController c){
        allFileList = new List<Attachment>() ;
        for(Integer i = 1 ; i <= 1; i++)
            allFileList.add(new Attachment()) ;
    }
    public Attachment attachment {
        get{
            if(attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    public void upload(){
        string accId = ApexPages.CurrentPage().getParameters().get('id'); 
        List<Attachment> listToInsert = new List<Attachment>() ;
        for(Attachment a: allFileList){
            if(a.name != '' && a.name != '' && a.body != null)
                listToInsert.add(new Attachment(parentId = accId, name = a.name, body = a.body)) ;
        }
        if(listToInsert.size() >0){
            insert listToInsert;
        }
    }
}