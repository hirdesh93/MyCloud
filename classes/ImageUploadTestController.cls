public with sharing class ImageUploadTestController {

    public blob file { get; set; }
    public String imageFilePath { get; set; }

    public ContentVersion cv { get; set; }

    public ImageUploadTestController() {
        cv = [select id, versionData, title, pathOnClient FROM ContentVersion limit 1];
    }

    //fill out the inputFile field and press go. This will upload file to the server
    public PageReference go() {
        ContentVersion v = new ContentVersion();
        v.versionData = file;
        v.title = 'some title';
        v.pathOnClient ='/foo.jpeg';
        insert v;

        return new PageReference('/' + v.id);
    }

    //v.id sample
    //069A00000009Ux3

}//end class