/*
Created By: Subhadeep Maiti || 17-Nov-2021
This is base class for Integrating Jira with Salesforce using Basic Auth protocol
*/
public with sharing class JiraHostController {
    public JiraHostController() {

    }

    @AuraEnabled(cacheable = true)
    public static string getSingleIssue(String key){
        try {
            String baseUrl = 'https://salesforcepractice.atlassian.net/rest/agile/1.0/issue/'+key;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(baseUrl);
            req.setMethod('GET');

            String jiraId = 'maitisubha22@gmail.com';
            String apiToken = 'mV5isBBMXKztW1w1Dzo7ADC0';
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
