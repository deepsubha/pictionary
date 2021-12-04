({
    getValueFromLwc : function(component, event, helper) {
        component.set("v.inputValue",event.getParam('CloseDateValue'));
        component.set("v.isCloseDate",event.getParam('isCard'));
        var cdv = event.getParam('CloseDateValue');
        component.set("v.titleLine",'All the Opportunities Closing on: '+cdv); 
        console.log('Close date value:::::'+cdv);
        component.set('v.columns', [
            {label: 'Opportunity name', fieldName: 'Name', type: 'text'},
            {label: 'Account name', fieldName: 'AccountName', type: 'text'},
            {label: 'Close date', fieldName: 'CloseDate', type: 'date'},
            {label: 'Amount', fieldName: 'Amount', type: 'currency', typeAttributes: { currencyCode: '', maximumSignificantDigits: 5}},
            {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'Integration',type: 'button',typeAttributes: {
                label: 'Confirm',
                name: 'Confirm',
                title: 'Confirm',
                disabled: false,
                value: 'confirm',
                iconPosition: 'center',
                disabled: {fieldName: 'confirm_button'}      
            }}
        ]);

        var action = component.get("c.findByCloseDate");
        action.setParams({
            "closeDateValue": cdv
        });
        action.setCallback(this, function(res) {
            var result = res.getReturnValue();
            if(result.length == 0){
                component.set("v.isCloseDate",false);
                component.set("v.Opportunities", null);
            }else{ 
                for(var s=0; s<result.length; s++){
                    result[s].AccountName = result[s].Account.Name;
                    //result[s].confirm_button = true;
                }
                component.set("v.Opportunities", result);
                component.set("v.isAllSent",false);
            }
        });
        $A.enqueueAction(action);
    },
    handleRowActions : function(component, event, helper) {
        var recId = event.getParam('row').Id;
        console.log('rec id^^^^'+recId);
        var actionName = event.getParam('action').name;
        var action = component.get("c.appendRecord");
        action.setParams({
            "OppId": recId
        });
        action.setCallback(this, function(res) { 
            var results = res.getReturnValue();
            //alert(result);           need to toat event
            if(results == 'success'){
                var result = component.get("v.Opportunities");
                for(var s=0; s<result.length; s++){
                    console.log(result.length);
                    console.log(result[s].Id+' : '+recId);
                    if(result[s].Id == recId){  
                        result[s].confirm_button = true;
                    }
                }

                var ac = component.get("c.updateOpp");
                ac.setParams({
                    "opId": recId
                });
                ac.setCallback(this, function(res) { 
                    var resu = res.getReturnValue();
                    // if(resu == 'success'){
                    //     alert('scs');
                    // }else{
                    //     alert('fail');
                    // }
                });
                $A.enqueueAction(ac);
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Success',
                message: 'Sent to Third Party!!',
                duration:' 3000',
                key: 'info_alt',
                type: 'success',
                mode: 'pester'
                });
                toastEvent.fire();

            }else{
                var result = component.get("v.Opportunities");
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:'Failed to Send Tird Party!!',
                    messageTemplate: 'Mode is pester ,duration is 4sec and Message is overrriden',
                    duration:' 3000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();

            }
            component.set("v.Opportunities", result);
        });
        $A.enqueueAction(action);
    },
    sendAllOpportunities : function(component, event, helper) {
        var allOpps = component.get("v.Opportunities");
        console.log(allOpps);
        console.log('lengt :'+allOpps.length);
        var ids = new Array();
        for(var i=0;i<allOpps.length;i++){
            ids.push(allOpps[i].Id);
        }
        var idList = JSON.stringify(ids);
        console.log(idList);
        var action = component.get("c.appendRecords");
        action.setParams({
            "OppIds": idList
        });
        action.setCallback(this, function(res) {
            var results = res.getReturnValue();
            console.log(results);
            if(results == 'success'){
                component.set("v.isAllSent",true);
                for(var i=0;i<allOpps.length;i++){
                    allOpps[i].confirm_button = true;
                }
                component.set("v.Opportunities",allOpps);

                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                title : 'Success',
                message: 'Sent to Third Party!!',
                duration:' 3000',
                key: 'info_alt',
                type: 'success',
                mode: 'pester'
                });
                toastEvent.fire();

            }else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message:'Failed to Send Tird Party!!',
                    messageTemplate: 'Mode is pester ,duration is 4sec and Message is overrriden',
                    duration:' 3000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
    
})