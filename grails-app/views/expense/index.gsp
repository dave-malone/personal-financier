
<%@ page import="personal.financier.Expense" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'expense.label', default: 'Expense')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-expense" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-expense" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<h3>Monthly Expenses</h3>
			<table>
			<thead>
					<tr>
						<g:sortableColumn property="expenseType" title="${message(code: 'expense.expenseType.label', default: 'Type')}" />
						<g:sortableColumn property="name" title="${message(code: 'expense.name.label', default: 'Name')}" />
						<g:sortableColumn property="active" title="${message(code: 'expense.active.label', default: 'Active')}" />
						<g:sortableColumn property="amount" title="${message(code: 'expense.amount.label', default: 'Amount')}" />
						<g:sortableColumn property="dueDate" title="${message(code: 'expense.dueDate.label', default: 'Due Date')}" />
						<g:sortableColumn property="start" title="${message(code: 'expense.start.label', default: 'Start Date')}" />
						<g:sortableColumn property="end" title="${message(code: 'expense.end.label', default: 'End Date')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${expenses}" status="i" var="expenseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${fieldValue(bean: expenseInstance, field: "expenseType")}</td>
						<td><g:link action="show" id="${expenseInstance.id}">${fieldValue(bean: expenseInstance, field: "name")}</g:link></td>
						<td>${fieldValue(bean: expenseInstance, field: "active")}</td>
						<td><g:formatNumber number="${expenseInstance.amount}" type="currency" currencyCode="USD" /></td>
						<td>${fieldValue(bean: expenseInstance, field: "dueDate")}</td>
						<td><g:formatDate date="${expenseInstance.start}" format="MMM d, yyyy"/></td>
						<td><g:formatDate date="${expenseInstance.end}" format="MMM d, yyyy"/></td>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
