package personal.financier


class Expense {

	enum ExpenseType{
		MONTHLY("Monthly"), ONE_TIME("One Time"), PER_PAYCHECK("Per Paycheck") 
		
		private final String name
		
		private ExpenseType(String name){
			this.name = name
		}
		
		public String toString(){
			return this.name
		}
	}
	
	ExpenseType expenseType
	String name
	BigDecimal amount
	Integer dueDate
	boolean active = true
	Date start
	Date end
	
    static constraints = {
		name blank:false
		dueDate nullable:true, min:1, max:31
		start nullable:true
		end nullable:true
    }
	
	public String toString(){
		return "Expense[Type: $expenseType, Name: $name, Amount: $amount, Due Date: $dueDate]"
	}
}
