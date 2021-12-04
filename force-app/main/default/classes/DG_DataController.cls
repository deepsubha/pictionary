public with sharing class DG_DataController {
    public DG_DataController() { }

    @AuraEnabled(cacheable=true)
    public static List<Word__c> getAllWords() {
        return [
            SELECT Id, Name, Name__c, CreatedById
            FROM Word__c
            LIMIT 35
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Participant__c> getAllParticipants() {
        return [
            SELECT Id, Participant_Name__c, Score__c
            FROM Participant__c
            LIMIT 35
        ];
    }

    @AuraEnabled
    public static Boolean newWordInsertion(String newWords) {
        List<Word__c> wordRecords = new List<Word__c>();
        List<String> finalWords = newWords.split(',');
        System.debug('getting string>>>>>'+finalWords+'size:::'+ finalWords.size());
        for(Integer i=0; i<finalWords.size(); i++){
            Word__c wd = new Word__c(Name__c = finalWords[i]);
            wordRecords.add(wd);
        }
        System.debug('final words'+ wordRecords);
        if(wordRecords.size() > 0){
            insert wordRecords;
            return true;
        }
        return false;
    }

}