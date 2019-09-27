public with sharing class SaveImage {
    @RemoteAction public static Id saveImage(String name, String contentType, String data) {
        System.debug('name '+name);
        System.debug('contentType '+contentType);
        System.debug('data '+data);
        Document d = new Document(Name=name, FolderId=UserInfo.getUserId(), contentType=contentType, Body=EncodingUtil.base64Decode(data));
        Database.insert(d, true);
        return d.id;
    }
}