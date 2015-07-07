
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Budget</title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" controller="expense" action="index">Manage Expenses</g:link></li>
				<li><g:link class="list" controller="income" action="index">Manage Income</g:link></li>
			</ul>
		</div>
		<div id="list-budget" class="content scaffold-list" role="main">
			<div style="float:left">
				<g:if test="${prevYear != null && prevMonth != null}">
					<g:link params="${[year:prevYear, month:prevMonth]}">${prevMonth} ${prevYear}</g:link>
				</g:if>
				
				<g:if test="${nextYear != null && nextMonth != null}">
					<g:link params="${[year:nextYear, month:nextMonth]}">${nextMonth} ${nextYear}</g:link>
				</g:if>
				
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
				
				<g:each in="${payPeriods}" var="payPeriod">
					<h2>Pay Period: <g:formatDate date="${payPeriod.payDate}" format="MMM d"/> - <g:formatDate date="${payPeriod.lastDateInPayPeriod}" format="MMM d"/></h2>
					
					<div style="margin:0.5em 0.3em">
						Pay Date: <g:formatDate date="${payPeriod.payDate}" format="MMMM d"/><br />
						Total Income: <g:formatNumber number="${payPeriod.totalIncome}" type="currency" currencyCode="USD"/><br />
						Total Expenses: <g:formatNumber number="${payPeriod.totalExpenses}" type="currency" currencyCode="USD"/>
						<hr style="width:200px"/>
						Remainder: <g:formatNumber number="${payPeriod.remainderAfterExpenses}" type="currency" currencyCode="USD"/>
					</div>
					
					<h3>Expenses</h3>
					<table>
					<thead>
							<tr>
								<g:sortableColumn property="type" title="${message(code: 'expense.type.label', default: 'Type')}" />
								<g:sortableColumn property="name" title="${message(code: 'expense.name.label', default: 'Name')}" />
								<g:sortableColumn property="amount" title="${message(code: 'expense.amount.label', default: 'Amount')}" />
								<g:sortableColumn property="dueDate" title="${message(code: 'expense.dueDate.label', default: 'Due Date')}" />
							</tr>
						</thead>
						<tbody>
						<g:each in="${payPeriod.expenses}" status="i" var="expenseInstance">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td>${fieldValue(bean: expenseInstance, field: "expenseType")}</td>
								<td><g:link controller="expense" action="show" id="${expenseInstance.id}">${fieldValue(bean: expenseInstance, field: "name")}</g:link></td>
								<td><g:formatNumber number="${expenseInstance.amount}" type="currency" currencyCode="USD" /></td>
								<td><g:if test="${expenseInstance.dueDate}"><g:formatDate date="${payPeriod.getDateWithinPayPeriod(expenseInstance.dueDate)}" format="MMMM d"/></g:if></td>
							</tr>
						</g:each>
						</tbody>
					</table>
				</g:each>
			</div>
			
			<div style="float:left; margin-left:2em;">
				<h2>Savings Projection</h2>
				<table>
					<tbody>
						<tr class="even"><td>Savings Bal. 2/24</td><td>$931.47</td></tr>
						<tr class="odd"><td>March 6</td><td>$700.00</td></tr>
						<tr class="even"><td>March 20</td><td>$2,000.00</td></tr>
						<tr class="odd"><td>Home Sale</td><td>$11,500.00</td></tr>
						<g:set var="projectedTotal" value="${15131.47}"/>
					<g:each in="${payPeriods}" status="i" var="payPeriod">
						<g:if test="${payPeriod.payDate.getAt(Calendar.MONTH) > 2 && payPeriod.payDate.getAt(Calendar.MONTH) < 9}">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td><g:formatDate date="${payPeriod.payDate}" format="MMMM d"/></td>
								<td><g:formatNumber number="${payPeriod.remainderAfterExpenses}" type="currency" currencyCode="USD"/></td>
							</tr>
							<g:set var="projectedTotal" value="${projectedTotal += payPeriod.remainderAfterExpenses}"/>
						</g:if>
					</g:each>
						<tr>
							<td>Total:</td><td><g:formatNumber number="${projectedTotal}" type="currency" currencyCode="USD"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</body>
</html>
