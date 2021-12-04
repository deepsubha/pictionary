({
	locationchange : function(component, event, helper) {
		var t=event.getParam("token");
		//var token="0032w000002zpozAAA";
        console.log(t);
        if(t==undefined){
           t="contact/"; 
        }
        if(t.indexOf('contact/') === 0){
            var contactId = t.substring(t.indexOf('/')+1);
            //var contactId="0032w000003KjFbAAK";
            console.log(contactId);
            var action=component.get("c.searchbyid");
            action.setParams({"contactId":contactId});
            action.setCallback(this,function(a){
                component.set("v.contact",a.getReturnValue());
                console.log(a.getReturnValue());
            });
            $A.enqueueAction(action);
        }
	}
})