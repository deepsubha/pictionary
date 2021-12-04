public class thirdParty 
{
    //public String JsonStr;                           //uncomment these 2 lines
    //public Id recordId  {get;set;}     

    

    public thirdParty(ApexPages.StandardController controller)
    {
        
    }
    
    public static void callOut() 
    {     
        //System.debug('###'+recordId);
        //JsonStr=getJsonStr(recordId);
        //System.debug('Record in Json'+JsonStr);       
        HttpResponse response=makePostCall('gowlidotir ...');                   //change it to JsonStr
        System.debug('ResponseCode'+response.getStatusCode());
        if(response.getStatusCode()==201)
        {
                             
            //Opportunity oppList=[SELECT Id,Integration_Status_c,Integration_Comments_c FROM Opportunity where Id=:recordId];
               // oppList.Integration_Status__c='Success';
               // oppList.Integration_Comments__c=response.getStatus();
              // update oppList;
        }
        else 
        {
            
                //Opportunity opp=[SELECT Id,Integration_Status_c,Integration_Comments_c FROM Opportunity where Id=:recordId];
                //opp.Integration_Status__c='Error';
                //opp.Integration_Comments__c=response.getStatus();
                //update opp;
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Error is sending Data to 3rd Party'));

        }
    }
    
    
    //copy paste your getJsonStr() method here
    
    
    
    public static HttpResponse makePostCall(String JsonStr)
    {
        Http http=new Http();        
        //2.Frame the request and send it
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        request.setBody(JsonStr);
        HttpResponse response = http.send(request);
        return(response);
        
    }

    
}