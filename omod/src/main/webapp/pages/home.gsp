<%
    ui.decorateWith("appui", "standardEmrPage", [ title: ui.message("referenceapplication.home.title") ])

    def htmlSafeId = { extension ->
        "${ extension.id.replace(".", "-") }-${ extension.id.replace(".", "-") }-extension"
    }
%>

<div id="home-container">

    ${ ui.includeFragment("coreapps", "administrativenotification/notifications") }

    <% if (authenticatedUser) { %>
        <h4>
            ${ ui.encodeHtmlContent(ui.message("referenceapplication.home.currentUser", ui.format(authenticatedUser), ui.format(sessionContext.sessionLocation))) }
        </h4>
    <% } else { %>
        <h4>
            <a href="login.htm">${ ui.message("referenceapplication.home.logIn") }</a>
        </h4>
    <% } %>

    <div id="apps" class="row">
      <div class="extensions_wrap">
        <% extensions.each { ext -> %>
        <div class="col-lg-2 col-md-3 extension_div">
            <a id="${ htmlSafeId(ext) }" href="/${ contextPath }/${ ext.url }" class="thumbnail btn btn-primary">
                <% if (ext.icon) { %>
                   <i class="${ ext.icon }"></i>
                <% } %>
                <span>${ ui.message(ext.label) }</span>
            </a>
            </div>
        <% } %>
        <div class="clear"></div>
        </div>
    </div>

</div>
