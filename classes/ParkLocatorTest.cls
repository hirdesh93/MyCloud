@isTest
public class ParkLocatorTest {
    @isTest  static void testCallout() {      
        // This causes a fake response to be generated
        System.Test.setMock(WebServiceMock.class, new ParkServiceMock()); 
        // Call the method that invokes a callout
  		//String country = 'Germany';
        ParkLocator.country('Germany');
      //  System.assertEquals(new List<String>{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'}, result); 
    }
}