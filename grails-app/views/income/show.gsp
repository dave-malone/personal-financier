
<%@ page import="io.dmalone.personalfinancier.Income" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'income.label', default: 'Income')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-income" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-income" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list income">
			
				<g:if test="${incomeInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="income.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${incomeInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${incomeInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="income.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:formatNumber number="${incomeInstance.amount}" type="currency" currencyCode="USD" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${incomeInstance?.incomeFrequency}">
				<li class="fieldcontain">
					<span id="incomeFrequency-label" class="property-label"><g:message code="income.incomeFrequency.label" default="Frequency" /></span>
					
						<span class="property-value" aria-labelledby="incomeFrequency-label"><g:fieldValue bean="${incomeInstance}" field="incomeFrequency"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${incomeInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="income.date.label" default="Date" /></span>
					<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${incomeInstance.date}" format="MMM d, yyyy"/></span>
				</li>
				</g:if>
				
				<g:if test="${incomeInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="income.startDate.label" default="Date" /></span>
					<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${incomeInstance.startDate}" format="MMM d, yyyy"/></span>
				</li>
				</g:if>
				
				<g:if test="${incomeInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="income.endDate.label" default="Date" /></span>
					<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${incomeInstance.endDate}" format="MMM d, yyyy"/></span>
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:incomeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${incomeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
