Public class extattachfile{
    Public attachment objAttachment{get; set;}
    Public Contact objApplicant{get; set;}
    Public extattachfile(apexpages.standardcontroller stdCon){
        objAttachment = new Attachment();
        objApplicant = new Contact();
    }
    Public void saveApplicant(){
        insert objApplicant;
       
        objAttachment.ParentId = objApplicant.id;
        insert objAttachment;
    }
}