({
    getWord : function(component) {
        var action = component.get("c.getAllWords");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //component.set("v.userList", response.getReturnValue());
                var allWords = response.getReturnValue();
                console.log('all the words::'+JSON.stringify(allWords)+': length:::'+allWords.length);
                console.log('exploring :::'+Math.floor(Math.random() * allWords.length));
                const index = Math.floor(Math.random() * allWords.length);
                console.log('-------'+JSON.stringify(allWords[index]));
                component.set("v.word", allWords[index].Name__c.toUpperCase());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    } ,
})