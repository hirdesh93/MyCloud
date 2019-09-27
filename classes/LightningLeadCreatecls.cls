public class LightningLeadCreatecls {
   @auraenabled
    public static Id creatLeadRecord(Lead leadObj){
        upsert leadObj;
        return leadObj.id;
    }
}