public with sharing class testOpenWeather {
public String city{set;get;}
public String temp{set;get;}
public String pressure{set;get;}
public String humidity{set;get;}
public String temp_min{set;get;}
public String temp_max{set;get;}

    public testOpenWeather(ApexPages.StandardController stdController) {
        Account account=(Account)stdController.getRecord();
        account=[select Id,ShippingCity from Account where Id=:account.id];
        
        String accountCity=account.ShippingCity;
        String apiKey = 'ac9baa5451c551ebca0482bfcaffabee';
        
        String requestEndPoint='https://api.openweathermap.org/data/2.5/weather';
        requestEndPoint+='?q='+accountCity;
        requestEndPoint+='&units=metric';
        requestEndPoint+='&APPID='+apiKey;
        
        Http http = new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response=http.send(request);
        
        if(response.getStatusCode() == 200){
            Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            city = String.valueOf(result.get('name'));
            Map<String,Object> mainResult = (Map<String,Object>) result.get('main');
            temp = String.valueOf(mainResult.get('temp'));
            pressure = String.valueOf(mainResult.get('pressure'));
            humidity= String.valueOf(mainResult.get('humidity'));
            temp_min = String.valueOf(mainResult.get('temp_min'));
            temp_max = String.valueOf(mainResult.get('temp_max'));
         }else{
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There is an error extracting data');
             ApexPages.addMessage(myMsg);
         }
        
    }

}