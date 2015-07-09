<%@ page import="io.dmalone.personalfinancier.Income" %>



<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="income.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${incomeInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="income.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: incomeInstance, field: 'amount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'incomeFrequency', 'error')} required">
	<label for="incomeFrequency">
		<g:message code="income.incomeFrequency.label" default="Income Frequency" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="incomeFrequency" from="${io.dmalone.personalfinancier.Income$IncomeFrequency?.values()}" keys="${io.dmalone.personalfinancier.Income$IncomeFrequency.values()*.name()}" required="" value="${incomeInstance?.incomeFrequency?.name()}" />

</div>

<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="income.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${incomeInstance?.date}" default="none" noSelection="['':'']" />

</div>

<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="income.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${incomeInstance?.startDate}" default="none" noSelection="['':'']" />

</div>

<div class="fieldcontain ${hasErrors(bean: incomeInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="income.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day" value="${incomeInstance?.endDate}" default="none" noSelection="['':'']" />

</div>

