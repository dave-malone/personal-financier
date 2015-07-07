package personal.financier

import org.junit.Before;


class Income {

	enum IncomeFrequency {
		ONE_TIME("One Time"), BI_WEEKLY("Bi-Weekly")
		
		private final String name
		
		private IncomeFrequency(String name){
			this.name = name
		}
		
		public String toString(){
			return this.name
		}
	}
	
	String name
	IncomeFrequency incomeFrequency
	BigDecimal amount
	Date date
	Date startDate
	Date endDate
	
    static constraints = {
		name blank:false
		date nullable:true
		startDate nullable:true
		endDate nullable:true
    }
	
	def getPayDatesInMonth(int year, String month){
		def payDates = []
		
		Date firstOfTheMonth = Date.parse("MMM-dd-yyyy", "$month-01-$year")
		
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(firstOfTheMonth)
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
		calendar.set(Calendar.HOUR, calendar.getActualMaximum(Calendar.HOUR))
		calendar.set(Calendar.MINUTE, calendar.getActualMaximum(Calendar.MINUTE))
		calendar.set(Calendar.SECOND, calendar.getActualMaximum(Calendar.SECOND))
		calendar.set(Calendar.MILLISECOND, calendar.getActualMaximum(Calendar.MILLISECOND))
		
		Date lastOfTheMonth = calendar.getTime()
		
		if(incomeFrequency == IncomeFrequency.ONE_TIME && (date.after(firstOfTheMonth) && date.before(lastOfTheMonth))){
			payDates << date
		}else if(incomeFrequency == IncomeFrequency.BI_WEEKLY){
			for(Date payDate = startDate; payDate.before(lastOfTheMonth); payDate += 14){
				if(payDate.compareTo(firstOfTheMonth) >= 0){
					payDates << payDate
				}	
			}
		}
		
		return payDates
	}
}
