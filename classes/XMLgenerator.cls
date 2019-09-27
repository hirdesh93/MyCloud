global class XMLgenerator{
    webservice static string GenerateXML(ID conId){
        /*
         String s = 'Ram is going to school';
String firstName;
String LastName;
if(String.isNotBlank(s)){
s = s.trim();
List<String> nameslist = s.split(' ');
firstName =	nameslist[0];
LastName = '';
for(integer i=1;i<nameslist.size();i++){
	if(i == nameslist.size()-1){
		LastName = nameslist[i];
	}else{
		firstName = firstName+' '+nameslist[i];
	}
}
}

String s = 'Ram is going to school';
String[] arrayOfString = s.split(' ');
String firstName =	arrayOfString[0];
for(integer i=0;i<arrayOfString.size();i++){
    firstName = arrayOfString[i];
    system.debug('test'+firstName);
}

system.debug('testfirst '+firstName);
system.debug('testLast'+LastName);

         */
        
        Contact con =new Contact();
        
        con = [select id,LastName,FirstName from Contact where id=:conId];
        
        Dom.Document doc = new Dom.Document();
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartDocument(null, '1.0');
        w.writeStartElement(null, 'cont', null);
        
        w.writeStartElement(null, 'Id', null);
        w.writeCharacters(con.id);
        w.writeEndElement();
        
        w.writeStartElement(null, 'LastName', null);
        w.writeCharacters(con.LastName);
        w.writeStartElement(null, 'FirstName', null);
        w.writeCharacters(con.FirstName);
        w.writeEndElement();

        w.writeEndDocument();
        
        string xmlOutput = w.getXmlString();
        system.debug('XML is xmlOutput  '+xmlOutput );
        w.close();
        
        doc.Load(xmlOutput);
        
        string xmldata = doc.toXmlString();
        system.debug('XML is '+xmldata);
        Blob  csvBlob;
        try{
            csvBlob  = Blob.valueOf(xmldata);  
        }catch(exception e){
            
            csvBlob  = Blob.valueOf('Some Text');
        }
        
            Attachment attachment = new Attachment();
            attachment.Body = csvBlob ;
            attachment.Name = 'conardfile.xml';
            attachment.ParentId = Con.id;
            insert attachment;
            Update con; 
            return 'XML: '+xmldata;
     }
}