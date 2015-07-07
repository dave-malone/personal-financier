package personal.financier



import grails.test.mixin.*
import spock.lang.*

@TestFor(IncomeController)
@Mock(Income)
class IncomeControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.incomeInstanceList
            model.incomeInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.incomeInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def income = new Income()
            income.validate()
            controller.save(income)

        then:"The create view is rendered again with the correct model"
            model.incomeInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            income = new Income(params)

            controller.save(income)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/income/show/1'
            controller.flash.message != null
            Income.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def income = new Income(params)
            controller.show(income)

        then:"A model is populated containing the domain instance"
            model.incomeInstance == income
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def income = new Income(params)
            controller.edit(income)

        then:"A model is populated containing the domain instance"
            model.incomeInstance == income
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/income/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def income = new Income()
            income.validate()
            controller.update(income)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.incomeInstance == income

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            income = new Income(params).save(flush: true)
            controller.update(income)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/income/show/$income.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/income/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def income = new Income(params).save(flush: true)

        then:"It exists"
            Income.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(income)

        then:"The instance is deleted"
            Income.count() == 0
            response.redirectedUrl == '/income/index'
            flash.message != null
    }
}
