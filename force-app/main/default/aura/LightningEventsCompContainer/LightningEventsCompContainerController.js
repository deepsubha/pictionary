({
	handleTotalIncomeComponentEvent : function(component, event, helper) {
		alert('event handler at the parent component');
        var totalIncome=event.getParam('totalIncome');
        component.set('v.totalIncome',totalIncome);
	}
})