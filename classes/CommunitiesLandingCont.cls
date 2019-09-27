public with sharing class CommunitiesLandingCont {

  // Code we will invoke on page load.

   public PageReference forwardToStartPage() {

   return Network.communitiesLanding();

   }

    public CommunitiesLandingCont() {}

   public PageReference RedirectToLandingPage()  

   {

   return  new PageReference('/apex/NeedSupport');

   }

   }