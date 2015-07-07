package personal.financier



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ExpenseController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
		[expenses:Expense.list()]
    }

    def show(Expense expenseInstance) {
        respond expenseInstance
    }

    def create() {
        respond new Expense(params)
    }

    @Transactional
    def save(Expense expenseInstance) {
        if (expenseInstance == null) {
            notFound()
            return
        }

        if (expenseInstance.hasErrors()) {
            respond expenseInstance.errors, view:'create'
            return
        }

        expenseInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'expense.label', default: 'Expense'), expenseInstance.id])
                redirect expenseInstance
            }
            '*' { respond expenseInstance, [status: CREATED] }
        }
    }

    def edit(Expense expenseInstance) {
        respond expenseInstance
    }

    @Transactional
    def update(Expense expenseInstance) {
        if (expenseInstance == null) {
            notFound()
            return
        }

        if (expenseInstance.hasErrors()) {
            respond expenseInstance.errors, view:'edit'
            return
        }

        expenseInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Expense.label', default: 'Expense'), expenseInstance.id])
                redirect expenseInstance
            }
            '*'{ respond expenseInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Expense expenseInstance) {

        if (expenseInstance == null) {
            notFound()
            return
        }

        expenseInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Expense.label', default: 'Expense'), expenseInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'expense.label', default: 'Expense'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
