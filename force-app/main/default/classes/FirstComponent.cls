public with sharing class FirstComponent {
    //public FirstComponent() {}

    @AuraEnabled(cacheable=true)
    public static string foobar(){
        return 'am in js file';
    }
}