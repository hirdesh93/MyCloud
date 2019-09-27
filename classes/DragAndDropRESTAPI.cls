@RestResource(urlMapping='/DragAndDrop/v1/*')
global with sharing class DragAndDropRESTAPI{
    @HttpPost
    global static String attachDoc(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        String fName = req.params.get('FileName');
        String parId = req.params.get('parId');
        Blob postContent = req.requestBody; 
        Attachment attachment = new Attachment (ParentId=parId,Body=postContent,Name=fName);
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
        insert attachment;
        return attachment.Id;
   }
}