public with sharing class AccountController {
    public AccountController() {}

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccount(String searchKey){
        String key='%'+searchKey+'%';
        List<Account> allAccounts=[select Id,Name,AccountNumber from Account where Name Like:key limit 10];
        return allAccounts;
    }
}