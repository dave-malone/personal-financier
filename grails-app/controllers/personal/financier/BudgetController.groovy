package personal.financier

import org.apache.commons.lang.StringUtils

class BudgetController {

    def index() {
		Date now = new Date()
		
		Integer selectedYear = params.int('year') ?: now.format("yyyy").toInteger()
		String selectedMonth = StringUtils.trimToNull(params.month)
		
		String prevYear = null
		String prevMonth = null
		
		String nextYear = null
		String nextMonth = null
		
		def months = []
		
		if(selectedMonth != null){
			//view only the selected month and year
			months.add selectedMonth	
			
			Date date = Date.parse("MMM-dd-yyyy", "$selectedMonth-01-$selectedYear")
			Calendar calendar = Calendar.getInstance()
			calendar.setTime(date)
			
			calendar.add(Calendar.MONTH, 1)
			
			nextYear = calendar.get(Calendar.YEAR)
			nextMonth = calendar.getTime().format("MMM")
			
			calendar.add(Calendar.MONTH, -2)
			
			prevYear = calendar.get(Calendar.YEAR)
			prevMonth = calendar.getTime().format("MMM")
		}else{
			//assume that we want to view all of the pay periods for the entire year
			Date date = Date.parse("MM-dd-yyyy", "01-01-$selectedYear")
			Calendar calendar = Calendar.getInstance()
			calendar.setTime(date)
			for(; calendar.getAt(Calendar.YEAR) == selectedYear; calendar.add(Calendar.MONTH, 1)){
				months.add calendar.getTime().format("MMM")
			}
		}
		
		def biWeeklyIncomes = Income.findAllWhere(incomeFrequency:Income.IncomeFrequency.BI_WEEKLY)
		def perpaycheckExpenses = Expense.findAllWhere(expenseType:Expense.ExpenseType.PER_PAYCHECK, active:true)
		
		def payPeriods = []
		months.each{ month ->
			biWeeklyIncomes.each{ biWeeklyIncome ->
				biWeeklyIncome.getPayDatesInMonth(selectedYear, month).each{ payDate ->
					def payPeriodCommand = new PayPeriodCommand(payDate:payDate, totalIncome:biWeeklyIncome.amount)
					def payperiodExpenses = Expense.findAllByExpenseTypeAndDueDateInList(Expense.ExpenseType.MONTHLY, payPeriodCommand.getDaysInPayPeriod())
					def oneTimeExpenses = Expense.findAllByExpenseTypeAndStartInList(Expense.ExpenseType.ONE_TIME, payPeriodCommand.getDatesInPayPeriod())
					payPeriodCommand.addExpenses(payperiodExpenses)
					payPeriodCommand.addExpenses(perpaycheckExpenses)
					payPeriodCommand.addExpenses(oneTimeExpenses)
					
					payPeriods.add(payPeriodCommand)
				}
			}
		}
		
		[payPeriods:payPeriods, nextYear:nextYear, nextMonth:nextMonth, prevYear:prevYear, prevMonth:prevMonth, year:selectedYear]
	}
}

class PayPeriodCommand{
	
	Date payDate
	BigDecimal totalIncome
	def expenses = []
	
	def BigDecimal getTotalExpenses(){
		BigDecimal total = new BigDecimal(0.0)
		
		expenses.each{ 
			total = total.add(it.amount)
		}
		
		return total
	}
	
	def addExpenses(def expenses){
		expenses.each{ expense ->
			if(expense.active != true){
				//don't add the expense to the list if it's not active
			}else if(expense.expenseType  in [Expense.ExpenseType.PER_PAYCHECK, Expense.ExpenseType.ONE_TIME]){
				this.expenses.add(expense)
			}else if(expense.expenseType == Expense.ExpenseType.MONTHLY){
				Date dueDate = getDateWithinPayPeriod(expense.dueDate)
			
				if(expense.start == null && expense.end == null){
					this.expenses.add(expense)	
				}else if((expense.start != null && expense.end == null) && dueDate.after(expense.start)){
					this.expenses.add(expense)
				}else if(expense.end != null && dueDate.before(expense.end)){
					//if end date is set
					//1. check to ensure that the dueDate that comes within this pay period is still before the expense end date
					//2. if it is 
					this.expenses.add(expense)
				}
			}
		}
		
		this.expenses.sort{ a, b ->
			if(a.dueDate == null || b.dueDate == null){
				return -1
			}
			
			this.getDateWithinPayPeriod(a.dueDate) <=> this.getDateWithinPayPeriod(b.dueDate)
		}
		
	}
	
	def isDateWithinPayPeriod(Date date){
		return date.after(this.payDate) && date.before(this.getLastDateInPayPeriod())
	}
	
	def getRemainderAfterExpenses(){
		return totalIncome.subtract(getTotalExpenses())
	}
	
	def getLastDateInPayPeriod(){
		return payDate + 13
	}
	
	def getDatesInPayPeriod(){
		def dates = []
		
		for(i in 0..13){
			Date date = payDate + i
			dates.add date
		}
		
		return dates
	}
	
	def getDaysInPayPeriod(){
		def days = []
		
		getDatesInPayPeriod().each{ date ->
			days.add date.getAt(Calendar.DATE)
		}
		
		return days
	}
	
	def getDateWithinPayPeriod(int day){
		if(getDaysInPayPeriod().contains(day) != true){
			return null
		}
		
		for(i in 0..13){
			Date date = payDate + i
			if(date.getAt(Calendar.DATE) == day){
				return date
			}
		}
		
		return null
	}
	
}
