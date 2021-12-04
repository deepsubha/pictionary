/*
* Created By: Subhadeep Maiti || 17-Nov-2021
* This is base class for Integrating Jira with Salesforce using Basic Auth protocol
*/
public with sharing class JiraHostController {
    public JiraHostController() {

    }

    @AuraEnabled(cacheable = true)
    public static string getSingleIssue(String key){
        try {
            List<Authentication_Setting__c> creds = [select id, Secret_Type__c, isActive__c, Value__c
                                                     from Authentication_Setting__c 
                                                     where Name_of_the_Application__c='JIRA' limit 200];
            String api_token = '';
            String jira_id = '';
            for(Authentication_Setting__c cred: creds){
                if(cred.Secret_Type__c == 'Api token' && cred.isActive__c == true && (cred.Value__c != '' || cred.Value__c != null)) 
                    api_token = cred.Value__c;
                if(cred.Secret_Type__c == '	User name' && cred.isActive__c == true && (cred.Value__c!='' || cred.Value__c != null)) 
                    jira_id = cred.Value__c;
            }
            String baseUrl = 'https://salesforcepractice.atlassian.net/rest/agile/1.0/issue/'+key;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(baseUrl);
            req.setMethod('GET');
            
            if(jira_id == '' || api_token == '')
                throw new AuraHandledException('User name or api token missing!');

            String jiraId = jira_id;
            String apiToken = api_token;
            Blob headerValue = Blob.valueOf(jiraId + ':' +apiToken);
            String authHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authHeader);

            Http http = new Http();
            HttpResponse res = http.send(req);
            return res.getBody();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
