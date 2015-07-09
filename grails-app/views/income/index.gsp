
<%@ page import="io.dmalone.personalfinancier.Income" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'income.label', default: 'Income')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-income" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-income" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'income.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'income.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="incomeFrequency" title="${message(code: 'income.incomeFrequency.label', default: 'Frequency')}" />
					
						<g:sortableColumn property="startDate" title="${message(code: 'income.startDate.label', default: 'Start Date')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${incomeInstanceList}" status="i" var="incomeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${incomeInstance.id}">${fieldValue(bean: incomeInstance, field: "name")}</g:link></td>
					
						<td><g:formatNumber number="${incomeInstance.amount}" type="currency" currencyCode="USD" /></td>
					
						<td>${fieldValue(bean: incomeInstance, field: "incomeFrequency")}</td>
					
						<td><g:formatDate date="${incomeInstance.startDate}" format="MMM d, yyyy"/></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${incomeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
