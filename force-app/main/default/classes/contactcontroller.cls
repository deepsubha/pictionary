public class contactcontroller {
    
    @AuraEnabled
    public static list<Contact> searchcontacts(){
        return [Select Id, Name, Phone from contact limit 20];
    }
    
    @AuraEnabled
    public static list<Contact> searchByQuerry(string searchQuerry){
        string name='%'+searchQuerry+'%';
        return [Select Id, Name, Phone from Contact where Name LIKE:name limit 20];
    }
    
    @AuraEnabled
    public static contact searchbyid(string contactId){
        contact c=[select Id,name,phone,mobilephone,title,Account.Name from Contact where Id=:contactId ];
        return c;
    }
}