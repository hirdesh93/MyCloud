public class InputFileUsingHtmlJavaScript {
    public InputFileUsingHtmlJavaScript (ApexPages.StandardController controller) {}

 public Attachment attachment {
        get{
            if(attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    public PageReference upload(){
        attachment.OwnerId = UserInfo.getUserId();
        attachment.ParentId = ApexPages.CurrentPage().getParameters().get('id'); // the record the file is attached to
        attachment.IsPrivate = false;  
        System.debug('$$$$$$$$$$'+attachment.ContentType + '  '+attachment.name) ; 
        if(string.isBlank(attachment.ContentType) || string.isEmpty(attachment.ContentType)) {
            if(attachment.Name.endsWithIgnoreCase('.txt'))
                attachment.ContentType='text/plain';
            else if(attachment.Name.endsWithIgnoreCase('.csv'))
                attachment.ContentType='application/csv';
            else if(attachment.Name.endsWithIgnoreCase('.doc'))
                attachment.ContentType='application/msword';
            else if(attachment.Name.endsWithIgnoreCase('.png'))
                attachment.ContentType='image/png';
            else if(attachment.Name.endsWithIgnoreCase('.jpg') || attachment.Name.endsWithIgnoreCase('.jpeg'))
                attachment.ContentType='image/jpg';
        } 
        try {
            insert attachment;
        }catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
            return null;
        }finally {
            attachment = new Attachment(); 
        }   
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
        pageRef.setRedirect(true);
        return pageRef;
    }

   }