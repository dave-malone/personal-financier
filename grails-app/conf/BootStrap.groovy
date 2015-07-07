import personal.financier.Expense
import personal.financier.Income

class BootStrap {

    def init = { servletContext ->
		if(Expense.count() == 0){
			InputStream monthlyExpensesFile = getClass().classLoader.getResourceAsStream("monthly-expenses.csv")
			String[] monthlyExpensesLines = monthlyExpensesFile.text.split('\n')
			List<String[]> monthlyExpensesRows = monthlyExpensesLines.collect {it.split(',')}
			
			monthlyExpensesRows.each{ row ->
				def expense = new Expense(expenseType:Expense.ExpenseType.MONTHLY, name:row[0], dueDate:row[1], amount:new BigDecimal(row[2]))
				
				if(!expense.save()){
					log.error "Failed to save monthly expense ${row[0]}: $expense.errors"
				}
			}
		
		
			InputStream perpaycheckExpensesFile = getClass().classLoader.getResourceAsStream("perpaycheck-expenses.csv")
			String[] perpaycheckExpensesLines = perpaycheckExpensesFile.text.split('\n')
			List<String[]> perpaycheckExpensesRows = perpaycheckExpensesLines.collect {it.split(',')}
			
			perpaycheckExpensesRows.each{ row ->
				def expense = new Expense(expenseType:Expense.ExpenseType.PER_PAYCHECK, name:row[0], amount:new BigDecimal(row[1]))
				
				if(!expense.save()){
					log.error "Failed to save per paycheck expense ${row[0]}: $expense.errors"
				}
			}
		
			def income = new Income(incomeFrequency: Income.IncomeFrequency.BI_WEEKLY, name:'Paycheck', amount:new BigDecimal('3592.51'), startDate:Date.parse("MM-dd-yyyy", "02-06-2015"))
			
			if(!income.save()){
				log.error "Failed to save income $income.name: $income.errors"
			}
		}
		
    }
    def destroy = {
    }
}
