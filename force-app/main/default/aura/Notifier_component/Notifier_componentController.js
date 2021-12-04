({
	updating : function(component, event, helper) {
		var applicationEvent = $A.get("e.c:Family_Event");
        //var applicationEvent = component.getEvent("family_update_event");
        applicationEvent.setParams({
            "family_update" : "I am graduated on 2020!",
            "DaTe" : new Date().toLocaleDateString()
        });
        applicationEvent.fire();
	}
})