@isTest
public class Integration_UnitTest 
{
   @isTest
    public static void testPostCall()
    {   
        
         //Account acc= new Account(Name='Test account');
         //insert acc;
         //Opportunity opp=new Opportunity(Name='Testing Opportuntiy',AccountId=acc.Id,StageName='Closed Won',Type='New Customer',Amount=2500,CloseDate=System.today());        
         //insert opp;
        
        Test.setMock(HttpCalloutMock.class,new ThirdPartyPostCallOutMock());
         //creating object
        //thirdParty tp=new thirdParty(new ApexPages.StandardController(opp));
        
        Test.startTest();
        HttpResponse response=thirdParty.makePostCall('{"Opprtunity Name":"Rupsa"}');
        
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        //String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        //System.assertEquals(actualValue, expectedValue);
        System.assertEquals(201, response.getStatusCode());
        Test.stopTest();

        
    }
    
    
}