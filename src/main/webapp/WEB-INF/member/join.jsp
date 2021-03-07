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
                        <th colspan="3"><h4><spring:message code="label.member.join.title" /></h4></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 120px"><h5><spring:message code="label.member.join.id" /></h5></td>
                        <td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="<spring:message code="label.member.join.insertid" />"></td>
                        <td style="width: 110px;"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button"><spring:message code="label.member.join.checkid" /></button>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px"><h5><spring:message code="label.member.join.password" /></h5></td>
                        <td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword1" name="userPassword1" maxlength="20" placeholder="<spring:message code="label.member.join.insertpassword1" />"></td>
                    </tr>
                    <tr>
                        <td style="width: 120px"><h5><spring:message code="label.member.join.passwordcheck" /></h5></td>
                        <td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword2" name="userPassword2" maxlength="20" placeholder="<spring:message code="label.member.join.insertpassword2" />"></td>
                    </tr>
                    <tr>
                        <td style="width: 120px"><h5><spring:message code="label.member.join.username" /></h5></td>
                        <td colspan="2"><input class="form-control" type="text" id="userName" name="userName" maxlength="20" placeholder="<spring:message code="label.member.join.insertusername" />"></td>
                        </td>
                    </tr>
                </tbody>

            </table>

        </form>
    </div>
</body>
</html>
