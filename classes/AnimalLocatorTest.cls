@isTest
private class AnimalLocatorTest{
    @isTest static void AnimalLocatorMock1() {
        system.Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string result = AnimalLocator.getAnimalNameById(3);
        String expectedResult = 'chicken';
      	System.assertEquals(result,expectedResult );
    }
}