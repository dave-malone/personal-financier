<%@ page import="personal.financier.Expense" %>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'expenseType', 'error')} required">
	<label for="expenseType">
		<g:message code="expense.expenseType.label" default="Expense Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="expenseType" from="${personal.financier.Expense$ExpenseType?.values()}" keys="${personal.financier.Expense$ExpenseType.values()*.name()}" required="" value="${expenseInstance?.expenseType?.name()}" />
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="expense.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${expenseInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="expense.active.label" default="Active" />
	</label>
	<g:checkBox name="active" value="${expenseInstance.active}" />
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="expense.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}" required=""/>
</div>

<hr style="margin-top:1em"/>

<h3>For use only with Per Paycheck Expenses</h3>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'dueDate', 'error')} ">
	<label for="dueDate">
		<g:message code="expense.dueDate.label" default="Due Date" />
	</label>
	<g:field name="dueDate" type="number" value="${expenseInstance.dueDate}"/>
</div>

<hr style="margin-top:1em"/>

<h3>For use only with Monthly &amp; One Time Expenses</h3>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'start', 'error')} ">
	<label for="start">
		<g:message code="expense.start.label" default="Start Date" />
	</label>
	<g:datePicker name="start" precision="day"  value="${expenseInstance.start}" default="none" noSelection="['':'']" />
</div>

<div class="fieldcontain ${hasErrors(bean: expenseInstance, field: 'end', 'error')} ">
	<label for="end">
		<g:message code="expense.end.label" default="End Date" />
	</label>
	<g:datePicker name="end" precision="day"  value="${expenseInstance.end}" default="none" noSelection="['':'']" />
</div>

