
<%@ page import="io.dmalone.personalfinancier.Expense" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'expense.label', default: 'Expense')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-expense" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-expense" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list expense">
			
				<g:if test="${expenseInstance?.expenseType}">
				<li class="fieldcontain">
					<span id="expenseType-label" class="property-label"><g:message code="expense.expenseType.label" default="Type" /></span>
					<span class="property-value" aria-labelledby="expenseType-label"><g:fieldValue bean="${expenseInstance}" field="expenseType"/></span>
				</li>
				</g:if>
			
				<g:if test="${expenseInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="expense.name.label" default="Name" /></span>
					<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${expenseInstance}" field="name"/></span>
				</li>
				</g:if>
				
				<g:if test="${expenseInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="expense.active.label" default="Active" /></span>
					<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${expenseInstance}" field="active"/></span>
				</li>
				</g:if>
			
				<g:if test="${expenseInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="expense.amount.label" default="Amount" /></span>
					<span class="property-value" aria-labelledby="amount-label"><g:formatNumber number="${expenseInstance.amount}" type="currency" currencyCode="USD" /></span>
				</li>
				</g:if>
			
				<g:if test="${expenseInstance?.dueDate}">
				<li class="fieldcontain">
					<span id="dueDate-label" class="property-label"><g:message code="expense.dueDate.label" default="Due Date" /></span>
					<span class="property-value" aria-labelledby="dueDate-label"><g:fieldValue bean="${expenseInstance}" field="dueDate"/></span>
				</li>
				</g:if>
				
				<g:if test="${expenseInstance?.start}">
				<li class="fieldcontain">
					<span id="start-label" class="property-label"><g:message code="expense.start.label" default="Start Date" /></span>
					<span class="property-value" aria-labelledby="start-label">
						<g:formatDate date="${expenseInstance.start}" format="MMM d, yyyy"/>
					</span>
				</li>
				</g:if>
				
				<g:if test="${expenseInstance?.end}">
				<li class="fieldcontain">
					<span id="end-label" class="property-label"><g:message code="expense.end.label" default="End Date" /></span>
					<span class="property-value" aria-labelledby="end-label">
						<g:formatDate date="${expenseInstance.end}" format="MMM d, yyyy"/>
					</span>
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:expenseInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${expenseInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
