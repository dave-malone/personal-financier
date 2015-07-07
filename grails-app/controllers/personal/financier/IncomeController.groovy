package personal.financier



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class IncomeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Income.list(params), model:[incomeInstanceCount: Income.count()]
    }

    def show(Income incomeInstance) {
        respond incomeInstance
    }

    def create() {
        respond new Income(params)
    }

    @Transactional
    def save(Income incomeInstance) {
        if (incomeInstance == null) {
            notFound()
            return
        }

        if (incomeInstance.hasErrors()) {
            respond incomeInstance.errors, view:'create'
            return
        }

        incomeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'income.label', default: 'Income'), incomeInstance.id])
                redirect incomeInstance
            }
            '*' { respond incomeInstance, [status: CREATED] }
        }
    }

    def edit(Income incomeInstance) {
        respond incomeInstance
    }

    @Transactional
    def update(Income incomeInstance) {
        if (incomeInstance == null) {
            notFound()
            return
        }

        if (incomeInstance.hasErrors()) {
            respond incomeInstance.errors, view:'edit'
            return
        }

        incomeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Income.label', default: 'Income'), incomeInstance.id])
                redirect incomeInstance
            }
            '*'{ respond incomeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Income incomeInstance) {

        if (incomeInstance == null) {
            notFound()
            return
        }

        incomeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Income.label', default: 'Income'), incomeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'income.label', default: 'Income'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
