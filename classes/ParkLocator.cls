public class ParkLocator {
    public static string[] country(String country) {
        ParkService.ParksImplPort  parkSvc = new  ParkService.ParksImplPort();
       // parkService.parksImplPort park = new parkService.parksImplPort();
        return parkSvc.byCountry(country);
    }
}