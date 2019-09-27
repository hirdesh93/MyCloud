public class comunityhirdeah {
    public ConnectApi.CommunityPage var1 {get;set;}
    public comunityhirdeah(){
        var1 = Connectapi.Communities.getCommunities();
    }
}