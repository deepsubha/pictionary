import { LightningElement, wire, api } from 'lwc';
//import getOpportunities from '@salesforce/apex/OpportunityChartController.getOpportunities';
import getOpportunitiesInfo from '@salesforce/apex/OpportunityChartController.getOpportunitiesInfo';
 
export default class OpportunityChart extends LightningElement {
    @api filterData;
    @api type;
    chartConfiguration;
 
    @wire(getOpportunitiesInfo, { filterData: '$filterData'})
    getOpportunitiesInfo({ error, data }) {
        if (error) {
            this.error = error;
            this.chartConfiguration = undefined;
        } else if (data) {
            let chartAmtData = [];
            let chartRevData = [];
            let chartLabel = [];
            data.forEach(opp => {
                chartAmtData.push(opp.Amount);
                chartRevData.push(opp.ExpectedRevenue);
                chartLabel.push(opp.Name);
            });
 
            this.chartConfiguration = {
                type: this.type,
                data: {
                    datasets: [{
                            label: 'Amount',
                            backgroundColor: "green",
                            data: chartAmtData,
                        },
                        {
                            label: 'Expected Revenue',
                            backgroundColor: "blue",
                            data: chartRevData,
                        },
                    ],
                    labels: chartLabel,
                },
                options: {},
            };
            console.log('data => ', data);
            this.error = undefined;
        }
    }
}