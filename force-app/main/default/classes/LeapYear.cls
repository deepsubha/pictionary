public class LeapYear{
    public LeapYear(){}                   //default constructor
    public LeapYear(Integer year){         //parameterised constructor
        system.debug('checking whether a year is leap year or not?');
        if(Math.mod(year,4) == 0){
            if(Math.mod(year,100) == 0){
                if(Math.mod(year,400) == 0){
                    system.debug(year +'is a leap year');
                }else{
                    system.debug(year +'is not a leap year');
                }
            }else{
                system.debug(year +'is a leap year');
            }
        }else{
            system.debug(year+'is not a leap year');
        }
    }
    
    public void findLeapYears(Integer startingYear){                    //for 10 years find all the leap years using do-while loop
        Integer endingYear = startingYear + 10;
        do{
            if(Math.mod(startingYear,4) == 0){
                if(Math.mod(startingYear,100) == 0){
                    if(Math.mod(startingYear,400) == 0)
                        system.debug(startingYear +' is a leap year');                
                }else
                    system.debug(startingYear +' is a leap year');
            }
            startingYear++;
        }while(startingYear!=endingYear);
    }
    
    
}