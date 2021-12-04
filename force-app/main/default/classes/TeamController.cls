public with sharing class TeamController {
    public TeamController() {}
    @AuraEnabled(cacheable=true)
    public static List<IPL_Team__c> getAllTeamsInfo(){
        List<IPL_Team__c> allTeamsInfo = [select Id,Name,Name_Of_The_Team__c,Captain__c,Captain_Notes__c,Commentators__c,
                                                 Comments__c from IPL_Team__c];
        return allTeamsInfo;
    }

    @AuraEnabled
    public static void updateNotes(String updatedNotes){
        String newNote = String.valueOf(updatedNotes);
        
        List<IPL_Team__c> allTeamsInfo = [select Id,Commentators__c,
        Comments__c from IPL_Team__c];
        for(IPL_Team__c team:allTeamsInfo){
            team.Comments__c = newNote;
        }
        try{
            update allTeamsInfo;
        }catch(Exception ex){
            System.debug(ex.getMessage());
        }
    }
}