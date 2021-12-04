({
	doInit : function(component, event) {
		var act=component.get("c.searchcontacts");   
        act.setCallback(this,function(a){
                        component.set("v.contacts",a.getReturnValue())
        });
    	$A.enqueueAction(act);
    
    
    
    
	}
})