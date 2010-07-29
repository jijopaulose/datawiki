<%@page import="wiki.Format"%>
<%
  final String formatName = (String) request.getAttribute("formatName");
  final Format format = (Format) request.getAttribute("format");
%>
<html>
  <head>
    <link href="/documents.css" rel="stylesheet" type="text/css"/>
    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script src="/HTTP.js" type="text/javascript"></script>
    <script src="/Util.js" type="text/javascript"></script>
    <script src="/StatsTable.js" type="text/javascript"></script>
    <script src="/Tabs.js" type="text/javascript"></script>
    <script src="/Translate.js" type="text/javascript"></script>
    <script src="/Viz.js" type="text/javascript"></script>
    <script src="/Documents.js" type="text/javascript"></script>
    <script type="text/javascript">
      // Needs to be called before page loaded.
      try {
        if (google != null) {
          google.load('visualization', '1', {'packages':['corechart','table','map']});
          vizFormat = '<%= formatName %>'; // required for vizInit;
          google.setOnLoadCallback(vizQuery);
        }
      } catch(e) {
//        alert('Cannot access internet.');
      }
    </script>
  </head>
  <body onload="Documents();translateInit('langSelect')">
    <jsp:include page="onebar.jsp"/>
    <jsp:include page="nav.jsp"/>
    <div class="mainPanel trans">
      <ul class="tabs">
        <li class="activeTab">Dataset</li>
        <li><a href="/wiki/formats/<%= formatName %>">Format</a></li>
      </ul>
      <div id="formatBox" class="box tabbed activeTabbed">
        <div id="formatPanelLeft">
<%
  String header = format.getTitle() == null ? format.getName().toUpperCase() : format.getTitle();
%>
          <h2 id="title"><%= header %></h2>
          <p><%= format.getDescription() %></p>
        </div>
        <div id="formatPanelRight">
          <ul id="formTabs" class="tabs">
            <li class="activeTab"><a>Find</a></li>
            <li><a>Create</a></li>
          </ul>
          <div id="tabbedForms">
            <jsp:include page="form.jsp">
              <jsp:param name="jspFormId" value="formFind"/>
              <jsp:param name="jspFormTitle" value="Find"/>
              <jsp:param name="jspFormMethod" value="GET"/>
              <jsp:param name="jspFormAction" value="<%= "/wiki/"+ format.getURLTitle() %>"/>
            </jsp:include>
            <jsp:include page="form.jsp">
              <jsp:param name="jspFormId" value="formCreate"/>
              <jsp:param name="jspFormTitle" value="Create"/>
              <jsp:param name="jspFormMethod" value="POST"/>
              <jsp:param name="jspFormAction" value="<%= "/wiki/"+ format.getURLTitle() %>"/>
              <jsp:param name="jspFormActive" value="false"/>
            </jsp:include>
          </div>
        </div>
        <div>&nbsp;</div>
      </div>
      <ul id="chartTabs" class="tabs">
        <li class="activeTab"><a>Documents</a></li>
        <li><a>Stats</a></li>
      </ul>
      <div id="tabbedCharts">
        <div id="detailCharts" class="box tabbed chart activeTabbed">
          <table>
            <tr>
              <td width="50%" valign="top">
                <div id="listChart">
                  <div style="margin: 1em"><img src="/loader.gif" alt="Loading..."></div>
                </div>
              </td>
              <td width="50%" valign="top">
                <div id="mapChart"></div>
              </td>
            </tr>
          </table>
        </div>
        <div id="statsCharts" class="box tabbed chart">
          <table>
            <tr>
              <td width="50%" valign="top" class="statsLeft">
                <h3>Format</h3>
                <ul>
                  <li>Created on: <%= format.getCreatedDate() %></li>
                  <li>Namespace: <%= format.getNamespace() %></li>
                </ul>
                <h3>Documents</h3>
                <div id="statsChart" style="width:50%; height:90%"></div>
              </td>
              <td width="50%">
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </body>
</html>
