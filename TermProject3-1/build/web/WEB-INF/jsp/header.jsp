
<%@page import="org.json.*"%>
<%@page import="globalpkg.GlobalVariables"%>
<%
    GlobalVariables ob = GlobalVariables.getInstance();
    String usertype = ob.getUsertype();
    //System.out.println(usertype);
    JSONObject jo = ob.getMenuitems(usertype);
%>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">QuestionProtector</a>
        </div>
        <ul class="nav navbar-nav">

            <%
                JSONArray items = jo.getJSONArray("items");
                JSONArray links = jo.getJSONArray("subitems");
                JSONArray checks = jo.getJSONArray("checks");
                for (int i = 0; i < items.length(); i++) {
                    if (checks.getInt(i) == 0) {
            %>
            <li id="<%=ob.getItemtoid().get(items.getString(i))%>"><a href="<%=links.getString(i)%>"><%=items.getString(i)%></a></li>
                <%
                } else {
                %>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=items.getString(i)%>
                    <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <%
                        JSONObject jo1 = links.getJSONObject(i);
                        JSONArray items1 = jo1.getJSONArray("sitems");
                        JSONArray sublinks = jo1.getJSONArray("links");

                        for (int j = 0; j < items1.length(); j++) {
                    %>
                    <li><a href="<%=sublinks.getString(j)%>"><%=items1.getString(j)%></a></li>
                        <%
                            }
                        %>
                </ul>
            </li>

            <%
                    }
                }
            %>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="welcome.show"> Logout <span class="glyphicon glyphicon-log-out"></span></a></li>
        </ul>
    </div>
</nav>  
