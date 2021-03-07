<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/common/header.jsp"%>
</head>
<body>
    <div class="container">
        <form method="post"> <%-- action="${pageContext.request.contextPath}/el" --%>
            <table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <td colspan="3"><h4><spring:message code="label.member.join.id" /></h4></td>
                        <td><input type="form-control" type="text" name=""></td>
                    </tr>
                </thead>

            </table>

        </form>
    </div>
</body>
</html>
