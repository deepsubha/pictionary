({
	handledEvent : function(component, event, helper) {
		var message = event.getParams("family_update_event");
        console.log("message is==>"+JSON.stringify(message));
        component.set("v.family_update_message",message.family_update);
        component.set("v.onDate",message.DaTe);
	}
})